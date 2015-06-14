//
//  NSDictionary+MXLEventBriteVenue.h
//  MXLFrameworkDemo
//
//  Created by Anthony Hoang on 5/5/15.
//  Copyright (c) 2015 MobileX Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXLEventBriteVenue.h"

/**
 *  This class handles JSON parsing for EventBrite venues.
 */
@interface NSDictionary (MXLEventBriteVenue)

/**
 *  Parses the JSON returned from the EventBrite service into an MXLEventBriteVenue object.
 *
 *  @return The new MXLEventBriteVenue object.
 */
- (MXLEventBriteVenue *)eb_parseVenue;

@end

/**
 *  This is for type safety. If the JSON returns an NSNull instead of a dictionary, return nil;
 */
@interface NSNull (MXLEventBriteVenue)

/**
 *  Returns nil.
 *
 *  @return nil.
 */
- (MXLEventBriteVenue *)eb_parseVenue;

@end
