//
//  EventDetailCell.h
//  EventBrite
//
//  Created by Anthony Hoang on 6/12/15.
//  Copyright (c) 2015 Anthony Hoang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventSummaryViewModelProtocol.h"

/**
 *  A cell that displays an overview of an event. (name, date, location, picture..)
 */
@interface EventSummaryCell : UICollectionViewCell

/**
 *  The view model that backs this view.
 */
@property (nonatomic, strong) id<EventSummaryViewModelProtocol> viewModel;

@end
