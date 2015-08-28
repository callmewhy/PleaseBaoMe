//
//  PBMHTTPConnection.m
//  PleaseBaoMe
//
//  Created by why on 7/7/15.
//  Copyright (c) 2015 why. All rights reserved.
//



#import <FMDB/FMDB.h>
#import "CHSHTTPDynamicFileResponse.h"
#import "PBMHTTPConnection.h"
#import "PBMHTMLBuilder.h"


static NSString *kDBPath;

@implementation PBMHTTPConnection
#pragma mark - HTTPConnection Override
- (NSObject<CHSHTTPResponse> *)httpResponseForMethod:(NSString *)method URI:(NSString *)path {
    NSString *sqlStr = [[path lastPathComponent] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    // handle normal request without spaces
    if ([sqlStr componentsSeparatedByString:@" "].count == 1 && sqlStr.length > 1) {
        return [super httpResponseForMethod:method URI:path];
    }
    
    // if database file not exist
    if (![[NSFileManager defaultManager] fileExistsAtPath:kDBPath]) {
        NSLog(@"DB Error: DB file not exist!");
        return nil;
    }
    
    // open database
    FMDatabase *db = [FMDatabase databaseWithPath:kDBPath];
    if (![db open]) {
        return nil;
    }
    
    // table name list
    NSArray *tableNames = [self htmlForTableNameListWithDB:db];
    NSString *tableListHTML = [PBMHTMLBuilder getTableListWithTables:tableNames];
    
    // current table name
    NSString *tableName = @"Select Table";
    NSArray *sqlWords = [sqlStr componentsSeparatedByString:@" "];
    for (int i = 0; i < sqlWords.count; i++) {
        NSString *word = sqlWords[i];
        if ([word.lowercaseString isEqualToString:@"from"]) {
            tableName = sqlWords[++i];
            break;
        }
    }
    
    // table content
    NSString *tableContentHTML = [self getTableContentWithDB:db andSQL:sqlStr];
    
    // close database
    [db close];

    return [[CHSHTTPDynamicFileResponse alloc] initWithFilePath:[self filePathForURI:@"/index.html"]
                                               forConnection:self
                                                   separator:@"%%"
                                       replacementDictionary:@{ @"SQL_QUERY": sqlStr,
                                                                @"TABLE_NAME": tableName,
                                                                @"TABLE_NAME_LIST": tableListHTML,
                                                                @"PLEASE_BAO_ME": tableContentHTML
                                                                }];
    
    return nil;
}


#pragma mark - Private
-(NSArray*)htmlForTableNameListWithDB:(FMDatabase*)db {
    FMResultSet *s = [db executeQuery:@"SELECT name FROM sqlite_master WHERE type = 'table'"];
    NSMutableArray *tableNameArray = [NSMutableArray array];
    while ([s next]) {
        [tableNameArray addObject:[s stringForColumnIndex:0]];
    }
    return tableNameArray;
}


-(NSString*)getTableContentWithDB:(FMDatabase*)db andSQL:(NSString*)sql {
    FMResultSet *s = [db executeQuery:sql];
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
    NSMutableOrderedSet *cols = [NSMutableOrderedSet orderedSet];
    while ([s next]) {
        for (int i = 0; i < s.columnCount; i++) {
            NSString *colName = [s columnNameForIndex:i];
            NSString *value     = [NSString stringWithFormat:@"%@", [s objectForColumnIndex:i]];
            NSMutableArray *array = [NSMutableArray arrayWithArray:resultDic[colName]];
            [array addObject:value];
            resultDic[colName] = array;
            [cols addObject:colName];
        }
    }
    return [PBMHTMLBuilder getTableContentWithHeaders:[cols array] andContent:resultDic];
}


#pragma mark - Public
+(void)setDBFilePath:(NSString*)path {
    kDBPath = path;
}
@end
