//
//  Test3ViewController.m
//  GestureBlocksTouch
//
//  Created by Duane Cawthron on 6/5/12.
//  Copyright (c) 2012 Cawthron Consulting Services, Inc. All rights reserved.
//

#import "Test3ViewController.h"

@interface Test3ViewController ()

@end

@implementation Test3ViewController

- (IBAction)buttonPressed:(UIButton *)sender
{
    NSLog(@"Test3ViewController buttonPressed");
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer
{
    NSLog(@"Test3ViewController handleTap");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    //tapRecognizer.cancelsTouchesInView = NO;
    
    UIView *view6 = [self.view viewWithTag:6];
    [view6 addGestureRecognizer:tapRecognizer];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
