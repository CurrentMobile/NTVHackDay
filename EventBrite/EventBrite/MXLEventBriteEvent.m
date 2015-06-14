//
//  MXLEventBriteEvent.m
//  MXLFrameworkDemo
//
//  Created by Anthony Hoang on 5/4/15.
//  Copyright (c) 2015 MobileX Labs. All rights reserved.
//

#import "MXLEventBriteEvent.h"

@interface MXLEventBriteEvent ()

#pragma mark - Writeable Property redeclarations
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *eventId;
@property (nonatomic, strong) NSString *details;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSTimeZone *startDateTimeZone;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) NSTimeZone *endDateTimeZone;
@property (nonatomic, strong) NSURL *logoURL;
@property (nonatomic, strong) MXLEventBriteVenue *venue;

@end

@implementation MXLEventBriteEvent

+ (instancetype)eventWithBuilderBlock:(void (^)(MXLEventBriteEventBuilder *))builderBlock {
    MXLEventBriteEventBuilder *builder = [MXLEventBriteEventBuilder new];
    
    if (builderBlock) {
        builderBlock(builder);
    }
    
    return [builder build];
}

- (instancetype)initWithBuilder:(MXLEventBriteEventBuilder *)builder {
    self = [super self];
    
    if (self) {
        self.name = builder.name;
        self.eventId = builder.eventId;
        self.details = builder.details;
        self.url = builder.url;
        self.startDate = builder.startDate;
        self.endDate = builder.endDate;
        self.startDateTimeZone = builder.startDateTimeZone;
        self.endDateTimeZone = builder.endDateTimeZone;
        self.logoURL = builder.logoURL;
        self.venue = builder.venue;
    }
    
    return self;
}

@end

@implementation MXLEventBriteEventBuilder

- (MXLEventBriteEvent *)build {
    return [[MXLEventBriteEvent alloc] initWithBuilder:self];
}

@end
