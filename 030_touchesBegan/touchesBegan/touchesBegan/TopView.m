//
//  TopView.m
//  touchesBegan
//
//  Created by Duane Cawthron on 5/21/12.
//  Copyright (c) 2012 Cawthron Consulting Services, Inc. All rights reserved.
//

#import "TopView.h"

@implementation TopView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"TopView touchesBegan");
    [super touchesBegan:touches withEvent:event];
    // touchesBegan will be handled here and by the super view
}

@end
