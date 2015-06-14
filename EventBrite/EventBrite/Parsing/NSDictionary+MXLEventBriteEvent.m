//
//  NSDictionary+MXLEventBriteEvent.m
//  MXLFrameworkDemo
//
//  Created by Anthony Hoang on 5/4/15.
//  Copyright (c) 2015 MobileX Labs. All rights reserved.
//

#import "NSDictionary+MXLEventBriteEvent.h"
#import "NSDictionary+MXLEventBriteVenue.h"
#import <RACEXTScope.h>

static NSString * const kEventsInfoKey = @"events";

static NSString * const kDescriptionInfoKey = @"description";
static NSString * const kDescriptionKey = @"text";

static NSString * const kStartDateInfoKey = @"start";
static NSString * const kStartDateKey = @"utc";
static NSString * const kStartDateTimeZoneKey = @"timezone";

static NSString * const kEndDateInfoKey = @"end";
static NSString * const kEndDateKey = @"utc";
static NSString * const kEndDateTimeZoneKey = @"timezone";

static NSString * const kIdKey = @"id";
static NSString * const kURLKey = @"url";
static NSString * const kVenueInfoKey = @"venue";

static NSString * const kLogoInfoKey = @"logo";
static NSString * const kLogoURLKey = @"url";

static NSString * const kNameInfoKey = @"name";
static NSString * const kNameKey = @"text";

static NSString * const kPaginationInfoKey = @"pagination";
static NSString * const kPageKey = @"page_number";
static NSString * const kTotalPagesKey = @"page_count";

@implementation NSDictionary (MXLEventBriteEvent)

- (MXLEventBriteEvent *)eb_parseEvent {
    @weakify(self)
    
    MXLEventBriteEvent *event = [MXLEventBriteEvent eventWithBuilderBlock:^(MXLEventBriteEventBuilder *builder) {
        @strongify(self)
        
        builder.name = self[kNameInfoKey][kNameKey];
        builder.eventId = self[kIdKey];
        
        if (self[kDescriptionInfoKey] != NSNull.null) {
            builder.details = self[kDescriptionInfoKey][kDescriptionKey];
        }
        
        builder.url = [NSURL URLWithString:self[kURLKey]];
        
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"YYYY-MM-dd\'T\'HH:mm:ssZ"];
        
        builder.startDate = [dateFormatter dateFromString:self[kStartDateInfoKey][kStartDateKey]];
        builder.startDateTimeZone = [NSTimeZone timeZoneWithName:self[kStartDateInfoKey][kStartDateTimeZoneKey]];
        builder.endDate = [dateFormatter dateFromString:self[kEndDateInfoKey][kEndDateKey]];
        builder.endDateTimeZone = [NSTimeZone timeZoneWithName:self[kEndDateInfoKey][kEndDateTimeZoneKey]];
        builder.venue = [self[kVenueInfoKey] eb_parseVenue];
        
        if (self[kLogoInfoKey] != [NSNull null]) {
            builder.logoURL = [NSURL URLWithString:self[kLogoInfoKey][kLogoURLKey]];
        }
        
    }];
    
    return event;
}

- (NSDateFormatter *)dateFormatter {
    static NSDateFormatter * dateFormatter = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^ {
        dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"YYYY-MM-dd\'T\'HH:mm:ssZ"];
    });
    
    return dateFormatter;
}

- (NSNumber *)eb_parseNextPageNumberOfEvents {
    NSUInteger currentPage = [self[kPageKey] integerValue];
    
    return @(currentPage + 1);
}

- (BOOL)eb_parseEventsPagingFinished {
    NSUInteger currentPage = [self[kPageKey] integerValue];
    NSUInteger totalPages = [self[kTotalPagesKey] integerValue];
    
    return totalPages <= currentPage;
}

@end

@implementation NSNull (MXLEventBriteEvent)

- (MXLEventBriteEvent *)eb_parseEvent {
    return nil;
}

@end
