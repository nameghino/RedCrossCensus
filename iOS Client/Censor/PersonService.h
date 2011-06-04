//
//  PersonService.h
//  Censor
//
//  Created by Nicolas Ameghino on 03/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Person+ServiceQueryString.h"

@class CensorAppDelegate;
@interface PersonService : NSObject {
	@private
	NSManagedObjectContext *context;
}

+(PersonService*) sharedInstance;

-(Person*) createPerson;
-(BOOL) savePerson:(Person *) person withError:(NSError**) error;
-(BOOL) sendPerson:(Person*) person toHost:(NSURL*) hostURL withError:(NSError**) error;

@end
