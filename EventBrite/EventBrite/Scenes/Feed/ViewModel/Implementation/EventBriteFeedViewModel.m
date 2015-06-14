//
//  EventBriteFeedViewModel.m
//  EventBrite
//
//  Created by Anthony Hoang on 6/12/15.
//  Copyright (c) 2015 Anthony Hoang. All rights reserved.
//

#import "EventBriteFeedViewModel.h"
#import "EBClient+Event.h"
#import "EventBriteSummaryViewModel.h"

static NSString * const kTestOauthToken = @"UAEI4LPJYUAEYETDRDXM";
static NSString * const kTestOrganizerId = @"6011086107";

@interface EventBriteFeedViewModel ()

#pragma mark - Writable property redelcartions
@property (nonatomic, strong, readwrite) RACSubject *contentChangedSignal;
@property (nonatomic, strong, readwrite) RACCommand *fetchEventsCommand;
@property (nonatomic, strong, readwrite) RACCommand *fetchNextPageCommand;

/**
 *  Flag set to NO if we are at the last page.
 */
@property (nonatomic, strong) RACSubject *pagingEnabledSignal;

/**
 *  The events.
 */
@property (nonatomic, strong) NSArray *events;

/**
 *  The current page number for pagination support
 */
@property (nonatomic, assign) NSUInteger pageNumber;

/**
 *  The client used to make network requests
 */
@property (nonatomic, strong) EBClient *client;

@end

@implementation EventBriteFeedViewModel

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.client = [EBClient new];
        [self.client setupWithOAuth:kTestOauthToken];
        self.emptyText = @"";
        
        self.contentChangedSignal = [[RACSubject subject] setNameWithFormat:@"EventBriteFeedViewModel.contentChangedSignal"];
        self.pagingEnabledSignal = [RACSubject subject]; // paging disabled until we have a first page. don't want to kick off multiple network requests
        [self.pagingEnabledSignal sendNext:@(NO)];
        
        @weakify(self)
        self.fetchEventsCommand = [[RACCommand alloc] initWithEnabled:nil
                                                          signalBlock:^RACSignal *(id value) {
                                                              @strongify(self)
                                                              return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                                                                  self.pageNumber = 1;
                                                                  
                                                                  [[[[self.client fetchPageOfEventsForOrganizer:kTestOrganizerId pageNumber:self.pageNumber]
                                                                     setNameWithFormat:@"EventBriteFeedViewModel.fetchEventsCommand"] logError]
                                                                   subscribeNext:^(RACTuple *tuple) {
                                                                       RACTupleUnpack(NSArray *events, NSNumber *nextPageNumber, NSNumber *finished) = tuple;
                                                                       self.events = events;
                                                                       self.pageNumber = nextPageNumber.integerValue;
                                                                       [self.pagingEnabledSignal sendNext:@(!finished.boolValue)];
                                                                   }error:^(NSError *error) {
                                                                       [subscriber sendError:error];
                                                                   }completed:^ {
                                                                       [subscriber sendCompleted];
                                                                   }];
                                                                  
                                                                  return nil;
                                                              }];
                                                          }];
        
        
        self.fetchNextPageCommand = [[RACCommand alloc] initWithEnabled:self.pagingEnabledSignal
                                                            signalBlock:^RACSignal *(id value) {
                                                                return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                                                                    
                                                                    [[[[self.client fetchPageOfEventsForOrganizer:kTestOrganizerId pageNumber:self.pageNumber]
                                                                       setNameWithFormat:@"EventBriteFeedViewModel.fetchNextPageCommand"] logError]
                                                                     subscribeNext:^(RACTuple *tuple) {
                                                                         RACTupleUnpack(NSArray *events, NSNumber *pageNumber, NSNumber *finished) = tuple;
                                                                         
                                                                         NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:self.events];
                                                                         [mutableArray addObjectsFromArray:events];
                                                                         self.events = mutableArray;
                                                                         
                                                                         self.pageNumber = pageNumber.integerValue;
                                                                         [self.pagingEnabledSignal sendNext:@(!finished.boolValue)];
                                                                         
                                                                     }error:^(NSError *error) {
                                                                         [subscriber sendError:error];
                                                                     }completed:^ {
                                                                         [subscriber sendCompleted];
                                                                     }];
                                                                    return nil;
                                                                }];
                                                            }];
        
        
        // This is only triggered when the array is empty and not nil;
        RACSignal *emptySignal = [[[RACObserve(self, events) ignore:nil]
                                   filter:^BOOL(NSArray *array) {
                                       return array.count == 0;
                                   }] map:^id(NSArray *array) {
                                       return @"There are no events to display";
                                   }];
        
        
        // This is only triggered when the command is executing.
        RACSignal *loadingSignal =  [[self.fetchEventsCommand.executing filter:^BOOL(NSNumber *loading) {
            return loading.boolValue; // only return if executing == YES.
        }] map:^id(NSNumber *number) {
            return @"Please wait, loading...";
        }];
        
        RACSignal *errorSignal = [self.fetchEventsCommand.errors map:^id(NSError *error) {
            return @"There was an error loading your feed";
        }];
        
        RAC(self, emptyText) = [RACSignal merge:@[emptySignal, loadingSignal, errorSignal]];
        
        [[RACSignal combineLatest:@[RACObserve(self, events),
                                    RACObserve(self, emptyText)]]
         subscribeNext:^(id x) {
             @strongify(self)
             [(id<RACSubscriber>)(self.contentChangedSignal) sendNext:nil];
         }];
        
    }
    
    return self;
}

- (NSInteger)numberOfEvents {
    return self.events.count;
}

- (id<EventSummaryViewModelProtocol>)viewModelAtIndex:(NSUInteger)index {
    return [[EventBriteSummaryViewModel alloc] initWithEvent:self.events[index]];
}

@end