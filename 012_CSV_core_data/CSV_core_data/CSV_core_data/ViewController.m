//
//  ViewController.m
//  CSV_parser
//
//  Created by Duane Cawthron on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "NSString+ParsingExtension.h"

@implementation ViewController

- (void)demoParser
{
    NSError* error = nil;
    NSString *path = [[NSBundle mainBundle] pathForResource: @"population" ofType: @"csv"];
    NSString *data = [NSString stringWithContentsOfFile: path encoding:NSUTF8StringEncoding error: &error];
    NSLog(@"%@", data);
    
    NSArray *rows = [data csvRows];
    NSLog(@"%@", rows);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self demoParser];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
