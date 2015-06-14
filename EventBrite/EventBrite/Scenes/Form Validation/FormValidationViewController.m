//
//  FormValidationViewController.m
//  EventBrite
//
//  Created by Anthony Hoang on 6/12/15.
//  Copyright (c) 2015 Anthony Hoang. All rights reserved.
//

#import "FormValidationViewController.h"
#import "FormValidationViewModelImplementation.h"

@implementation FormValidationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewModel = [FormValidationViewModelImplementation new];
    
    RAC(self, viewModel.email) = self.emailTextField.rac_textSignal;
    RAC(self, viewModel.password) = self.passwordTextField.rac_textSignal;
    self.loginButton.rac_command = self.viewModel.loginCommand;
    
    RAC(self, emailTextField.textColor) = RACObserve(self, viewModel.emailTextColor);
    RAC(self, passwordTextField.textColor) = RACObserve(self, viewModel.passwordTextColor);
    
}

@end
