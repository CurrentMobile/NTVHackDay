//
//  ViewController.m
//  EventBrite
//
//  Created by Anthony Hoang on 6/12/15.
//  Copyright (c) 2015 Anthony Hoang. All rights reserved.
//

#import "FeedViewController.h"
#import "EventSummaryCell.h"
#import <UIScrollView+EmptyDataSet.h>
#import "EventBriteFeedViewModel.h"
#import "FormValidationViewController.h"
#import "FormValidationViewModelImplementation.h"

static NSString * const kSummaryCellIdentifier = @"EventSummaryCell";

@interface FeedViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, DZNEmptyDataSetSource>

@property (nonatomic, strong) UICollectionView *collectionView;

/**
 *  Sets up the collection view
 */
- (void)setupCollectionView;

/**
 *  Binds the properties and signals of the view model to update the views.
 */
- (void)setBindings;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [EventBriteFeedViewModel new];
    [self setupCollectionView];
    [self setBindings];
    
}

- (void)setupCollectionView {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.alwaysBounceVertical = YES;
    [self.collectionView registerClass:[EventSummaryCell class] forCellWithReuseIdentifier:kSummaryCellIdentifier];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.emptyDataSetSource = self;
    [self.view addSubview:self.collectionView];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[cv]-0-|" options:0 metrics:nil views:@{@"cv" : self.collectionView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[cv]-0-|" options:0 metrics:nil views:@{@"cv" : self.collectionView}]];
    
    UIRefreshControl *refresh = [UIRefreshControl new];
    refresh.rac_command = self.viewModel.fetchEventsCommand;
    [self.collectionView addSubview:refresh];
    
}

- (void)setBindings {
    @weakify(self)
    
    [self.viewModel.contentChangedSignal
     subscribeNext:^(id x) {
         @strongify(self)
         [self.collectionView reloadData];
     }];
    
    // pull data.
    [self.viewModel.fetchEventsCommand execute:nil];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.viewModel numberOfEvents];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EventSummaryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSummaryCellIdentifier forIndexPath:indexPath];
    cell.viewModel = [self.viewModel viewModelAtIndex:indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width - 20.0f, 88.0f);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"form" sender:self];
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGSize scrollViewSize = scrollView.contentSize;
    CGPoint scrollOffset = scrollView.contentOffset;
    
    
    if (scrollOffset.y + scrollView.bounds.size.height >= scrollViewSize.height) {
        [self.viewModel.fetchNextPageCommand execute:nil];
    }
}

#pragma mark - DZNEmptyDataSetSource

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    return [[NSAttributedString alloc] initWithString:self.viewModel.emptyText];
}

@end
