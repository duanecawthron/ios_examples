//
//  DCDeviceInfo.h
//  DeviceInfo
//
//  Created by Duane Cawthron on 6/13/12.
//  Copyright (c) 2012 Cawthron Consulting Services, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCDeviceInfo : NSObject

+ (NSString *)deviceName;    // e.g. iPhone 4S
+ (NSString *)systemVersion; // e.g. 5.1.1

+ (NSString *)appName;
+ (NSString *)appVersion;

@end
