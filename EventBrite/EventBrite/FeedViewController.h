//
//  ViewController.h
//  EventBrite
//
//  Created by Anthony Hoang on 6/12/15.
//  Copyright (c) 2015 Anthony Hoang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedViewModelProtocol.h"

@interface FeedViewController : UIViewController

/**
 *  The view model that backs this view.
 */
@property (nonatomic, strong) id<FeedViewModelProtocol> viewModel;

@end

