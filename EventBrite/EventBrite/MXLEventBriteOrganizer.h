//
//  MXLEventBriteOrganizer.h
//  MXLFrameworkDemo
//
//  Created by Anthony Hoang on 5/5/15.
//  Copyright (c) 2015 MobileX Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MXLEventBriteOrganizerBuilder;

/**
 *  This data model represents an Event Brite Organizer.
 */
@interface MXLEventBriteOrganizer : NSObject

/**
 *  The unique identifer of the organizer on the EventBrite service.
 */
@property (nonatomic, strong, readonly) NSString *organizerId;

/**
 *  A description of the organizer.
 */
@property (nonatomic, strong, readonly) NSString *details;

/**
 *  The name of the organizer.
 */
@property (nonatomic, strong, readonly) NSString *name;

/**
 *  The URL to the organizer's EventBrite profile.
 */
@property (nonatomic, strong, readonly) NSURL *url;

/**
 *  The URL of the organizer's logo image.
 */
@property (nonatomic, strong, readonly) NSURL *logoURL;

/**
 *  The number of events the organizer has created in the past.
 */
@property (nonatomic, assign, readonly) NSUInteger pastEventsCount;

/**
 *  The number of tevents the organizer has planned in the future.
 */
@property (nonatomic, assign, readonly) NSUInteger futureEventsCount;

/**
 *  An array of MXLEventBriteEvents the organizer has planned in the future.
 */
@property (nonatomic, strong, readonly) NSMutableArray *futureEvents;

/**
 *  Use this class method to create a new instance of MXLEventBriteOrganizer.
 *
 *  @param builderBlock The builder block. Set the builder's properties to build the MXLEventBriteOrganizer.
 *
 *  @return A new MXLEventBriteOrganizer instance whose properties are set to the builder's properties.
 */
+ (instancetype)organizerWithBuilderBlock:(void(^)(MXLEventBriteOrganizerBuilder *builder))builderBlock;

@end

/**
 *  This build class helps build an MXLEventBriteOragnizer class setting the MXLEventBriteOrganier's properties to the builder's properties.
 */
@interface MXLEventBriteOrganizerBuilder : NSObject

@property (nonatomic, strong) NSString *organizerId;
@property (nonatomic, strong) NSString *details;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSURL *logoURL;
@property (nonatomic, assign) NSUInteger pastEventsCount;
@property (nonatomic, assign) NSUInteger futureEventsCount;

/**
 *  Builds a new instance of MXLEventBriteOrganizer using the builder's properties.
 *
 *  @return The new MXLEventBriteOrganizer whose properties are set to the builder's properties.
 */
- (MXLEventBriteOrganizer *)build;

@end
