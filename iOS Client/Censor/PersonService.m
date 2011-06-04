//
//  PersonService.m
//  Censor
//
//  Created by Nicolas Ameghino on 03/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "PersonService.h"


static PersonService* sharedPersonService;

@implementation PersonService

- (Person*) createPerson {
	Person *p = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];
	p.uploaded = [NSNumber numberWithBool:NO];
	return p;
}

-(BOOL) savePerson:(Person *) person withError:(NSError**) error {
	return [context save:error];	
}

-(BOOL) sendPerson:(Person*) person toHost:(NSURL*) hostURL withError:(NSError**) error {
	
	if (![self savePerson:person withError:error]) {
		return NO;
	}
	
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"?%@", 
									   [[person queryStringParameters] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
						relativeToURL:hostURL];
	
	NSURLResponse *response = nil;
	NSLog(@"Sending data to:\n%@", [url absoluteString]);
	[NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:url]
						  returningResponse:&response error:error];
	
	if (*error != nil) {
		return NO;
	} else {
		return YES;
	}
}

- (id)init {
    self = [super init];
    if (self) {
        context = [((CensorAppDelegate*)[UIApplication sharedApplication].delegate) managedObjectContext];
    }
    return self;
}

+(PersonService*) sharedInstance {
	if (sharedPersonService == nil) {
		sharedPersonService = [[PersonService alloc] init];
	}
	return sharedPersonService;
}



@end
