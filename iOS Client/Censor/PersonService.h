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

//https://spreadsheets0.google.com/macros/exec?service=AKfycbzXX2Ubqch6Sj2DvQ9F7hC5PobrbYv_qcE&

@class CensorAppDelegate;

@protocol SendPersonActionDelegate <NSObject>
-(void) sendOperationDidFinish:(Person*) p;
-(void) sendOperation:(Person*) p didFailWithError:(NSError*) error;
@end

@interface PersonService : NSObject {
	@private
	NSManagedObjectContext *context;
}

+(PersonService*) sharedInstance;

-(Person*) createPerson;
-(NSArray*) allPeople;
-(NSArray*) unsentPeople;
-(BOOL) savePerson:(Person *) person withError:(NSError**) error;
-(BOOL) sendPerson:(Person*) person toHost:(NSURL*) hostURL withError:(NSError**) error;
-(void)asyncSendPerson:(Person*) person toHost:(NSURL*) hostURL delegate:(id<SendPersonActionDelegate>) delegate;

@end
