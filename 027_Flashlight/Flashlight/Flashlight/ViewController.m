//
//  ViewController.m
//  Flashlight
//
//  Created by Duane Cawthron on 5/12/12.
//  Copyright (c) 2012 Cawthron Consulting Services, Inc. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *powerSwitch;
@end

@implementation ViewController

- (void)flipSwitchOn:(BOOL)on
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch] && [device isTorchModeSupported:AVCaptureTorchModeOn]) {
        NSError *error;
        if ([device lockForConfiguration:&error]) {
            if (on) [device setTorchMode:AVCaptureTorchModeOn];
            else [device setTorchMode:AVCaptureTorchModeOff];
            [device unlockForConfiguration];
        }
    }
    
    [self.powerSwitch setOn:on animated:YES];
}

@synthesize powerSwitch;

- (IBAction)powerSwitch:(UISwitch *)sender {
    [self flipSwitchOn:sender.isOn];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self flipSwitchOn:YES];
}

- (void)viewDidUnload
{
    [self setPowerSwitch:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
