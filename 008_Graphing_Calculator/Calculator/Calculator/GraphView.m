//
//  GraphView.m
//  Calculator
//
//  Created by Duane Cawthron on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GraphView.h"
#import "AxesDrawer.h"

@implementation GraphView

@synthesize dataSource = _dataSource;
@synthesize scale = _scale;
@synthesize origin = _origin;

- (void)drawRect:(CGRect)rect
{
    CGPoint midPoint;
    midPoint.x = self.bounds.origin.x + self.bounds.size.width/2;
    midPoint.y = self.bounds.origin.y + self.bounds.size.height/2;

    [AxesDrawer drawAxesInRect:self.bounds
                 originAtPoint:midPoint
                         scale:1.0];

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 5.0);
    [[UIColor blueColor] setStroke];
    
    UIGraphicsPushContext(context);

    CGContextMoveToPoint(context, self.bounds.origin.x, self.bounds.origin.y);
    CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height);
	CGContextStrokePath(context);

	UIGraphicsPopContext();
}

@end
