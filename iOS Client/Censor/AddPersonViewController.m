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

static NSArray *fieldOrder;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
	self.navigationItem.title = @"Alta de persona";
	fieldOrder = [[NSArray alloc] initWithObjects:identifierTextField,
				  firstNameTextField, lastNameTextField, 
				  addressTextField, phoneNumberTextField, nil];
	
	for (UITextField* tf in fieldOrder) {
		tf.delegate = self;
	}
	
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
#pragma mark TextField Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
	for (int i=0; i < [fieldOrder count]; ++i) {
		if (textField.returnKeyType == UIReturnKeyDone) {
			[textField resignFirstResponder];
			[self saveAndContinue:self];
			return YES;
		}
		if (textField == [fieldOrder objectAtIndex:i]) {
			[[fieldOrder objectAtIndex:i+1] becomeFirstResponder];
			return NO;
		}
	}
	return YES;
}

#pragma mark -
#pragma mark Action handling
-(void)clearTextfields {
	for (UITextField* tf in fieldOrder) {
		tf.text = nil;
	}
}

-(void)save:(id)sender {
	Person *p = [[PersonService sharedInstance] createPerson];
	p.firstName = self.firstNameTextField.text;
	p.lastName = self.lastNameTextField.text;
	p.address = self.addressTextField.text;
	p.idNumber = [NSNumber numberWithLongLong:[self.identifierTextField.text longLongValue]];
	p.phoneNumber = self.phoneNumberTextField.text;
	p.cardNumber = [NSNumber numberWithLong:random()];

	NSError* error = nil;
	
	[[PersonService sharedInstance] asyncSendPerson:p toHost:nil delegate:self];
	
	if ([[PersonService sharedInstance] savePerson:p withError:&error]) {
		NSLog(@"Saved successfully");
		[UserInterfaceHelper showAlertWithTitle:(p.uploaded ? @"Guardado y enviado" : @"Guardado") message:nil delegate:nil];
	} else {
		NSLog(@"Error saving: %@", [error localizedDescription]);
		[UserInterfaceHelper handleError:error withDelegate:nil];
	}
}

-(void)saveAndFinish:(id) sender {
	[self save:sender];
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)saveAndContinue:(id)sender {
	[self save:sender];
	[self clearTextfields];
}

-(void)cancelOperation:(id)sender {
	[self clearTextfields];
}

#pragma mark -
#pragma mark Send Person Action Delegate

-(void)sendOperationDidFinish:(Person *)p {
	p.uploaded = [NSNumber numberWithBool:YES];
	[[PersonService sharedInstance] savePerson:p withError:nil];
}

-(void)sendOperation:(Person *)p didFailWithError:(NSError *)error {
	NSLog(@"Error \"%@\" sending \"%@, %@\"", [error localizedDescription], p.lastName, p.firstName);
}
@end
