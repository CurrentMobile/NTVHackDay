//
//  EBClientTests.m
//  EventBrite
//
//  Created by Anthony Hoang on 6/12/15.
//  Copyright (c) 2015 Anthony Hoang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EBClient+Event.h"
#import "EBClient+Oragnizer.h"
#import "MXLEventBriteEvent.h"

#define TestNeedsToWaitForBlock() __block BOOL blockFinished = NO
#define BlockFinished() blockFinished = YES
#define WaitForBlock() while (CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0, true) && !blockFinished)

static NSString * const kTestOauthToken = @"UAEI4LPJYUAEYETDRDXM";
static NSString * const kTestOrganizerId = @"6011086107";

@interface EBClientTests : XCTestCase

@property (nonatomic, strong) EBClient *client;

@end

@implementation EBClientTests

- (void)setUp {
    [super setUp];
    
    self.client = [EBClient new];
    [self.client setupWithOAuth:kTestOauthToken];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFetchEvents {
    TestNeedsToWaitForBlock();
    
    [[self.client fetchPageOfEventsForOrganizer:kTestOrganizerId pageNumber:1]
     subscribeNext:^(RACTuple *tuple) {
         RACTupleUnpack(NSArray *events, NSNumber *nextPage, NSNumber *finished) = tuple;
         
         NSArray *array = [[[events rac_sequence] filter:^BOOL(id object) {
             return [object isKindOfClass:[MXLEventBriteEvent class]];
         }] array];
         
         XCTAssertTrue(array.count == events.count);
         XCTAssertTrue([nextPage isKindOfClass:[NSNumber class]]);
         XCTAssertTrue([finished isKindOfClass:[NSNumber class]]);
         
     } error:^(NSError *error) {
         XCTFail();
     }completed:^ {
         BlockFinished();
     }];
    
    WaitForBlock();
}

- (void)testFetchOrganizer {
    TestNeedsToWaitForBlock();
    
    [[self.client fetchOrganizerInfoForId:kTestOrganizerId]
     subscribeNext:^(id x) {
         XCTAssertTrue([x isKindOfClass:[MXLEventBriteOrganizer class]]);
    }error:^(NSError *error) {
        XCTFail();
    }completed:^ {
        BlockFinished();
    }];
    
    WaitForBlock();
}

@end
