//
//  PeopleListViewController.h
//  Censor
//
//  Created by Nicolas Ameghino on 04/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonService.h"

@interface PeopleListViewController : UITableViewController {
    NSArray *people;
}

@property(nonatomic, retain) NSArray* people;

@end
