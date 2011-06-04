//
//  Person+ServiceQueryString.h
//  Censor
//
//  Created by Nicolas Ameghino on 04/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@interface Person (Person_ServiceQueryString)

-(NSString*) queryStringParameters;

@end
