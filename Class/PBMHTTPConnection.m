//
//  PBMHTTPConnection.m
//  PleaseBaoMe
//
//  Created by why on 7/7/15.
//  Copyright (c) 2015 why. All rights reserved.
//

#import "PBMHTTPConnection.h"
#import "HTTPDynamicFileResponse.h"
#import "FMDB.h"
#import "PBMHTMLBuilder.h"


static NSString *kDBPath;

@implementation PBMHTTPConnection
#pragma mark - HTTPConnection Override
- (NSObject<HTTPResponse> *)httpResponseForMethod:(NSString *)method URI:(NSString *)path {
    // handle normal request
    if ([[path lastPathComponent] componentsSeparatedByString:@"."].count > 1) {
        return [super httpResponseForMethod:method URI:path];
    }
    
    // open database
    FMDatabase *db = [FMDatabase databaseWithPath:kDBPath];
    if (![db open]) {
        return nil;
    }
    
    // table name
    NSArray *tableNames = [self htmlForTableNameListWithDB:db];
    NSString *tableListHTML = [PBMHTMLBuilder getTableListWithTables:tableNames];
    NSString *tableName = [path lastPathComponent];
    if (tableName.length <= 1) {
        tableName = tableNames[0];
    }
    
    // table content
    NSString *tableContentHTML = [self getTableContentWithDB:db andTableName:tableName];
    
    
    
    
    // close database
    [db close];

    return [[HTTPDynamicFileResponse alloc] initWithFilePath:[self filePathForURI:@"/index.html"]
                                               forConnection:self
                                                   separator:@"%%"
                                       replacementDictionary:@{ @"TABLE_NAME": tableName,
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


-(NSString*)getTableContentWithDB:(FMDatabase*)db andTableName:(NSString*)tableName {
    NSString *q = [NSString stringWithFormat:@"SELECT * FROM %@", tableName];
    FMResultSet *s = [db executeQuery:q];
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
    NSMutableOrderedSet *cols = [NSMutableOrderedSet orderedSet];
    while ([s next]) {
        for (int i = 0; i < s.columnCount; i++) {
            NSString *colName = [s columnNameForIndex:i];
            NSString *value     = [s stringForColumnIndex:i];
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
