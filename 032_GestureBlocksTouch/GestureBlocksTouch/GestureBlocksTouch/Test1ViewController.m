//
//  Test1ViewController.m
//  GestureBlocksTouch
//
//  Created by Duane Cawthron on 6/5/12.
//  Copyright (c) 2012 Cawthron Consulting Services, Inc. All rights reserved.
//

#import "Test1ViewController.h"

@interface Test1ViewController ()

@end

@implementation Test1ViewController

- (IBAction)buttonPressed:(UIButton *)sender
{
    NSLog(@"Test1ViewController buttonPressed");
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer
{
    NSLog(@"Test1ViewController handleTap");
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    //tapRecognizer.cancelsTouchesInView = NO;
    
    UIView *view2 = [self.view viewWithTag:2];
    [view2 addGestureRecognizer:tapRecognizer];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
