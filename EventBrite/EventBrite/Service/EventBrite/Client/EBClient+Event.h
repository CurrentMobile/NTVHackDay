//
//  EBClient+Event.h
//  EventBrite
//
//  Created by Anthony Hoang on 6/12/15.
//  Copyright (c) 2015 Anthony Hoang. All rights reserved.
//

#import "EBClient.h"

/**
 *  Client requests for events.
 */
@interface EBClient (Event)

/**
 *  A cold signal that performs a GET request for future events for an organizer.
 *
 *  @param organizerId The EventBrite organizer's Id
 *  @param pageNumber  The page number to fetch.
 *
 *  @return A cold signal that returns a tuple. The tuple contains: 1. The array of EventBrite events 2. The next page number 3. A flag indicating if all the pages are finished. The signal completes when the request is finished.
 */
- (RACSignal *)fetchPageOfEventsForOrganizer:(NSString *)organizerId pageNumber:(NSUInteger)pageNumber;

@end
