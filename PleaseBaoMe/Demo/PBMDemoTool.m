//
//  PBMDemoTool.m
//  PleaseBaoMe
//
//  Created by why on 7/7/15.
//  Copyright (c) 2015 why. All rights reserved.
//

#import "PBMDemoTool.h"
#import "FMDB.h"
#import "PBMHTTPConnection.h"

@implementation PBMDemoTool

+(void)setupDemoData {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"demo.db"];
    [PBMHTTPConnection setDBFilePath:writableDBPath];
    
    FMDatabase* db = [FMDatabase databaseWithPath:writableDBPath];
    if (![db open]) {
        return;
    }
    NSString *sql = @"create table bao (id integer primary key autoincrement, name);"
    "insert into bao (name) values ('bao');"
    "insert into bao (name) values ('dmj');"
    "insert into bao (name) values ('why');";
    
    [db executeStatements:sql];
}


@end
