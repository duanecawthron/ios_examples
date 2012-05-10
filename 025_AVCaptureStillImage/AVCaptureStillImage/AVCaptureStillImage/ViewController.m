//
//  ViewController.m
//  AVCaptureStillImage
//
//  Created by Duane Cawthron on 5/10/12.
//  Copyright (c) 2012 Cawthron Consulting Services, Inc. All rights reserved.
//

#import "ViewController.h"
#import "DCCaptureManager.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController () <DCCaptureManagerDelegate>

@property (nonatomic, strong) DCCaptureManager *captureManager;
@end

@implementation ViewController

@synthesize captureManager = _captureManager;

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    [self.captureManager captureStillImage];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.captureManager = [[DCCaptureManager alloc] initWithView:self.view];
    self.captureManager.delegate = self;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // camera wants UIInterfaceOrientationPortrait
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - DCCaptureManagerDelegate

- (void)captureManagerDidStartRunning:(DCCaptureManager *)captureManager
{
    NSLog(@"captureManagerDidStartRunning");
}

- (void)captureManager:(DCCaptureManager *)captureManager didFailWithError:(NSError *)error
{
    NSLog(@"captureManager:(DCCaptureManager:didFailWithError");
}

- (void)captureManager:(DCCaptureManager *)captureManager didCaptureStillImage:(NSData *)jpegImageData withMetadata:(NSDictionary *)EXIFdata
{
    NSLog(@"captureManager:didCaptureStillImage with EXIT data %@", EXIFdata);
    
    // write to camera roll
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library writeImageDataToSavedPhotosAlbum:jpegImageData metadata:EXIFdata completionBlock:nil];
}

@end
