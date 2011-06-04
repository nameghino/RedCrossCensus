//
//  AddPersonViewController.h
//  Censor
//
//  Created by Nicolas Ameghino on 04/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
#import "PersonService.h"

@interface AddPersonViewController : UIViewController {
	UITextField *firstNameTextField;
	UITextField *lastNameTextField;
	UITextField *identifierTextField;
	UITextField *addressTextField;
	UITextField *phoneNumberTextField;
}

@property(nonatomic, retain) IBOutlet UITextField *firstNameTextField;
@property(nonatomic, retain) IBOutlet UITextField *lastNameTextField;
@property(nonatomic, retain) IBOutlet UITextField *identifierTextField;
@property(nonatomic, retain) IBOutlet UITextField *addressTextField;
@property(nonatomic, retain) IBOutlet UITextField *phoneNumberTextField;

-(IBAction) cancelOperation:(id) sender;
-(IBAction) save:(id) sender;
-(IBAction) saveAndContinue:(id) sender;

@end
