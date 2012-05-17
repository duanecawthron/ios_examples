//
//  DCTimer.m
//  Timer
//
//  Created by Duane Cawthron on 5/16/12.
//  Copyright (c) 2012 Cawthron Consulting Services, Inc. All rights reserved.
//

#import "DCTimer.h"


@interface DCTimerQueue : NSObject
@property (nonatomic, strong) NSMutableSet *runningTimers;
+ (DCTimerQueue *)sharedInstance;
@end

@implementation DCTimerQueue

@synthesize runningTimers = _runningTimers;

- (NSMutableSet *)runningTimers
{
    if (!_runningTimers) _runningTimers = [NSMutableSet setWithCapacity:10];
    return _runningTimers;
}

+ (DCTimerQueue *)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

@end



@interface DCTimer ()

@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, copy)   void (^block)(void);

@end

@implementation DCTimer

@synthesize enabled = _enabled;
@synthesize block = _block;

- (void) afterDelay: (NSTimeInterval) delay performBlock: (void (^)(void))block {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    dispatch_after( popTime,  dispatch_get_main_queue(), block);
} // -afterDelay:performBlock: from Andrew Donoho

- (DCTimer *)initWithDelay:(NSTimeInterval)delayInSeconds performBlock:(void (^)(void))block
{
    if (self = [super init]) {
        self.enabled = YES;
        self.block = block;
        [[DCTimerQueue sharedInstance].runningTimers addObject:self];
        [self afterDelay:delayInSeconds performBlock: ^{
            if (self.enabled) self.block();
            [[DCTimerQueue sharedInstance].runningTimers removeObject:self];
        }];
    }
    return self;
}

- (void)cancel
{
    self.enabled = NO;
}

@end
