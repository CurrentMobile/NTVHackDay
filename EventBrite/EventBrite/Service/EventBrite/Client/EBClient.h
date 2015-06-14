//
//  EBClient.h
//  EventBrite
//
//  Created by Anthony Hoang on 6/12/15.
//  Copyright (c) 2015 Anthony Hoang. All rights reserved.
//

#import <AFHTTPRequestOperationManager+RACSupport.h>

FOUNDATION_EXPORT NSString * const kOAuthTokenParameterKey;

/**
 *  The EventBrite client used to handle all network requests.
 */
@interface EBClient : AFHTTPRequestOperationManager

@property (nonatomic, strong) NSString *oAuthToken;

/**
 *  Adds the OAuth token to be sent during every network request.
 *
 *  @param oAuthToken The Oauth token. If this is not set, all network requests will fail.
 */
- (void)setupWithOAuth:(NSString *)oAuthToken;

@end
