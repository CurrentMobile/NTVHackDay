//
//  EBClient+Event.m
//  EventBrite
//
//  Created by Anthony Hoang on 6/12/15.
//  Copyright (c) 2015 Anthony Hoang. All rights reserved.
//

#import "EBClient+Event.h"
#import "NSDictionary+MXLEventBriteEvent.h"

static NSString * kEventPath = @"events/";

@implementation EBClient (Event)

- (RACSignal *)fetchPageOfEventsForOrganizer:(NSString *)organizerId pageNumber:(NSUInteger)pageNumber {
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return [[[self rac_GET:[kEventPath stringByAppendingString:@"search"] parameters:@{kOAuthTokenParameterKey : self.oAuthToken}]
             reduceEach:^id(AFHTTPRequestOperation *operation, id responseObject) {
                 return RACTuplePack(responseObject[@"events"], responseObject[@"pagination"]);
             }]
            map:^id(RACTuple *tuple) {
                RACTupleUnpack(NSString *array, NSDictionary *paginationDictionary) = tuple;
                
                NSArray *events = [[[array rac_sequence]
                                    map:^id(NSDictionary *jsonDictionary) {
                                        return [jsonDictionary eb_parseEvent]; // parse here.
                                    }] array];
                
                return RACTuplePack(events, [paginationDictionary eb_parseNextPageNumberOfEvents], @([paginationDictionary eb_parseEventsPagingFinished]));
            }];
}

@end
