//
//  ViewController.m
//  TouchViewControlelr
//
//  Created by Duane Cawthron on 6/6/12.
//  Copyright (c) 2012 Cawthron Consulting Services, Inc. All rights reserved.
//

#import "ViewController.h"
#import "SubViewController.h"
#import "View.h"

@interface ViewController ()

@end

@implementation ViewController

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"ViewController touchesBegan");
    [super touchesBegan:touches withEvent:event];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
#if 0
    SubViewController *subViewController = [[SubViewController alloc] init];
    // alloc/init does not enable calling of any lifecycle methods
    
    View *view = [[View alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor yellowColor];
    subViewController.view = view;
    [self.view addSubview:subViewController.view];
    
    // these are NOT called
    // - (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
    // - (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
    
    // these are called when the subview is touched (not the buttons)
    // View touchesBegan
    // NOTE: this one is NOT called, SubViewController touchesBegan
    // View touchesBegan
    // ViewController touchesBegan
#endif
#if 0
    SubViewController *subViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SubViewController"];
    // instantiating from the storyboard enables calling some lifecycle methods
    
    subViewController.view.frame = self.view.bounds;
    // - (void)viewDidLoad
    
    [self.view addSubview:subViewController.view];
    
    // these are called later in the run loop 
    // - (void)viewWillAppear:(BOOL)animated
    // - (void)viewDidLayoutSubviews
    // - (void)viewDidAppear:(BOOL)animated
    
    // these are NOT called
    // - (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
    // - (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
    
    // these are called when the subview is touched (not the buttons)
    // View touchesBegan
    // NOTE: this one is NOT called, SubViewController touchesBegan
    // View touchesBegan
    // ViewController touchesBegan
#endif
#if 1
    SubViewController *subViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SubViewController"];
    subViewController.view.frame = self.view.bounds;
    // - (void)viewDidLoad
    
    subViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:subViewController.view];
    
    [self addChildViewController:subViewController];
    // - (void)willMoveToParentViewController:(UIViewController *)parent
    
    // NOTE addChildViewController: adds the SubViewController to the responder chain used to handle events

    [subViewController didMoveToParentViewController:self];
    // - (void)didMoveToParentViewController:(UIViewController *)parent
    
    // these are called later in the run loop 
    // - (void)viewWillAppear:(BOOL)animated
    // - (void)viewDidLayoutSubviews
    // - (void)viewDidAppear:(BOOL)animated
    
    // these are called when the device is rotated
    // - (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
    // - (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
    // these are called when the subview is touched (not the buttons)
    // View touchesBegan
    // SubViewController touchesBegan, this is called because SubViewController was added to the responder chain
    // View touchesBegan
    // ViewController touchesBegan
#endif
#if 0
    dispatch_async(dispatch_get_main_queue(), ^{
        [subViewController.view removeFromSuperview];
        // - (void)viewWillDisappear:(BOOL)animated
        
        [subViewController removeFromParentViewController];
        // - (void)willMoveToParentViewController:(UIViewController *)parent (parent = nil)
        // - (void)viewDidDisappear:(BOOL)animated
    });
#endif
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewDidAppear:(BOOL)animated
{

}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    NSLog(@"View frame %@, bounds %@", NSStringFromCGRect(self.view.frame), NSStringFromCGRect(self.view.bounds));
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES; // (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
