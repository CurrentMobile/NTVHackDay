//
//  PaginationFooter.m
//  EventBrite
//
//  Created by Anthony Hoang on 6/13/15.
//  Copyright (c) 2015 Anthony Hoang. All rights reserved.
//

#import "PaginationFooter.h"

@interface PaginationFooter ()

@end

@implementation PaginationFooter

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicator.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:indicator];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[indicator(20)]" options:0 metrics:nil views:@{@"indicator" : indicator}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[indicator(20)]" options:0 metrics:nil views:@{@"indicator" : indicator}]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:indicator attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:indicator attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
        
        
        [[RACObserve(self, viewModel) ignore:nil] subscribeNext:^(id viewModel) {
          
            [self.viewModel.showLoadingSignal subscribeNext:^(NSNumber *show) {
                
                if (show.boolValue) {
                    [indicator startAnimating];
                } else {
                    [indicator stopAnimating];
                }

            }];
            
        }];
        
    }
    
    return self;
}

@end
