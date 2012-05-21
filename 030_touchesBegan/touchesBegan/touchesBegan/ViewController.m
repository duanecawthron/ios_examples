//
//  ViewController.m
//  touchesBegan
//
//  Created by Duane Cawthron on 5/21/12.
//  Copyright (c) 2012 Cawthron Consulting Services, Inc. All rights reserved.
//

#import "ViewController.h"
#import "SubViewA.h"
#import "SubViewB.h"
#import "SubViewC.h"

@interface ViewController ()

@property (nonatomic, strong) SubViewA *subViewA;
@property (nonatomic, strong) SubViewB *subViewB;
@property (nonatomic, strong) SubViewC *subViewC;

@end


@implementation ViewController

@synthesize subViewA = _subviewA;
@synthesize subViewB = _subviewB;
@synthesize subViewC = _subviewC;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"ViewController touchesBegan");
}

- (void)setup
{
    self.subViewA = [[SubViewA alloc] initWithImage:[UIImage imageNamed:@"SubViewA.png"]];
    self.subViewB = [[SubViewB alloc] initWithImage:[UIImage imageNamed:@"SubViewB.png"]];
    self.subViewC = [[SubViewC alloc] initWithImage:[UIImage imageNamed:@"SubViewC.png"]];
    
    [self.view addSubview:self.subViewA];
    [self.view addSubview:self.subViewB];
    [self.view addSubview:self.subViewC];

    self.subViewA.center = CGPointMake(CGRectGetMidX(self.view.bounds), 100.0);
    self.subViewB.center = CGPointMake(CGRectGetMidX(self.view.bounds), 200.0);
    self.subViewC.center = CGPointMake(CGRectGetMidX(self.view.bounds), 300.0);

    self.view.userInteractionEnabled = YES;
    self.view.exclusiveTouch = NO;
    self.subViewA.userInteractionEnabled = YES;
    self.subViewB.userInteractionEnabled = YES;
    self.subViewC.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapTop:)];
    [self.view addGestureRecognizer:tapRecognizer];
    
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapA:)];
    [self.subViewA addGestureRecognizer:tapRecognizer];
    
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapB:)];
    [self.subViewB addGestureRecognizer:tapRecognizer];
    
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapC:)];
    [self.subViewC addGestureRecognizer:tapRecognizer];
}

- (void)handleTapTop:(UITapGestureRecognizer *)recognizer
{
    NSLog(@"handleTapTop");
}

- (void)handleTapA:(UITapGestureRecognizer *)recognizer
{
    NSLog(@"handleTapA");
}

- (void)handleTapB:(UITapGestureRecognizer *)recognizer
{
    NSLog(@"handleTapB");
}

- (void)handleTapC:(UITapGestureRecognizer *)recognizer
{
    NSLog(@"handleTapC");
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setup];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
