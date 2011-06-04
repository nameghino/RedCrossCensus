//
//  MainMenuViewController.h
//  Censor
//
//  Created by Nicolas Ameghino on 04/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddPersonViewController.h"
#import "PeopleListViewController.h"

@interface MainMenuViewController : UIViewController {
    
}

-(IBAction) showAddPeopleInterface:(id)sender;
-(IBAction) showPeopleListInterface:(id) sender;

@end
