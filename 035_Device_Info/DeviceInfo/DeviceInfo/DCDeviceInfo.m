//
//  DCDeviceInfo.m
//  DeviceInfo
//
//  Created by Duane Cawthron on 6/13/12.
//  Copyright (c) 2012 Cawthron Consulting Services, Inc. All rights reserved.
//

#import "DCDeviceInfo.h"

@implementation DCDeviceInfo

#if 0
// http://stackoverflow.com/questions/8426518/how-to-find-iphone-ipod-device-model3g-3gs-4-4s-by-code
// https://developer.apple.com/library/ios/#documentation/System/Conceptual/ManPages_iPhoneOS/man3/uname.3.html

#include <sys/utsname.h>

NSString* machineName()
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    /*
     struct utsname systemInfo;
     uname(&systemInfo);
     --
     sysname       Name of the operating system implementation.
     nodename      Network name of this machine.
     release       Release level of the operating system.
     version       Version level of the operating system.
     machine       Machine hardware platform.
     --
     NSLog(@"sysname %@", [NSString stringWithCString:systemInfo.sysname encoding:NSUTF8StringEncoding]);
     NSLog(@"nodename %@", [NSString stringWithCString:systemInfo.nodename encoding:NSUTF8StringEncoding]);
     NSLog(@"release %@", [NSString stringWithCString:systemInfo.release encoding:NSUTF8StringEncoding]);
     NSLog(@"version %@", [NSString stringWithCString:systemInfo.version encoding:NSUTF8StringEncoding]);
     NSLog(@"machine %@", [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding]);
     --
     sysname Darwin
     nodename Johns-iPhone
     release 11.0.0
     version Darwin Kernel Version 11.0.0: Sun Apr  8 21:51:47 PDT 2012; root:xnu-1878.11.10~1/RELEASE_ARM_S5L8940X
     machine iPhone4,1
     */
}

+ (NSString *)platform
{
    return machineName();
}

#else
// http://stackoverflow.com/questions/448162/determine-device-iphone-ipod-touch-with-iphone-sdk
// http://developer.apple.com/iphone/library/documentation/System/Conceptual/ManPages_iPhoneOS/man3/sysctlbyname.3.html
// https://gist.github.com/1323251

#include <sys/types.h>
#include <sys/sysctl.h>
+ (NSString *)platform{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}

#endif

+ (NSString *)deviceName{
    NSString *platform = [self platform];
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"Verizon iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad-3G (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad-3G (4G)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad-3G (4G)";
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    return platform;
}

// returns iPhone OS
+ (NSString *)systemName
{
    return [[UIDevice currentDevice] systemName];
}

// returns 5.1.1
+ (NSString *)systemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)appName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
}

+ (NSString *)appVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey];
}

@end
