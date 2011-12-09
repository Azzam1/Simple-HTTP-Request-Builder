//
//  HTTPRequest.m
//  Video Recording
//
//  Created by Azzam on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HTTPRequest.h"


@implementation HTTPRequest
@synthesize request, requestServerURL;


- (id) init
{
	if ((self = [super init])) {
		self.requestServerURL = [[NSString alloc] initWithString:SERVERURL];
		self.request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.requestServerURL]];
		requestBody = [[NSMutableData alloc] init];
//		[requestBody appendData:[[NSString stringWithFormat:@"--%@\r\n", BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
		[self.request setHTTPMethod:@"POST"];
		NSString *headerBoundary = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",BOUNDARY];	
		// set header
		[self.request addValue:headerBoundary forHTTPHeaderField:@"Content-Type"];
	}
	return self;
}

- (void) addTextPart:(NSString *)textValue name:(NSString *)partName
{
	[requestBody appendData:[[NSString stringWithFormat:@"--%@\r\n", BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
	[requestBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",partName] dataUsingEncoding:NSUTF8StringEncoding]];
	[requestBody appendData:[textValue dataUsingEncoding:NSUTF8StringEncoding]];
	[requestBody appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
}

- (void) addFilePart:(NSData *)fileContent fileType:(NSString *)fType fileName:(NSString *)fName
{
	NSString *contentType = [NSString stringWithFormat:@"Content-Type: %@\r\n\r\n",fType];
	NSString *contentDisposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"\r\n",fName];
	[requestBody appendData:[[NSString stringWithFormat:@"--%@\r\n", BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
	[requestBody appendData:[contentDisposition dataUsingEncoding:NSUTF8StringEncoding]];
	[requestBody appendData:[contentType dataUsingEncoding:NSUTF8StringEncoding]];
	[requestBody appendData:[NSData dataWithData:fileContent]];
	[requestBody appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
}

- (NSData *) sendRequest
{
	[requestBody appendData:[[NSString stringWithFormat:@"--%@--\r\n", BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
	[self.request setHTTPBody:requestBody];
	
	NSURLResponse *response;
	NSError *error;
	NSData *reply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	
	return reply;
}

- (void) dealloc
{
	[request release];
	[requestBody release];
	[requestServerURL release];
	[super dealloc];
}

@end
