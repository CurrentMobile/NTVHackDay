//
//  MXLEventBriteOrganizer.m
//  MXLFrameworkDemo
//
//  Created by Anthony Hoang on 5/5/15.
//  Copyright (c) 2015 MobileX Labs. All rights reserved.
//

#import "MXLEventBriteOrganizer.h"

@interface MXLEventBriteOrganizer ()

#pragma mark - Writable property redeclarations.
@property (nonatomic, strong) NSString *organizerId;
@property (nonatomic, strong) NSString *details;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSURL *logoURL;
@property (nonatomic, assign) NSUInteger pastEventsCount;
@property (nonatomic, assign) NSUInteger futureEventsCount;
@property (nonatomic, strong) NSMutableArray *futureEvents;

@end

@implementation MXLEventBriteOrganizer

+ (instancetype)organizerWithBuilderBlock:(void (^)(MXLEventBriteOrganizerBuilder *))builderBlock {
    MXLEventBriteOrganizerBuilder *builder = [MXLEventBriteOrganizerBuilder new];
    
    if (builderBlock) {
        builderBlock(builder);
    }
    
    return [builder build];
}

- (instancetype)initWithBuilder:(MXLEventBriteOrganizerBuilder *)builder {
    self = [super self];
    
    if (self) {
        self.organizerId = builder.organizerId;
        self.details = builder.details;
        self.name = builder.name;
        self.url = builder.url;
        self.logoURL = builder.logoURL;
        self.pastEventsCount = builder.pastEventsCount;
        self.futureEventsCount = builder.futureEventsCount;
        self.futureEvents = @[].mutableCopy;
    }
    
    return self;
}

@end

@implementation MXLEventBriteOrganizerBuilder

- (MXLEventBriteOrganizer *)build {
    return [[MXLEventBriteOrganizer alloc] initWithBuilder:self];
}

@end
