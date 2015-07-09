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
    
    NSString *sql = @"CREATE TABLE nothing (id integer primary key autoincrement, a, b, c, d, e);"
                    "CREATE TABLE test_table (a TEXT, b INTEGER, c INTEGER, d NULL, e TEXT);"
                    "INSERT INTO test_table (a, b, c, d, e) VALUES ('TEST', 2333, 'A studio-style cabin is all one level, with one spacious room consisting of the living room, the bedroom and the kitchen. The gorgeous living room here has a warm wood burning fireplace, WIFI and a TV with Comcast cable service. The comfy king size bed will invite you to stretch out and rest your tired muscles. Or soak those cares away in the uniquely-shaped whirlpool Jacuzzi tub beside the bed or the big, bubbling hot tub on the wooden deck outside. The bathroom is in a separate, closed-in room for privacy.', 'test_table', 'TEST');"
                    "CREATE TABLE bao (id integer primary key autoincrement, name);"
                    "INSERT INTO bao (name) VALUES ('bao');"
                    "INSERT INTO bao (name) VALUES ('dmj');"
                    "INSERT INTO bao (name) VALUES ('why');";
    
    [db executeStatements:sql];
}


@end
