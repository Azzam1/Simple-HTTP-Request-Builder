//
//  HTTPRequest.h
//  Video Recording
//
//  Created by Azzam on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SERVERURL @"http://your.server.url"
#define BOUNDARY @"------WebKitFormBoundaryjF9WZAf33Arb7mQ9"
#define MOVIE_FILE @"video/quicktime"

@interface HTTPRequest : NSObject {
    NSString *requestServerURL;
	NSMutableURLRequest *request;
	NSMutableData *requestBody;
	
}

@property (nonatomic, retain) NSString *requestServerURL;
@property (nonatomic, retain) NSMutableURLRequest *request;

- (id)			init;

- (void)		addTextPart:(NSString *)textValue name:(NSString *)partName;
- (void)		addFilePart:(NSData *)fileContent fileType:(NSString *)fType fileName:(NSString *)fName;
- (NSData *)	sendRequest;

@end
