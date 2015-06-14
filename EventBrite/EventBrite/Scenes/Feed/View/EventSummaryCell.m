//
//  EventDetailCell.m
//  EventBrite
//
//  Created by Anthony Hoang on 6/12/15.
//  Copyright (c) 2015 Anthony Hoang. All rights reserved.
//

#import "EventSummaryCell.h"
#import <ReactiveCocoa.h>

@interface EventSummaryCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UIImageView *thumbnail;

@end

@implementation EventSummaryCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.thumbnail = [UIImageView new];
        self.thumbnail.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.thumbnail];
        
        self.titleLabel = [UILabel new];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.titleLabel];
        
        self.subtitleLabel = [UILabel new];
        self.subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.subtitleLabel];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[iv]-10-|" options:0 metrics:nil views:@{@"iv" : self.thumbnail}]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.thumbnail attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.thumbnail attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0.0f]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[iv]-10-[title]-10-|" options:0 metrics:nil views:@{@"iv" : self.thumbnail, @"title" : self.titleLabel}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[title]-0-[subtitle]" options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight metrics:nil views:@{@"title" : self.titleLabel, @"subtitle" : self.subtitleLabel}]];
        
        self.thumbnail.backgroundColor = [UIColor grayColor];
        
    
        RAC(self, titleLabel.text) = [RACObserve(self, viewModel.name) ignore:NSNull.null];
        RAC(self, subtitleLabel.text) = [RACObserve(self, viewModel.location) ignore:NSNull.null];
        RAC(self, thumbnail.image) = RACObserve(self, viewModel.image);
    }
    
    return self;
}

@end
