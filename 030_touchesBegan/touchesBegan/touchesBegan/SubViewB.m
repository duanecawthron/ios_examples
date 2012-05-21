//
//  SubViewB.m
//  touchesBegan
//
//  Created by Duane Cawthron on 5/21/12.
//  Copyright (c) 2012 Cawthron Consulting Services, Inc. All rights reserved.
//

#import "SubViewB.h"

@implementation SubViewB

// The default implementation of this method does nothing. However immediate UIKit subclasses of UIResponder, particularly UIView, forward the message up the responder chain. To forward the message to the next responder, send the message to super (the superclass implementation); do not send the message directly to the next responder. For example, [super touchesBegan:touches withEvent:event];
// Do not call [self.nextResponder touchesBegan:touches withEvent:event];

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"SubViewB touchesBegan");
    [super touchesBegan:touches withEvent:event];
    // touchesBegan will be handled here and by the super view
}


@end
