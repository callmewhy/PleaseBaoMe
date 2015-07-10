#import <Foundation/Foundation.h>
#import "CHSHTTPResponse.h"


@interface CHSHTTPRedirectResponse : NSObject <CHSHTTPResponse>
{
	NSString *redirectPath;
}

- (id)initWithPath:(NSString *)redirectPath;

@end
