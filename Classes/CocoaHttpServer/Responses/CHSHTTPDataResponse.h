#import <Foundation/Foundation.h>
#import "CHSHTTPResponse.h"


@interface CHSHTTPDataResponse : NSObject <CHSHTTPResponse>
{
	NSUInteger offset;
	NSData *data;
}

- (id)initWithData:(NSData *)data;

@end
