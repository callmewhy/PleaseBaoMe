//
//  MultipartMessagePart.m
//  HttpServer
//
//  Created by Валерий Гаврилов on 29.03.12.
//  Copyright (c) 2012 LLC "Online Publishing Partners" (onlinepp.ru). All rights reserved.

#import "CHSMultipartMessageHeader.h"
#import "CHSMultipartMessageHeaderField.h"

#import "CHSHTTPLogging.h"

//-----------------------------------------------------------------
// implementation CHSMultipartMessageHeader
//-----------------------------------------------------------------


@implementation CHSMultipartMessageHeader
@synthesize fields,encoding;


- (id) initWithData:(NSData *)data formEncoding:(NSStringEncoding) formEncoding {
	if( nil == (self = [super init]) ) {
        return self;
    }
	
	fields = [[NSMutableDictionary alloc] initWithCapacity:1];

	// In case encoding is not mentioned,
	encoding = contentTransferEncoding_unknown;

	char* bytes = (char*)data.bytes;
	NSInteger length = data.length;
	NSInteger offset = 0;

	// split header into header fields, separated by \r\n
	uint16_t fields_separator = 0x0A0D; // \r\n
	while( offset < length - 2 ) {

		// the !isspace condition is to support header unfolding
		if( (*(uint16_t*) (bytes+offset)  == fields_separator) && ((offset == length - 2) || !(isspace(bytes[offset+2])) )) {
			NSData* fieldData = [NSData dataWithBytesNoCopy:bytes length:offset freeWhenDone:NO];
			CHSMultipartMessageHeaderField * field = [[CHSMultipartMessageHeaderField alloc] initWithData: fieldData  contentEncoding:formEncoding];
			if( field ) {
				[fields setObject:field forKey:field.name];
				HTTPLogVerbose(@"CHSMultipartFormDataParser: Processed Header field '%@'",field.name);
			}
			else {
				NSString* fieldStr = [[NSString  alloc] initWithData:fieldData encoding:NSASCIIStringEncoding];
				HTTPLogWarn(@"CHSMultipartFormDataParser: Failed to parse MIME header field. Input ASCII string:%@",fieldStr);
			}

			// move to the next header field
			bytes += offset + 2;
			length -= offset + 2;
			offset = 0;
			continue;
		}
		++ offset;
	}
	
	if( !fields.count ) {
		// it was an empty header.
		// we have to set default values.
		// default header.
		[fields setObject:@"text/plain" forKey:@"Content-Type"];
	}

	return self;
}

- (NSString *)description {	
	return [NSString stringWithFormat:@"%@",fields];
}


@end
