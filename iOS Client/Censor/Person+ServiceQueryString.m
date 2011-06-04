//
//  Person+ServiceQueryString.m
//  Censor
//
//  Created by Nicolas Ameghino on 04/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Person+ServiceQueryString.h"


@implementation Person (Person_ServiceQueryString)

-(NSString*) queryStringParameters {
	return [NSString stringWithFormat:@"name=%@ %@&address=%@&dni=%@&phone=%@&cardId=%@", 
			self.lastName, self.firstName, self.address, self.idNumber, self.phoneNumber, self.cardNumber];
}

@end
