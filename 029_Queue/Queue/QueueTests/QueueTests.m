//
//  QueueTests.m
//  QueueTests
//
//  Created by Duane Cawthron on 5/17/12.
//  Copyright (c) 2012 Cawthron Consulting Services, Inc. All rights reserved.
//

#import "QueueTests.h"
#import "DCQueue.h"

@implementation QueueTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    DCQueue *q = [[DCQueue alloc] init];
    
    [q enqueue:@"object1"];
    [q enqueue:@"object2"];
    [q enqueue:@"object3"];
    
    NSString *s;
    s = [q dequeue]; NSAssert([s isEqualToString:@"object1"], @"expected object1");
    s = [q dequeue]; NSAssert([s isEqualToString:@"object2"], @"expected object2");
    s = [q dequeue]; NSAssert([s isEqualToString:@"object3"], @"expected object3");
}

@end
