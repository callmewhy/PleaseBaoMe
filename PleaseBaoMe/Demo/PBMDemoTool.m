//
//  PBMDemoTool.m
//  PleaseBaoMe
//
//  Created by why on 7/7/15.
//  Copyright (c) 2015 why. All rights reserved.
//

#import "PBMDemoTool.h"
#import "FMDB.h"
#import "PBMTool.h"

@implementation PBMDemoTool

+(void)setupDemoData {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"demo.db"];
    [PBMTool setDBFilePath:writableDBPath];
    
    FMDatabase* db = [FMDatabase databaseWithPath:writableDBPath];
    if (![db open]) {
        return;
    }
    
    NSMutableString *sql = [[NSMutableString alloc] initWithString:@"CREATE TABLE nothing (id integer primary key autoincrement, a, b, c, d, e);"
                    "CREATE TABLE bao (id integer primary key autoincrement, name);"
                    "INSERT INTO bao (name) VALUES ('bao');"
                    "INSERT INTO bao (name) VALUES ('dmj');"
                    "INSERT INTO bao (name) VALUES ('why');"
                    "CREATE TABLE test_table (id integer primary key autoincrement, a TEXT, b INTEGER, c INTEGER, d NULL, e TEXT);" ];
    
    NSString *randomString = @"INSERT INTO test_table (a, b, c, d, e) VALUES ('TEST', 2333, '%@', 'test_table', 'TEST');";
    for (int i = 0; i < 100; i ++) {
        [sql appendFormat:randomString, [PBMDemoTool randomStringWithLength:arc4random() % 100]];
    }
    [db executeStatements:sql];
    [db close];
}

NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

+(NSString *)randomStringWithLength:(int)len {
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex:arc4random() % letters.length]];
    }
    
    return randomString;
}

@end
