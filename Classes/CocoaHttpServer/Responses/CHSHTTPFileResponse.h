#import <Foundation/Foundation.h>
#import "CHSHTTPResponse.h"

@class CHSHTTPConnection;


@interface CHSHTTPFileResponse : NSObject <CHSHTTPResponse>
{
	CHSHTTPConnection *connection;
	
	NSString *filePath;
	UInt64 fileLength;
	UInt64 fileOffset;
	
	BOOL aborted;
	
	int fileFD;
	void *buffer;
	NSUInteger bufferSize;
}

- (id)initWithFilePath:(NSString *)filePath forConnection:(CHSHTTPConnection *)connection;
- (NSString *)filePath;

@end
