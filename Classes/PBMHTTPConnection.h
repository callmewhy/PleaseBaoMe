//
//  PBMHTTPConnection.h
//  PleaseBaoMe
//
//  Created by why on 7/7/15.
//  Copyright (c) 2015 why. All rights reserved.
//

#import "CHSHTTPConnection.h"

@interface PBMHTTPConnection : CHSHTTPConnection

/**
 *  Set the Database file path.
 *
 *  @param path db file path.
 */
+(void)setDBFilePath:(NSString*)path;

@end
