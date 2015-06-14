//
//  FormValidationViewModel.m
//  EventBrite
//
//  Created by Anthony Hoang on 6/12/15.
//  Copyright (c) 2015 Anthony Hoang. All rights reserved.
//

#import "FormValidationViewModelImplementation.h"

@implementation FormValidationViewModelImplementation

- (instancetype)init {
    self = [super init];
    
    if (self) {
        
        // email signal only sends YES if the text conatains a @
        RACSignal *validEmailSignal = [RACObserve(self, email) map:^id(NSString *email) {
            return @([email rangeOfString:@"@"].location != NSNotFound);
        }];
        
        // password signal only returns YES if it's longer than 5 characters
        RACSignal *validPasswordSignal = [RACObserve(self, password) map:^id(NSString *password) {
            return @(password.length > 5);
        }];
        
        // enable signal only returns yes when both signals are YES
        RACSignal *enableSignal = [[RACSignal combineLatest:@[validEmailSignal, validPasswordSignal]]
                                   map:^id(RACTuple *tuple) {
                                       RACTupleUnpack(NSNumber *emailValid, NSNumber *passwordValid) = tuple;
                                       return @(emailValid.boolValue && passwordValid.boolValue);
                                   }];
        
        self.loginCommand = [[RACCommand alloc] initWithEnabled:enableSignal
                                                    signalBlock:^RACSignal *(id value) {
                                                        NSLog(@"%s username: %@ password: %@", __PRETTY_FUNCTION__, self.email, self.password);
                                                        
                                                        return [RACSignal empty];
                                                    }];
        
        
        RAC(self, emailTextColor) = [validEmailSignal map:^id(NSNumber *validEmail) {
            return validEmail.boolValue ? [UIColor greenColor] : [UIColor redColor];
        }];
        
        RAC(self, passwordTextColor) = [validPasswordSignal map:^id(NSNumber *validPassword) {
            return validPassword.boolValue ? [UIColor greenColor] : [UIColor redColor];
        }];
    }
    
    return self;
}

@end
