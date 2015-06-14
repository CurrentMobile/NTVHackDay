//
//  NSDictionary+MXLEventBriteEvent.h
//  MXLFrameworkDemo
//
//  Created by Anthony Hoang on 5/4/15.
//  Copyright (c) 2015 MobileX Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXLEventBriteEvent.h"

/**
 *  This class handles JSON parsing for the Event Brite service.
 */
@interface NSDictionary (MXLEventBriteEvent)


/**
 *  Parses JSON returned from the EventBrite service into an MXLEventBriteEvent.
 *
 *  @return An MXLEventBriteEvent
 */
- (MXLEventBriteEvent *)eb_parseEvent;

/**
 *  Parses the JSON and returns the next page, for pagination support.
 *
 *  @return The next page of results.
 */
- (NSNumber *)eb_parseNextPageNumberOfEvents;

/**
 *  Parses the JSON and returns a BOOL.
 *
 *  @return YES if there are no more pages of results, NO if the results aren't finished.
 */
- (BOOL)eb_parseEventsPagingFinished;

@end

/**
 *  This is for type safety. If the JSON returns an NSNull instead of a dictionary, return nil;
 */
@interface NSNull (MXLEventBriteEvent)

/**
 *  Returns nil.
 *
 *  @return nil.
 */
- (MXLEventBriteEvent *)eb_parseEvent;

@end
