//
//  KitchenSinkViewController.m
//  KitchenSink
//
//  Created by Duane Cawthron on 2/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KitchenSinkViewController.h"
#import "AskerViewController.h"

@interface KitchenSinkViewController() <AskerViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *kitchenSink;
@property (weak, nonatomic) NSTimer *drainTImer;
@end

@implementation KitchenSinkViewController

@synthesize kitchenSink = _kitchenSink;
@synthesize drainTImer = _drainTImer;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier hasPrefix:@"Create Label"]) {
        AskerViewController *asker = (AskerViewController *)segue.destinationViewController;
        asker.question = @"What do you want your label to say?";
        asker.answer = @"Label Text";
        asker.delegate = self;
    }
}

- (void)setRandomLocationForView:(UIView *)view
{
    [view sizeToFit];
    CGRect sinkBounds = CGRectInset(self.kitchenSink.bounds, view.frame.size.width/2, view.frame.size.height/2);
    CGFloat x = arc4random() % (int)sinkBounds.size.width + view.frame.size.width/2;
    CGFloat y = arc4random() % (int)sinkBounds.size.height + view.frame.size.height/2;
    view.center = CGPointMake(x, y);
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mart Draining Timer

#define DRAIN_DURATION 3.0

- (void)drain
{
    for (UIView *view in self.kitchenSink.subviews) {
        CGAffineTransform transform = view.transform;
        if (CGAffineTransformIsIdentity(transform)) {
            UIViewAnimationOptions options = UIViewAnimationOptionCurveLinear;
            [UIView animateWithDuration:DRAIN_DURATION/3 delay:0 options:options animations:^{
                view.transform = CGAffineTransformRotate(CGAffineTransformScale(transform, 0.7, 0.7), 2*M_PI/3);
            } completion:^(BOOL finished) {
                if (finished) {
                    [UIView animateWithDuration:DRAIN_DURATION/3 delay:0 options:options animations:^{
                        view.transform = CGAffineTransformRotate(CGAffineTransformScale(transform, 0.4, 0.4), -2*M_PI/3);
                    } completion:^(BOOL finished) {
                        if (finished) {
                            [UIView animateWithDuration:DRAIN_DURATION/3 delay:0 options:options animations:^{
                                view.transform = CGAffineTransformScale(transform, 0.1, 0.1);
                            } completion:^(BOOL finished) {
                                if (finished) [view removeFromSuperview];
                            }];
                        }
                    }];
                }
            }];
        }
    }
}

- (void)drain:(NSTimer *)timer
{
    [self drain];
}

- (void)startDraining
{
    self.drainTImer = [NSTimer scheduledTimerWithTimeInterval:DRAIN_DURATION target:self selector:@selector(drain) userInfo:nil repeats:YES];
}

- (void)stopDraining
{
    [self.drainTImer invalidate];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self startDraining];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self stopDraining];
    [super viewWillDisappear:animated];
}


- (void)addLabel:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:48.0];
    label.backgroundColor = [UIColor clearColor];
    [self setRandomLocationForView:label];
    [self.kitchenSink addSubview:label];
}

#pragma mark Annimation of random location of labels

- (IBAction)tap:(UITapGestureRecognizer *)gesture
{
    CGPoint tapLocation = [gesture locationInView:self.kitchenSink];
    for (UIView *view in self.kitchenSink.subviews) {
        if (CGRectContainsPoint(view.frame, tapLocation)) {
            [UIView animateWithDuration:4.0 animations:^{
                [self setRandomLocationForView:view];
            }];
        }
    }
}

#pragma mark AskerViewControllerDelegate

- (void) askerViewController:(AskerViewController *)sender didAskQuestion:(NSString *)question andGotAnswer:(NSString *)answer
{
    [self addLabel:answer];
    [self dismissModalViewControllerAnimated:YES];
}

@end
