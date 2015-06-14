//
//  EBClient+Oragnizer.m
//  EventBrite
//
//  Created by Anthony Hoang on 6/12/15.
//  Copyright (c) 2015 Anthony Hoang. All rights reserved.
//

#import "EBClient+Oragnizer.h"
#import "NSDictionary+MXLEventBriteOrganizer.h"

static NSString * const kOrganizerPath = @"organizers/";

@implementation EBClient (Oragnizer)

- (RACSignal *)fetchOrganizerInfoForId:(NSString *)organizerId {
    return [[[self rac_GET:[NSString stringWithFormat:@"%@%@", kOrganizerPath, organizerId] parameters:@{kOAuthTokenParameterKey : self.oAuthToken}]
             reduceEach:^id(AFHTTPRequestOperation *operation, id responseObject) {
                 return (NSDictionary *)responseObject;
             }]
            map:^id(NSDictionary *jsonDictionary) {
                return [jsonDictionary eb_parseOragnizer];
            }];
}

@end
