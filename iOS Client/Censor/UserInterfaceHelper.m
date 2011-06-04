//
//  UserInterfaceHelper.m
//  Censor
//
//  Created by Nicolas Ameghino on 04/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UserInterfaceHelper.h"


@implementation UserInterfaceHelper

+(void) handleError:(NSError*) error withDelegate:(id<UIAlertViewDelegate>) delegate {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error"
													message: [error localizedDescription]
												   delegate: delegate
										  cancelButtonTitle:@"Aceptar"
//										  cancelButtonTitle: NSLocalizedString(@"__ERROR_CANCEL_BUTTON_TITLE", 
//																			  @"Default title for acknowledgement that an error ocurred") 
										  otherButtonTitles: nil];
	[[alert autorelease] show];
}

+(void)showAlertWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle: title
													message: message
												   delegate: delegate
										  cancelButtonTitle:@"Aceptar"
//										  cancelButtonTitle: NSLocalizedString(@"__MESSAGE_CANCEL_BUTTON_TITLE", 
//																			   @"Default title for acknowledgement that a message was displayed") 
										  otherButtonTitles: nil];
	[[alert autorelease] show];
}
@end
