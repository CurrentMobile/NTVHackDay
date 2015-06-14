//
//  EBClient+Oragnizer.h
//  EventBrite
//
//  Created by Anthony Hoang on 6/12/15.
//  Copyright (c) 2015 Anthony Hoang. All rights reserved.
//

#import "EBClient.h"
#import "MXLEventBriteOrganizer.h"

/**
 *  This is responsible for network requests to the EventBrite service to the /organizers endpoint.
 */
@interface EBClient (Oragnizer)

/**
 *  A cold signal that performs a GET request for an EventBrite organizer.
 *
 *  @param organizerId The EventBrite organizer Id.
 *
 *  @return A cold signal that sends an EventBriteOrganizer object. The signal completes when the request is finished.
 */
- (RACSignal *)fetchOrganizerInfoForId:(NSString *)organizerId;

@end
