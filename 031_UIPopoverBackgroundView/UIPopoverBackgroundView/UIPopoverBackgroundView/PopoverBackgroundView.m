//
//  PopoverBackgroundView.m
//  UIPopoverBackgroundView
//
//  Created by Duane Cawthron on 5/29/12.
//  Copyright (c) 2012 Cawthron Consulting Services, Inc. All rights reserved.
//

#import "PopoverBackgroundView.h"

@interface PopoverBackgroundView ()

@property (nonatomic, strong) UIImageView *backgroundView;
@property (nonatomic, strong) UIImageView *arrowView;

@end


@implementation PopoverBackgroundView

@synthesize arrowOffset = _arrowOffset;         // defined in UIPopoverBackgroundView
@synthesize arrowDirection = _arrowDirection;   // defined in UIPopoverBackgroundView

@synthesize backgroundView = _backgroundView;
@synthesize arrowView = _arrowView;

/* The arrow offset represents how far from the center of the view the center of the arrow should appear.
 For `UIPopoverArrowDirectionUp` and `UIPopoverArrowDirectionDown`, this is a left-to-right offset; negative is to the left.
 For `UIPopoverArrowDirectionLeft` and `UIPopoverArrowDirectionRight`, this is a top-to-bottom offset; negative to toward the top.
 This method is called inside an animation block managed by the `UIPopoverController`.
 
 arrowDirection manages which direction the popover arrow is pointing.
 You may be required to change the direction of the arrow while the popover is still visible on-screen.
 */

/* These methods must be overridden and the values they return may not be changed during use of the `UIPopoverBackgroundView`. `arrowHeight` represents the height of the arrow in points from its base to its tip. `arrowBase` represents the the length of the base of the arrow's triangle in points. `contentViewInset` describes the distance between each edge of the background view and the corresponding edge of its content view (i.e. if it were strictly a rectangle). `arrowHeight` and `arrowBase` are also used for the drawing of the standard popover shadow.
 */

#define kArrowHeight 14.0
#define kArrowBase 14.0
#define kContentViewInset 10.0

+ (CGFloat)arrowHeight
{
    return kArrowHeight;
}

+ (CGFloat)arrowBase
{
    return kArrowBase;
}

+ (UIEdgeInsets)contentViewInsets
{
    return UIEdgeInsetsMake(kContentViewInset, kContentViewInset, kContentViewInset, kContentViewInset);
}

#pragma mark - UIView Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        UIImage *image = [UIImage imageNamed:@"PopoverBackground.png"];
		UIImage *stretchableImage = [image stretchableImageWithLeftCapWidth:floor(image.size.width/2.0) topCapHeight:floor(image.size.height/2.0)];
        self.backgroundView = [[UIImageView alloc] initWithImage:stretchableImage];
        [self addSubview:self.backgroundView];
        
        self.arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PopoverUpArrow.png"]];
        [self addSubview:self.arrowView];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGFloat dxBackground;
    CGFloat dyBackground;
    CGFloat dxArrow;
    CGFloat dyArrow;
    CGFloat degrees;
    
    if (self.arrowDirection == UIPopoverArrowDirectionUp) {
        dxBackground = 0.0;
        dyBackground = kArrowHeight/2;
        degrees = 0;
        dxArrow = self.bounds.size.width/2 + self.arrowOffset;
        dyArrow = kArrowHeight/2;
    } else if (self.arrowDirection == UIPopoverArrowDirectionRight) {
        dxBackground = -kArrowHeight/2;
        dyBackground = 0.0;
        degrees = 90;
        dxArrow = self.bounds.size.width - kArrowHeight/2;
        dyArrow = self.bounds.size.height/2 + self.arrowOffset;
    } else if (self.arrowDirection == UIPopoverArrowDirectionDown) {
        dxBackground = 0.0;
        dyBackground = -kArrowHeight/2;
        degrees = 180;
        dxArrow = self.frame.size.width/2 + self.arrowOffset;
        dyArrow = self.bounds.size.height - kArrowHeight/2;
    } else if (self.arrowDirection == UIPopoverArrowDirectionLeft) {
        dxBackground = kArrowHeight/2;
        dyBackground = 0.0;
        degrees = 270;
        dxArrow = kArrowHeight/2;
        dyArrow = self.bounds.size.height/2 + self.arrowOffset;
    } else NSLog(@"ERROR: unexpected UIPopoverArrowDirection");
    
    self.backgroundView.frame = CGRectInset(self.bounds, fabs(dxBackground), fabs(dyBackground));
    self.backgroundView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, dxBackground, dyBackground);
    
    self.arrowView.center = CGPointZero;
    self.arrowView.transform = CGAffineTransformIdentity;
    self.arrowView.transform = CGAffineTransformTranslate(self.arrowView.transform, dxArrow, dyArrow);
    self.arrowView.transform = CGAffineTransformRotate(self.arrowView.transform, degrees * M_PI/180.0);
    
    //NSLog(@"self.backgroundView.frame %@, self.backgroundView.center %@", NSStringFromCGRect(self.backgroundView.frame), NSStringFromCGPoint(self.backgroundView.center));
   // NSLog(@"self.arrowView.center %@, dx %g, dy %g", NSStringFromCGPoint(self.arrowView.center), dxArrow, dyArrow);
}

@end

