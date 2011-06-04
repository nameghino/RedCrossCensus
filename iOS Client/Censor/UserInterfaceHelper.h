//
//  UserInterfaceHelper.h
//  Censor
//
//  Created by Nicolas Ameghino on 04/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserInterfaceHelper : NSObject {
    
}

+(void) handleError:(NSError*) error withDelegate:(id<UIAlertViewDelegate>) delegate;
+(void) showAlertWithTitle:(NSString*) title message:(NSString*) message delegate:(id<UIAlertViewDelegate>) delegate;

@end
