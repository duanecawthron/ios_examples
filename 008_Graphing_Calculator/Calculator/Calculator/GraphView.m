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

#define DEFAULT_SCALE 1.0

- (CGFloat)scale
{
    if (!_scale) {
        return DEFAULT_SCALE;
    } else {
        return _scale;
    }
}

- (void)setScale:(CGFloat)scale
{
    if (scale != _scale) {
        _scale = scale;
        [self setNeedsDisplay];
    }
}

- (IBAction)handlePinch:(UIPinchGestureRecognizer *)gesture
{
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded)) {
        self.scale *= gesture.scale;
        gesture.scale = 1;
    }
}

- (CGPoint)origin
{
    return _origin;
}

- (void)setOrigin:(CGPoint)origin
{
    if (origin.x != _origin.x || origin.y != _origin.y) {
        _origin = origin;
        [self setNeedsDisplay];
    }
}

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint translation = [recognizer translationInView:self];
    self.origin = CGPointMake(self.origin.x + translation.x, 
                                         self.origin.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self];
}

- (void)drawRect:(CGRect)rect
{
    NSString *description = [self.dataSource descriptionOfGraph:self];
    NSLog(@"%@", description);

    CGPoint midPoint;
    midPoint.x = self.bounds.origin.x + self.bounds.size.width/2;
    midPoint.y = self.bounds.origin.y + self.bounds.size.height/2;

    CGRect myBounds;
    myBounds.origin.x = self.bounds.origin.x;
    myBounds.origin.y = self.bounds.origin.y;
    myBounds.size.width = self.bounds.size.width;
    myBounds.size.height = self.bounds.size.height;

    //myBounds.origin.x = self.bounds.origin.x + 10;
    //myBounds.origin.y = self.bounds.origin.y + 10;
    //myBounds.size.width = self.bounds.size.width - 10;
    //myBounds.size.height = self.bounds.size.height - 10;

    [AxesDrawer drawAxesInRect:myBounds
                 originAtPoint:self.origin
                         scale:self.scale];

    //NSLog(@"bounds %g,%g width= %g, height= %g", myBounds.origin.x, myBounds.origin.y, myBounds.size.width, myBounds.size.height);
    //NSLog(@"origin %g,%g", self.origin.x, self.origin.y);
    //NSLog(@"sclae %g", self.scale);
    //NSLog(@"x points= %g,%g val= %g,%g", myBounds.origin.x - self.origin.x, myBounds.origin.x - self.origin.x + myBounds.size.width,
    //      (myBounds.origin.x - self.origin.x) / self.scale, (myBounds.origin.x - self.origin.x + myBounds.size.width) / self.scale);

    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);

    CGContextSetLineWidth(context, 5.0);
    [[UIColor blueColor] setStroke];

    CGFloat x = myBounds.origin.x;
    CGFloat xScaled = (x - self.origin.x) / self.scale;
    CGFloat yScaled = xScaled;
    CGFloat y = self.origin.y - (yScaled * self.scale);
    //NSLog(@"moveto %g.%g scaled= %g,%g", x, y, xScaled, yScaled);
    CGContextMoveToPoint(context, x, y);

    for (x += 1; x <= myBounds.size.width; x += 1) {
        xScaled = (x - self.origin.x) / self.scale;
        //yScaled = xScaled;
        yScaled = [self.dataSource yValueForGraphView:self forXValue:xScaled];
        y = self.origin.y - (yScaled * self.scale);
        //NSLog(@"drawto %g.%g scaled= %g,%g", x, y, xScaled, yScaled);
        CGContextAddLineToPoint(context, x, y);
    }

	CGContextStrokePath(context);
	UIGraphicsPopContext();
}

@end
