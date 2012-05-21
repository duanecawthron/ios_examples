//
//  SubViewC.m
//  touchesBegan
//
//  Created by Duane Cawthron on 5/21/12.
//  Copyright (c) 2012 Cawthron Consulting Services, Inc. All rights reserved.
//

#import "SubViewC.h"

@implementation SubViewC

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"SubViewC touchesBegan");
    // touchesBegan will be handled here, and will not be passed on to the super view
}

// If you override touchesBegan without calling super (a common use pattern), you must also override the other methods for handling touch events, if only as stub (empy) implementations.

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {}
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {}
- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {}

@end
