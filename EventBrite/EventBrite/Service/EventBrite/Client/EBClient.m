//
//  EBClient.m
//  EventBrite
//
//  Created by Anthony Hoang on 6/12/15.
//  Copyright (c) 2015 Anthony Hoang. All rights reserved.
//

#import "EBClient.h"

static NSString * const kBaseUrl = @"https://www.eventbriteapi.com/v3";
NSString * const kOAuthTokenParameterKey = @"token";

@interface EBClient ()

@end

@implementation EBClient

- (instancetype)init {
    self = [self initWithBaseURL:nil];
    
    if (self) {
        
    }
    
    return self;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:[NSURL URLWithString:kBaseUrl]];
    
    if (self) {
        
    }
    
    return self;
}

- (void)setupWithOAuth:(NSString *)oAuthToken {
    self.oAuthToken = oAuthToken;
}

@end
