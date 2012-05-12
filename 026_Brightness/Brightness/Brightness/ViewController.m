//
//  ViewController.m
//  Brightness
//
//  Created by Duane Cawthron on 5/12/12.
//  Copyright (c) 2012 Cawthron Consulting Services, Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISlider *brightnessSlider;
@end

@implementation ViewController

@synthesize brightnessSlider = _brightnessSlider;

- (IBAction)brightnessSlider:(UISlider *)sender {
    if (self.brightnessSlider.value >= 0.0 && self.brightnessSlider.value <= 1.0)
        [UIScreen mainScreen].brightness = self.brightnessSlider.value;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    self.brightnessSlider.minimumValue = 0.0;
    self.brightnessSlider.maximumValue = 1.0;
}

- (void)viewDidUnload
{
    [self setBrightnessSlider:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.brightnessSlider setValue:[UIScreen mainScreen].brightness animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
