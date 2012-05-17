//
//  TimerTests.m
//  TimerTests
//
//  Created by Duane Cawthron on 5/16/12.
//  Copyright (c) 2012 Cawthron Consulting Services, Inc. All rights reserved.
//

#import "TimerTests.h"
#import "DCTimer.h"

@implementation TimerTests

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

- (void) afterDelay: (NSTimeInterval) delay performBlock: (void (^)(void))block {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    dispatch_after( popTime,  dispatch_get_main_queue(), block);
} // -afterDelay:performBlock: from Andrew Donoho

- (void)testExample
{
    __block int i = 0;

    NSLog(@"\n timer0");
    
    DCTimer *timer1 = [[DCTimer alloc] initWithDelay:0.1 performBlock:^{
        NSLog(@"\n timer1");
        i = 1;
    }];
    
    DCTimer *timer2 = [[DCTimer alloc] initWithDelay:0.2 performBlock:^{
        NSLog(@"\n timer2");
        i = 2;
    }];
    
    DCTimer *timer3 = [[DCTimer alloc] initWithDelay:0.3 performBlock:^{
        NSLog(@"\n timer3");
        NSAssert(i == 1, @"expecxted i == 1");
    }];
    
    [timer2 cancel];
    
    // The following is required for the dispatched blocks to run.
    // Blocks submitted to the main queue will be executed as part of the "common modes" of the application's main NSRunLoop or CFRunLoop.
    // http://stackoverflow.com/questions/7817605/pattern-for-unit-testing-async-queue-that-calls-main-queue-on-completion
    NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:0.5];
    while ([loopUntil timeIntervalSinceNow] > 0) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:loopUntil];
    }
    
    NSAssert(i == 1, @"expecxted i == 1");
}

@end
