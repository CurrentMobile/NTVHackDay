//
//  MXLEventBriteEvent.h
//  MXLFrameworkDemo
//
//  Created by Anthony Hoang on 5/4/15.
//  Copyright (c) 2015 MobileX Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXLEventBriteVenue.h"

@class MXLEventBriteEventBuilder;

/**
 *  This is a data model that represents an event from the Event Brite service.
 */
@interface MXLEventBriteEvent : NSObject

/**
 *  The name of the event.
 */
@property (nonatomic, strong, readonly) NSString *name;

/**
 *  The unique identifier of the event.
 */
@property (nonatomic, strong, readonly) NSString *eventId;

/**
 *  A description of the event.
 */
@property (nonatomic, strong, readonly) NSString *details;

/**
 *  The URL of the event.
 */
@property (nonatomic, strong, readonly) NSURL *url;

/**
 *  The date the event starts. This is in local time. (Location of the event.)
 */
@property (nonatomic, strong, readonly) NSDate *startDate;

/**
 *  The time zone for the start date.
 */
@property (nonatomic, strong, readonly) NSTimeZone *startDateTimeZone;

/**
 *  The date the event ends. This is in local time. (Location of the event.)
 */
@property (nonatomic, strong, readonly) NSDate *endDate;

/**
 *  The time zone of the end date.
 */
@property (nonatomic, strong, readonly) NSTimeZone *endDateTimeZone;

/**
 *  The URL of the event logo.
 */
@property (nonatomic, strong, readonly) NSURL *logoURL;

/**
 *  The venue of the event.
 */
@property (nonatomic, strong, readonly) MXLEventBriteVenue *venue;

/**
 *  Use this class method to instantiate a new instance of MXLEventBriteEvent.
 *
 *  @param builderBlock A builder block. Use the builder to set the properties of the event.
 *
 *  @return The new event.
 */
+ (instancetype)eventWithBuilderBlock:(void(^)(MXLEventBriteEventBuilder *builder))builderBlock;

@end

/**
 *  This is a builder to help build the MXLEventBriteEvent.
 */
@interface MXLEventBriteEventBuilder : NSObject

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

/**
 *  Builds a new instance of MXLEventBriteEvent using the values of the builder's properties.
 *
 *  @return The new MXLEventBriteEvent whose property values are the values of the bulider's properties.
 */
- (MXLEventBriteEvent *)build;

@end
