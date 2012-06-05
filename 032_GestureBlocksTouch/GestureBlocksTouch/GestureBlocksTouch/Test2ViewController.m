//
//  Test2ViewController.m
//  GestureBlocksTouch
//
//  Created by Duane Cawthron on 6/5/12.
//  Copyright (c) 2012 Cawthron Consulting Services, Inc. All rights reserved.
//

#import "Test2ViewController.h"

@interface Test2ViewController ()

@end

@implementation Test2ViewController

- (IBAction)buttonPressed:(UIButton *)sender
{
    NSLog(@"Test2ViewController buttonPressed");
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer
{
    NSLog(@"Test2ViewController handleTap");
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    //tapRecognizer.cancelsTouchesInView = NO;
    
    UIView *view4 = [self.view viewWithTag:4];
    [view4 addGestureRecognizer:tapRecognizer];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
