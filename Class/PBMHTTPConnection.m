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

static NSString *kDBPath;

@implementation PBMHTTPConnection
#pragma mark - HTTPConnection Override
- (NSObject<HTTPResponse> *)httpResponseForMethod:(NSString *)method URI:(NSString *)path {
    NSString *filePath = [self filePathForURI:path];
    NSString *documentRoot = [config documentRoot];
    NSString *pageSource = @"";
    if (![filePath hasPrefix:documentRoot]) {
        return nil;
    }

    FMDatabase *db = [FMDatabase databaseWithPath:kDBPath];
    if (![db open]) {
        return nil;
    }
    
    FMResultSet *s = [db executeQuery:@"SELECT count(*) FROM bao"];
    if ([s next]) {
        int totalCount = [s intForColumnIndex:0];
        pageSource = [NSString stringWithFormat:@"%d", totalCount];
    }
    
    return [[HTTPDynamicFileResponse alloc] initWithFilePath:[self filePathForURI:path]
                                               forConnection:self
                                                   separator:@"%%"
                                       replacementDictionary:@{@"PLEASE_BAO_ME": pageSource}];
    
    return nil;
}


#pragma mark - Public
+(void)setDBFilePath:(NSString*)path {
    kDBPath = path;
}
@end
