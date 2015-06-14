//
//  PaginationFooterViewModel.h
//  EventBrite
//
//  Created by Anthony Hoang on 6/13/15.
//  Copyright (c) 2015 Anthony Hoang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>

@protocol PaginationFooterViewModel <NSObject>

@property (nonatomic, strong) RACSignal *showLoadingSignal;

@end
