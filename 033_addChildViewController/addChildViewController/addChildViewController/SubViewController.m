//
//  SubViewController.m
//  TouchViewControlelr
//
//  Created by Duane Cawthron on 6/6/12.
//  Copyright (c) 2012 Cawthron Consulting Services, Inc. All rights reserved.
//

#import "SubViewController.h"

@interface SubViewController ()

@end

@implementation SubViewController

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"SubViewController touchesBegan");
    [super touchesBegan:touches withEvent:event];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillUnload
{
    [super viewWillUnload];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (void)willMoveToParentViewController:(UIViewController *)parent
{
    
}
- (void)didMoveToParentViewController:(UIViewController *)parent
{
    
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    // the sub view is intended to overlay the main view.
    // when the device is rotated, the bounds of the main view is updated
    // update the frame of the sub view to match the main view
    
    //self.view.frame = self.view.superview.bounds;
    // NOTE: this is not required if UIViewAutoresizingFlexibleWidth is set properly
    // subViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // triggers - (void)viewDidLayoutSubviews
    
    NSLog(@"SubView frame %@, bounds %@", NSStringFromCGRect(self.view.frame), NSStringFromCGRect(self.view.bounds));
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES; //(interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
