//
//  Person.h
//  Censor
//
//  Created by Nicolas Ameghino on 04/06/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Person : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSNumber * idNumber;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * uploaded;
@property (nonatomic, retain) NSNumber * cardNumber;
@property (nonatomic, retain) NSString * phoneNumber;

@end
