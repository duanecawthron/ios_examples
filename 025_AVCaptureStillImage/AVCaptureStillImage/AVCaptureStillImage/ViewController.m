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
@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;

@end

@implementation ViewController

@synthesize captureManager = _captureManager;
@synthesize assetsLibrary = _assetsLibrary;

- (ALAssetsLibrary *) assetsLibrary
{
    if (!_assetsLibrary) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    return _assetsLibrary;
}
    
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
    NSLog(@"captureManager:didCaptureStillImage with EXIF data %@", EXIFdata);
    
    // write to camera roll
#if 1
    // Allocate only one ALAssetsLibrary
    [self.assetsLibrary writeImageDataToSavedPhotosAlbum:jpegImageData metadata:EXIFdata completionBlock:nil];
#else
    // memory leaks if you allocate ALAssetsLibrary each time
    // Apple's AVCam sample code also leaks memory
    // the leak is intermittent
    // if you take about 20 pictures, you should see a memory leak in Instruments
    // Malloc 48 bytes by [ALAssetsLibrary init]
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    // memory does not leak if yo do not call writeImageDataToSavedPhotosAlbum:metadata:completionBlock:
    EXIFdata = nil; // make sure this is not causing the problem
    [library writeImageDataToSavedPhotosAlbum:jpegImageData metadata:EXIFdata completionBlock:nil];
#endif
}

@end
