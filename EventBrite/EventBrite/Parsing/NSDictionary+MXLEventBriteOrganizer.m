//
//  NSDictionary+MXLEventBriteOrganizer.m
//  MXLFrameworkDemo
//
//  Created by Anthony Hoang on 5/5/15.
//  Copyright (c) 2015 MobileX Labs. All rights reserved.
//

#import "NSDictionary+MXLEventBriteOrganizer.h"

static NSString * const kDetailsInfoKey = @"description";
static NSString * const kDetailsKey = @"text";

static NSString * const kLogoInfoKey = @"logo";
static NSString * const kLogoKey = @"url";

static NSString * const kIdKey = @"id";
static NSString * const kNameKey = @"name";
static NSString * const kPastEventsCountKey = @"num_past_events";
static NSString * const kFutureEventsCountKey = @"num_future_events";
static NSString * const kURLKey = @"url";

@implementation NSDictionary (MXLEventBriteOrganizer)

- (MXLEventBriteOrganizer *)eb_parseOragnizer {
    
    MXLEventBriteOrganizer *organizer = [MXLEventBriteOrganizer organizerWithBuilderBlock:^(MXLEventBriteOrganizerBuilder *builder) {
        builder.organizerId = self[kIdKey];
        builder.details = self[kDetailsInfoKey][kDetailsKey];
        builder.name = self[kNameKey];
        builder.url = [NSURL URLWithString:self[kURLKey]];
        
        if (self[kLogoInfoKey] != [NSNull null]) {
            builder.logoURL = [NSURL URLWithString:self[kLogoInfoKey][kLogoKey]];

        }
        
        builder.pastEventsCount = [self[kPastEventsCountKey] integerValue];
        builder.futureEventsCount = [self[kFutureEventsCountKey] integerValue];
        
    }];
    
    return organizer;
}

@end

@implementation NSNull (MXLEventBriteOrganizer)

- (MXLEventBriteOrganizer *)eb_parseOrganizer {
    return nil;
}

@end
