//
//  EventBriteFeedViewModel.h
//  EventBrite
//
//  Created by Anthony Hoang on 6/12/15.
//  Copyright (c) 2015 Anthony Hoang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedViewModelProtocol.h"

/**
 *  View model implementation for the EventBrite feed.
 */
@interface EventBriteFeedViewModel : NSObject <FeedViewModelProtocol>

#pragma mark - FeedViewModelProtocol
/**
 *  A hot signal that emits when the underlying data has changed. The view should subscribe to this signal and update the views on next. 'next' sends nil.
 */
@property (nonatomic, strong, readonly) RACSignal *contentChangedSignal;

/**
 *  A command that asks the view model to fetch the first page of events. This should be executed on inital load and if the user pulls to refresh. The command accepts nil as a parameter.
 */
@property (nonatomic, strong, readonly) RACCommand *fetchEventsCommand;

/**
 *  A command that asks the view model to fetch the next page of events. When/if the requst completes, the 'contentChangedSignal' will emit and the views should be refreshed.
 */
@property (nonatomic, strong, readonly) RACCommand *fetchNextPageCommand;

/**
 *  Text to display for empty state. could say, "feed is empty" or "please wait loading"
 */
@property (nonatomic, strong) NSString *emptyText;

/**
 *  The number of events to dispaly in the view.
 *
 *  @return The number of events.
 */
- (NSInteger)numberOfEvents;

/**
 *  Returns a view model for a view that displays an even summary.
 *
 *  @param index The index of the event.
 *
 *  @return The view model
 */
- (id<EventSummaryViewModelProtocol>)viewModelAtIndex:(NSUInteger)index;

@end
