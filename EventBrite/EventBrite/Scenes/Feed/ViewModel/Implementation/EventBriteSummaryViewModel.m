//
//  EventBriteSummaryViewModel.m
//  EventBrite
//
//  Created by Anthony Hoang on 6/12/15.
//  Copyright (c) 2015 Anthony Hoang. All rights reserved.
//

#import "EventBriteSummaryViewModel.h"
#import "MXLEventBriteEvent.h"
#import <ReactiveCocoa.h>

@interface EventBriteSummaryViewModel ()

@property (nonatomic, strong) MXLEventBriteEvent *event;

@end

@implementation EventBriteSummaryViewModel

- (instancetype)initWithEvent:(MXLEventBriteEvent *)event {
    self = [super init];
    
    if (self) {
        self.event = event;
        
        self.name = self.event.name;
        self.location = self.event.venue.name;
        
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:self.event.logoURL];
        RAC(self, image) = [[[[[[NSURLConnection rac_sendAsynchronousRequest:request] reduceEach:^id(NSURLResponse *response, NSData *data) {
            return data;
        }] ignore:nil] map:^id(NSData *data) {
            return [UIImage imageWithData:data];
        }] deliverOnMainThread] catchTo:[RACSignal empty]];
    }
    
    return self;
}

@end
