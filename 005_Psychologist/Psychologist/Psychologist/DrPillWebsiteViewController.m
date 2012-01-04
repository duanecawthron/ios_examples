//
//  DrPillWebsiteViewController.m
//  Psychologist
//
//  Created by cawthron on 1/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DrPillWebsiteViewController.h"

@interface DrPillWebsiteViewController()
@property (nonatomic, weak) IBOutlet UIWebView *webView;
@end

@implementation DrPillWebsiteViewController

@synthesize webView;

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.webView.scalesPageToFit = YES;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://google.com"]]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
