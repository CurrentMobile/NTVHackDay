//
//  PaginationFooter.m
//  EventBrite
//
//  Created by Anthony Hoang on 6/13/15.
//  Copyright (c) 2015 Anthony Hoang. All rights reserved.
//

#import "PaginationFooter.h"

@implementation PaginationFooter

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicator.frame = CGRectMake(0, 0, 20, 20);
        indicator.center = self.center;
        [self addSubview:indicator];
        
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
