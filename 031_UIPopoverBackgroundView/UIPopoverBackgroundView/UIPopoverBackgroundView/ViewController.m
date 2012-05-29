//
//  ViewController.m
//  UIPopoverBackgroundView
//
//  Created by Duane Cawthron on 5/28/12.
//  Copyright (c) 2012 Cawthron Consulting Services, Inc. All rights reserved.
//

#import "ViewController.h"
#import "PopoverBackgroundView.h"

@interface ViewController () <UIPopoverControllerDelegate>

@property (nonatomic, strong) UIPopoverController *myPopoverController;

@end

@implementation ViewController

@synthesize myPopoverController = _myPopoverController;

- (IBAction)popoverButtonPressed:(UIButton *)sender {
    if (self.myPopoverController) {
		[self.myPopoverController dismissPopoverAnimated:YES];
		self.myPopoverController = nil;
    }
    
    UIPopoverArrowDirection arrowDirection;
    if ([sender.titleLabel.text isEqualToString:@"Left"]) arrowDirection = UIPopoverArrowDirectionRight;
    else if ([sender.titleLabel.text isEqualToString:@"Right"]) arrowDirection = UIPopoverArrowDirectionLeft;
    else if ([sender.titleLabel.text isEqualToString:@"Up"]) arrowDirection = UIPopoverArrowDirectionDown;
    else if ([sender.titleLabel.text isEqualToString:@"Down"]) arrowDirection = UIPopoverArrowDirectionUp;
        
    UIViewController *popoverViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Popover"];
    self.myPopoverController = [[UIPopoverController alloc] initWithContentViewController:popoverViewController];
    self.myPopoverController.popoverContentSize = CGSizeMake(200.0, 100.0);
    self.myPopoverController.delegate = self;
    
    self.myPopoverController.popoverBackgroundViewClass = [PopoverBackgroundView class];
    
    [self.myPopoverController presentPopoverFromRect:sender.frame 
                                              inView:self.view 
                            permittedArrowDirections:arrowDirection
                                            animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - UIPopoverControllerDelegate

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{   
    return YES;
}
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    //NSLog(@"popoverControllerDidDismissPopover");
}

@end
