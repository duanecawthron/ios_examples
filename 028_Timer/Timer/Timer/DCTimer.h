//
//  DCTimer.h
//  Timer
//
//  Created by Duane Cawthron on 5/16/12.
//  Copyright (c) 2012 Cawthron Consulting Services, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCTimer : NSObject

- (DCTimer *)initWithDelay:(NSTimeInterval)delayInSeconds performBlock:(void (^)(void))block;
- (void)cancel;

@end
