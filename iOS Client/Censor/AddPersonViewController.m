//
//  AddPersonViewController.m
//  Censor
//
//  Created by Nicolas Ameghino on 04/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddPersonViewController.h"


@implementation AddPersonViewController

@synthesize firstNameTextField;
@synthesize lastNameTextField;
@synthesize identifierTextField;
@synthesize addressTextField;
@synthesize phoneNumberTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Action handling

-(void)save:(id)sender {
	Person *p = [[PersonService sharedInstance] createPerson];
	p.firstName = self.firstNameTextField.text;
	p.lastName = self.lastNameTextField.text;
	p.address = self.addressTextField.text;
	p.idNumber = [NSNumber numberWithLongLong:[self.identifierTextField.text longLongValue]];
	p.phoneNumber = self.phoneNumberTextField.text;
	
	NSError* error = nil;
	if ([[PersonService sharedInstance] savePerson:p withError:&error]) {
		NSLog(@"Saved successfully");
	} else {
		NSLog(@"Error saving: %@", [error localizedDescription]);
	}
}



@end
