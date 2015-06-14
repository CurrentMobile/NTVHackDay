//
//  FormValidationViewModel.h
//  EventBrite
//
//  Created by Anthony Hoang on 6/12/15.
//  Copyright (c) 2015 Anthony Hoang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FormValidationProtocol.h"

@interface FormValidationViewModelImplementation : NSObject<FormValidationProtocol>

/**
 *  The view should update this property with text the user enters for email.
 */
@property (nonatomic, strong) NSString *email;

/**
 *  The view should update this proeprty with text the user enters for password.
 */
@property (nonatomic, strong) NSString *password;

/**
 *  The view should bind the login button's raccommand to this property.
 */
@property (nonatomic, strong) RACCommand *loginCommand;

/**
 *  The view should bind to this proeprty and display the text fields with this text color
 */
@property (nonatomic, strong) UIColor *emailTextColor;
@property (nonatomic, strong) UIColor *passwordTextColor;


@end
