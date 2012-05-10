//
//  DCCaptureManager.m
//  DCCaptureManager
//
//  Created by Duane Cawthron on 5/9/12.
//  Copyright (c) 2012 Cawthron Consulting Services, Inc. All rights reserved.
//

#import "DCCaptureManager.h"
#import <ImageIO/CGImageProperties.h>


@interface DCCaptureManager ()

@property (nonatomic, assign) AVCaptureVideoOrientation orientation;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureDeviceInput *videoInput;
@property (nonatomic, strong) AVCaptureStillImageOutput *stillImageOutput;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;

@end


@implementation DCCaptureManager

@synthesize currentCamera = _currentCamera;
@synthesize delegate = _delegate;
@synthesize orientation = _orientation;
@synthesize session = _session;
@synthesize videoInput = _videoInput;
@synthesize stillImageOutput = _stillImageOutput;
@synthesize captureVideoPreviewLayer = _captureVideoPreviewLayer;

#pragma mark - Observe NSNotification deviceOrientationDidChange

- (void)deviceOrientationDidChange
{	
	UIDeviceOrientation deviceOrientation = [[UIDevice currentDevice] orientation];
    
	if (deviceOrientation == UIDeviceOrientationPortrait)
		self.orientation = AVCaptureVideoOrientationPortrait;
	else if (deviceOrientation == UIDeviceOrientationPortraitUpsideDown)
		self.orientation = AVCaptureVideoOrientationPortraitUpsideDown;
	
	// AVCapture and UIDevice have opposite meanings for landscape left and right (AVCapture orientation is the same as UIInterfaceOrientation)
	else if (deviceOrientation == UIDeviceOrientationLandscapeLeft)
		self.orientation = AVCaptureVideoOrientationLandscapeRight;
	else if (deviceOrientation == UIDeviceOrientationLandscapeRight)
		self.orientation = AVCaptureVideoOrientationLandscapeLeft;
	
	// Ignore device orientations for which there is no corresponding still image orientation (e.g. UIDeviceOrientationFaceUp)
}

- (void)setupDeviceOrientationDidChange
{
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange) name:UIDeviceOrientationDidChangeNotification object:nil];
    self.orientation = AVCaptureVideoOrientationPortrait;
}

- (void)tearDownDeviceOrientationDidChange
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
	[[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}

#pragma mark - AVCaptureSession

- (void)setupSessionWithView:(UIView *)view
{
    self.session = [[AVCaptureSession alloc] init];
    self.session.sessionPreset = AVCaptureSessionPresetPhoto;
    
    self.currentCamera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

    self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:self.currentCamera error:nil];
    
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    AVVideoCodecJPEG, AVVideoCodecKey,
                                    nil];
    [self.stillImageOutput setOutputSettings:outputSettings];
    
    
    // Add inputs and output to the capture session
    if ([self.session canAddInput:self.videoInput]) {
        [self.session addInput:self.videoInput];
    }
    
    if ([self.session canAddOutput:self.stillImageOutput]) {
        [self.session addOutput:self.stillImageOutput];
    }
    
    self.captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    CALayer *viewLayer = [view layer];
    [viewLayer setMasksToBounds:YES];
    
    CGRect bounds = [view bounds];
    [self.captureVideoPreviewLayer setFrame:bounds];
    
    if ([self.captureVideoPreviewLayer isOrientationSupported]) {
        [self.captureVideoPreviewLayer setOrientation:AVCaptureVideoOrientationPortrait];
    }
    
    [self.captureVideoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    [viewLayer insertSublayer:self.captureVideoPreviewLayer below:[[viewLayer sublayers] objectAtIndex:0]];
    
    // Start the session. This is done asychronously since -startRunning doesn't return until the session is running.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.session startRunning];
        
        if ([[self delegate] respondsToSelector:@selector(captureManagerDidStartRunning:)])
            [[self delegate] captureManagerDidStartRunning:self];
    });
}

- (AVCaptureConnection *)connectionWithMediaType:(NSString *)mediaType fromConnections:(NSArray *)connections
{
	for ( AVCaptureConnection *connection in connections ) {
		for ( AVCaptureInputPort *port in [connection inputPorts] ) {
			if ( [[port mediaType] isEqual:mediaType] ) {
				return connection;
			}
		}
	}
	return nil;
}

- (void) captureStillImage
{
    AVCaptureConnection *stillImageConnection = [self connectionWithMediaType:AVMediaTypeVideo fromConnections:[[self stillImageOutput] connections]];
    if ([stillImageConnection isVideoOrientationSupported])
        [stillImageConnection setVideoOrientation:self.orientation];
    
    [[self stillImageOutput] captureStillImageAsynchronouslyFromConnection:stillImageConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        
        if (imageDataSampleBuffer) {
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            
            // this returns more than we need, NOTE: it must be released
            // CFDictionaryRef allAttachments = CMCopyDictionaryOfAttachments(kCFAllocatorDefault, imageDataSampleBuffer, kCMAttachmentMode_ShouldPropagate);
            // if (allAttachments) CFRelease(allAttachments);
            
            CFDictionaryRef exifAttachments = CMGetAttachment( imageDataSampleBuffer, kCGImagePropertyExifDictionary, NULL);
            NSMutableDictionary *attachments = [[NSMutableDictionary alloc] initWithDictionary:(__bridge id)exifAttachments];
            
            if ([[self delegate] respondsToSelector:@selector(captureManager:didCaptureStillImage:withMetadata:)])
                [[self delegate] captureManager:self didCaptureStillImage:imageData withMetadata:(NSDictionary *)attachments];
        }
        else if ([[self delegate] respondsToSelector:@selector(captureManager:didFailWithError:)])
            [[self delegate] captureManager:self didFailWithError:error];
    }];
}

- (id)initWithView:(UIView *)view
{
    if (self = [self init]) {
        [self setupSessionWithView:view];
        [self setupDeviceOrientationDidChange];
    }
    return self;
}

- (void)dealloc
{
    [self tearDownDeviceOrientationDidChange];
}

@end
