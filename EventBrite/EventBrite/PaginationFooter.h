//
//  PaginationFooter.h
//  EventBrite
//
//  Created by Anthony Hoang on 6/13/15.
//  Copyright (c) 2015 Anthony Hoang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaginationFooterViewModel.h"

@interface PaginationFooter : UICollectionReusableView

@property (nonatomic, strong) id<PaginationFooterViewModel> viewModel;

@end