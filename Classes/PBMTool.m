//
//  PBMTool.m
//  PleaseBaoMe
//
//  Created by why on 7/8/15.
//  Copyright (c) 2015 why. All rights reserved.
//

#import "CHSHTTPServer.h"

#import "PBMTool.h"
#import "PBMHTTPConnection.h"
#import "PBMIPTool.h"

@interface PBMTool()
@property (nonatomic, strong) CHSHTTPServer *httpServer;
@end

@implementation PBMTool

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

+(void)start {
    [[self sharedInstance] start];
}

+(void)setDBFilePath:(NSString*)path {
    [PBMHTTPConnection setDBFilePath:path];
}

+(NSString*)URL {
    return [NSString stringWithFormat:@"%@:%hu", [PBMIPTool IPAddress], [[PBMTool sharedInstance].httpServer listeningPort]];
}

-(void)start {
    if (_httpServer) {
        return;
    }
    _httpServer = [[CHSHTTPServer alloc] init];
    [_httpServer setConnectionClass:[PBMHTTPConnection class]];
    [_httpServer setType:@"_http._tcp."];
    [_httpServer setPort:12345];
    NSString *webPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Web.bundle"];
    [_httpServer setDocumentRoot:webPath];
    
    NSError *error;
    if([_httpServer start:&error]) {
        NSLog(@"You can see you SQLite in %@", [PBMTool URL]);
    } else {
        NSLog(@"Error starting HTTP Server: %@", error);
    }
    
}

@end
