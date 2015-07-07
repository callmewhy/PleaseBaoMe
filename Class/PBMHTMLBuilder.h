//
//  PBMHTMLBuilder.h
//  PleaseBaoMe
//
//  Created by why on 7/7/15.
//  Copyright (c) 2015 why. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PBMHTMLBuilder : NSObject

/**
 *  Build Table Name List HTML
 *
 *  @param tables @[@"table1", @"table2"]
 *
 *  @return \<li><a href='#'>%@</a></li>
 */
+(NSString *)getTableListWithTables:(NSArray*)tables;


/**
 *  Build table content
 *
 *  @param headers    @[@"table1", @"table2"]
 *  @param dictionary @{@"table1":@[@"1", @"2"], @"table2":@[@"3", @"4"]}
 *
 *  @return 
 */
+(NSString *)getTableContentWithHeaders:(NSArray*)headers andContent:(NSDictionary*)dictionary;

@end
