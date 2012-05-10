//
//  DCCaptureManager.h
//  DCCaptureManager
//
//  Created by Duane Cawthron on 5/9/12.
//  Copyright (c) 2012 Cawthron Consulting Services, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@class DCCaptureManager;

@protocol DCCaptureManagerDelegate <NSObject>
@optional
// delegate methods may not be called on the main thread
- (void)captureManagerDidStartRunning:(DCCaptureManager *)captureManager;
- (void)captureManager:(DCCaptureManager *)captureManager didFailWithError:(NSError *)error;
- (void)captureManager:(DCCaptureManager *)captureManager didCaptureStillImage:(NSData *)jpegImageData withMetadata:(NSDictionary *)EXIFdata;
@end


@interface DCCaptureManager : NSObject

@property (nonatomic, strong) AVCaptureDevice *currentCamera;
@property (nonatomic, weak) IBOutlet id <DCCaptureManagerDelegate> delegate;

- (id)initWithView:(UIView *)view;
- (void) captureStillImage;

@end


