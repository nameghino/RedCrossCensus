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
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	NSMutableArray *personQueue = [[[PersonService sharedInstance] unsentPeople] mutableCopy];
	
	if (![self savePerson:person withError:error]) {
		return NO;
	}
	
	for (Person *person in personQueue) {
		hostURL = [NSURL URLWithString:@"https://spreadsheets0.google.com/macros/exec"];
		
		NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"?service=AKfycbzXX2Ubqch6Sj2DvQ9F7hC5PobrbYv_qcE&%@", 
										   [[person queryStringParameters] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
							relativeToURL:hostURL];
		
		NSURLResponse *response = nil;
		NSLog(@"Sending data to:\n%@", [url absoluteString]);
		[NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:url]
							  returningResponse:&response error:error];
		
		if (*error != nil) {
			break;
		} else {
			person.uploaded = [NSNumber numberWithBool:YES];
		}
		
	}
	BOOL retval = NO;
	if (*error == nil) {
		retval = YES;
	} 
	[pool release];
	return retval;
}

- (void)asyncSendPerson:(Person*) person toHost:(NSURL*) hostURL delegate:(id<SendPersonActionDelegate>) delegate { 
	dispatch_queue_t myQueue = dispatch_queue_create("org.redcross.queue", 0);
	dispatch_async(myQueue, ^{
		NSError *error = nil;
		if ([self sendPerson:person toHost:hostURL withError:&error]) {
			[delegate sendOperationDidFinish:person];
		} else {
			[delegate sendOperation:person didFailWithError:error];
		}
	});
}

-(NSArray*) allPeople {
	NSManagedObjectContext *moc = context;
	NSEntityDescription *entityDescription = [NSEntityDescription
											  entityForName:@"Person" inManagedObjectContext:moc];
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	[request setEntity:entityDescription];
	
	NSError *error = nil;
	NSArray *array = [moc executeFetchRequest:request error:&error];
	if (error == nil) {
		return array;
	} else {
		return nil;
	}
}

-(NSArray*) unsentPeople {
	NSManagedObjectContext *moc = context;
	NSEntityDescription *entityDescription = [NSEntityDescription
											  entityForName:@"Person" inManagedObjectContext:moc];
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	[request setEntity:entityDescription];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat: @"(uploaded = %@)", [NSNumber numberWithBool:NO]];
	[request setPredicate:predicate];
	
	NSError *error = nil;
	NSArray *array = [moc executeFetchRequest:request error:&error];
	if (error == nil) {
		return array;
	} else {
		return nil;
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
