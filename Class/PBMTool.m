//
//  PBMTool.m
//  PleaseBaoMe
//
//  Created by why on 7/8/15.
//  Copyright (c) 2015 why. All rights reserved.
//

#import "PBMTool.h"
#import "PBMHTTPConnection.h"
#import "PBMIPTool.h"

@interface PBMTool()
@property (nonatomic, strong) HTTPServer *httpServer;
@end

@implementation PBMTool

-(void)start {
    _httpServer = [[HTTPServer alloc] init];
    [_httpServer setConnectionClass:[PBMHTTPConnection class]];
    [_httpServer setType:@"_http._tcp."];
    [_httpServer setPort:12345];
    [_httpServer setDocumentRoot:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Web"]];
    
    NSError *error;
    if([_httpServer start:&error]) {
        NSLog(@"You can see you SQLite in %@:%hu", [PBMIPTool IPAddress], [_httpServer listeningPort]);
    } else {
        NSLog(@"Error starting HTTP Server: %@", error);
    }
    
}

+(void)start {
    [[self sharedInstance] start];
}

+ (PBMTool *)sharedInstance {
    static PBMTool *sharedPBMTool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @synchronized(self){
            sharedPBMTool = [[self alloc] init];
        }
    });
    return sharedPBMTool;
}

+(void)setDBFilePath:(NSString*)path {
    [PBMHTTPConnection setDBFilePath:path];
}

@end
