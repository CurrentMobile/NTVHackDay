//
//  EventBriteSummaryViewModel.h
//  EventBrite
//
//  Created by Anthony Hoang on 6/12/15.
//  Copyright (c) 2015 Anthony Hoang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventSummaryViewModelProtocol.h"

@class MXLEventBriteEvent;

@interface EventBriteSummaryViewModel : NSObject <EventSummaryViewModelProtocol>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) UIImage *image;

- (instancetype)initWithEvent:(MXLEventBriteEvent *)event;

@end
