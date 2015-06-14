//
//  NSDictionary+MXLEventBriteOrganizer.h
//  MXLFrameworkDemo
//
//  Created by Anthony Hoang on 5/5/15.
//  Copyright (c) 2015 MobileX Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXLEventBriteOrganizer.h"

/**
 *  This class handles JSON parsing for EventBrite organizers.
 */
@interface NSDictionary (MXLEventBriteOrganizer)

/**
 *  Parses the JSON returned form the EventBrite service into an MXLEventBrite organizer object.
 *
 *  @return A new MXLEventBriteOrganizer.
 */
- (MXLEventBriteOrganizer *)eb_parseOragnizer;

@end

/**
 *  This is for type safety. If the JSON returns an NSNull instead of a dictionary, return nil;
 */
@interface NSNull (MXLEventBriteOrganizer)

/**
 *  Returns nil.
 *
 *  @return nil.
 */
- (MXLEventBriteOrganizer *)eb_parseOrganizer;

@end
