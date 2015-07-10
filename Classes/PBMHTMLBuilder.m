//
//  PBMHTMLBuilder.m
//  PleaseBaoMe
//
//  Created by why on 7/7/15.
//  Copyright (c) 2015 why. All rights reserved.
//

#import "PBMHTMLBuilder.h"

@implementation PBMHTMLBuilder

+(NSString*)getTableListWithTables:(NSArray*)tables {
    NSMutableString *result = [NSMutableString string];
    for (NSString *tableName in tables) {
        [result appendFormat:@"<li><a href='/SELECT * FROM %@'>%@</a></li>", tableName, tableName];
    }
    return result;
}

+(NSString *)getTableContentWithHeaders:(NSArray *)headers andContent:(NSDictionary *)dictionary {
    if (dictionary.allValues.count < 1) {
        return @"";
    }
    NSArray *fisrtArray = dictionary.allValues[0];
    NSInteger lines = fisrtArray.count;
    NSMutableString *pageSource = [NSMutableString string];
    
    // build table header
    [pageSource appendFormat:@"<thead><tr>"];
    for (NSString *key in headers) {
        [pageSource appendFormat:@"<th>%@</th>", key];
    }
    [pageSource appendFormat:@"</tr></thead>"];
    
    // build table
    [pageSource appendFormat:@"<tbody>"];
    for (int i = 0; i < lines; i++) {
        [pageSource appendFormat:@"<tr>"];
        for (int j = 0; j < headers.count; j++) {
            NSString *colName = headers[j];
            NSArray *tempArray = dictionary[colName];
            [pageSource appendFormat:@"<td>%@</td>", tempArray[i]];
        }
        [pageSource appendFormat:@"</tr>"];
    }
    [pageSource appendFormat:@"</tbody>"];
    return pageSource;
}



@end
