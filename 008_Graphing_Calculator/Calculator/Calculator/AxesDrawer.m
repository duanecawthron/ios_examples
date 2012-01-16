//
//  AxesDrawer.m
//  Calculator
//
//  Created by CS193p Instructor.
//  Copyright (c) 2011 Stanford University. All rights reserved.
//

#import "AxesDrawer.h"

@implementation AxesDrawer

#define ANCHOR_CENTER 0
#define ANCHOR_TOP 1
#define ANCHOR_LEFT 2
#define ANCHOR_BOTTOM 3
#define ANCHOR_RIGHT 4

#define HASH_MARK_FONT_SIZE 12.0

#define HORIZONTAL_TEXT_MARGIN 6
#define VERTICAL_TEXT_MARGIN 3

+ (void)drawString:(NSString *)text atPoint:(CGPoint)location withAnchor:(int)anchor
{
	if ([text length])
	{
		UIFont *font = [UIFont systemFontOfSize:HASH_MARK_FONT_SIZE];
		
		CGRect textRect;
		textRect.size = [text sizeWithFont:font];
		textRect.origin.x = location.x - textRect.size.width / 2;
		textRect.origin.y = location.y - textRect.size.height / 2;
		
		switch (anchor) {
			case ANCHOR_TOP: textRect.origin.y += textRect.size.height / 2 + VERTICAL_TEXT_MARGIN; break;
			case ANCHOR_LEFT: textRect.origin.x += textRect.size.width / 2+ HORIZONTAL_TEXT_MARGIN; break;
			case ANCHOR_BOTTOM: textRect.origin.y -= textRect.size.height / 2 + VERTICAL_TEXT_MARGIN; break;
			case ANCHOR_RIGHT: textRect.origin.x -= textRect.size.width / 2+ HORIZONTAL_TEXT_MARGIN; break;
		}
		
		[text drawInRect:textRect withFont:font];
	}
}

#define HASH_MARK_SIZE 3
#define MIN_PIXELS_PER_HASHMARK 25

+ (void)drawHashMarksInRect:(CGRect)bounds originAtPoint:(CGPoint)axisOrigin scale:(CGFloat)pointsPerUnit
{
	if (!pointsPerUnit) return;

	if (((axisOrigin.x < bounds.origin.x) || (axisOrigin.x > bounds.origin.x+bounds.size.width)) &&
		((axisOrigin.y < bounds.origin.y) || (axisOrigin.y > bounds.origin.y+bounds.size.height))) {
		return;
	}

	int unitsPerHashmark = MIN_PIXELS_PER_HASHMARK * 2 / pointsPerUnit;
	if (!unitsPerHashmark) unitsPerHashmark = 1;
	CGFloat pixelsPerHashmark = pointsPerUnit * unitsPerHashmark;

	BOOL boundsContainsOrigin = CGRectContainsPoint(bounds, axisOrigin);
	if (boundsContainsOrigin) {
		if ((axisOrigin.x - pixelsPerHashmark < bounds.origin.x) &&
			(axisOrigin.x + pixelsPerHashmark > bounds.origin.x + bounds.size.width) &&
			(axisOrigin.y - pixelsPerHashmark < bounds.origin.y) &&
			(axisOrigin.y + pixelsPerHashmark > bounds.origin.y + bounds.size.height)) {
			return;
		}
	} else {
		if ((axisOrigin.y >= bounds.origin.y) &&
			(axisOrigin.y <= bounds.origin.y+bounds.size.height) &&
			(bounds.size.width <= pixelsPerHashmark)) {
			return;
		}
		if ((axisOrigin.x >= bounds.origin.x) &&
			(axisOrigin.x <= bounds.origin.x+bounds.size.width) &&
			(bounds.size.height <= pixelsPerHashmark)) {
			return;
		}
	}
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextBeginPath(context);
	

	int started = NO;
	int stillGoing = YES;

	for (int offset = unitsPerHashmark; !started || stillGoing; offset += unitsPerHashmark)
	{
		BOOL drew = NO;
		CGFloat scaledOffset = floor(offset * pointsPerUnit);
 		CGPoint hashMarkPoint;
		hashMarkPoint.x = axisOrigin.x+scaledOffset;
		hashMarkPoint.y = axisOrigin.y;
		if (CGRectContainsPoint(bounds, hashMarkPoint)) {
			CGContextMoveToPoint(context, hashMarkPoint.x, hashMarkPoint.y-HASH_MARK_SIZE);
			CGContextAddLineToPoint(context, hashMarkPoint.x, hashMarkPoint.y+HASH_MARK_SIZE);
			[self drawString:[NSString stringWithFormat:@"%d", offset] atPoint:hashMarkPoint withAnchor:ANCHOR_TOP];
			drew = YES;
		}
		hashMarkPoint.x = axisOrigin.x-scaledOffset;
		if (CGRectContainsPoint(bounds, hashMarkPoint)) {
			CGContextMoveToPoint(context, hashMarkPoint.x, hashMarkPoint.y-HASH_MARK_SIZE);
			CGContextAddLineToPoint(context, hashMarkPoint.x, hashMarkPoint.y+HASH_MARK_SIZE);
			[self drawString:[NSString stringWithFormat:@"%d", -offset] atPoint:hashMarkPoint withAnchor:ANCHOR_TOP];
			drew = YES;
		}
		hashMarkPoint.x = axisOrigin.x;
		hashMarkPoint.y = axisOrigin.y-scaledOffset;
		if (CGRectContainsPoint(bounds, hashMarkPoint)) {
			CGContextMoveToPoint(context, hashMarkPoint.x-HASH_MARK_SIZE, hashMarkPoint.y);
			CGContextAddLineToPoint(context, hashMarkPoint.x+HASH_MARK_SIZE, hashMarkPoint.y);
			[self drawString:[NSString stringWithFormat:@"%d", offset] atPoint:hashMarkPoint withAnchor:ANCHOR_LEFT];
			drew = YES;
		}
		hashMarkPoint.y = axisOrigin.y+scaledOffset;
		if (CGRectContainsPoint(bounds, hashMarkPoint)) {
			CGContextMoveToPoint(context, hashMarkPoint.x-HASH_MARK_SIZE, hashMarkPoint.y);
			CGContextAddLineToPoint(context, hashMarkPoint.x+HASH_MARK_SIZE, hashMarkPoint.y);
			[self drawString:[NSString stringWithFormat:@"%d", -offset] atPoint:hashMarkPoint withAnchor:ANCHOR_LEFT];
			drew = YES;
		}
		if (drew) started = YES;
		stillGoing = drew;
	}
	
	CGContextStrokePath(context);
}

+ (void)drawAxesInRect:(CGRect)bounds originAtPoint:(CGPoint)axisOrigin scale:(CGFloat)pointsPerUnit
{
	CGContextRef context = UIGraphicsGetCurrentContext();

	UIGraphicsPushContext(context);

	CGContextBeginPath(context);
	CGContextMoveToPoint(context, bounds.origin.x, axisOrigin.y);
	CGContextAddLineToPoint(context, bounds.origin.x+bounds.size.width, axisOrigin.y);
	CGContextMoveToPoint(context, axisOrigin.x, bounds.origin.y);
	CGContextAddLineToPoint(context, axisOrigin.x, bounds.origin.y+bounds.size.height);
	CGContextStrokePath(context);

	[self drawHashMarksInRect:bounds originAtPoint:axisOrigin scale:pointsPerUnit];

	UIGraphicsPopContext();
}

@end
