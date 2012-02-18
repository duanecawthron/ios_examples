//
//  File_ManagerTests.m
//  File_ManagerTests
//
//  Created by Duane Cawthron on 2/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "File_ManagerTests.h"

@implementation File_ManagerTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}



// using NSURL is the new way to access files

- (void)example1
{
    NSFileManager *defaultFileManager = [NSFileManager defaultManager];
    
    NSSearchPathDirectory directory = NSDocumentDirectory;
    
    /*
     NSUserDomainMask
     NSUserDomainMask = 1,
     NSLocalDomainMask = 2,
     NSNetworkDomainMask = 4,
     NSSystemDomainMask = 8,
     */
    
    NSSearchPathDomainMask domainMask = NSUserDomainMask;
    
    NSArray *list = [defaultFileManager URLsForDirectory:(NSSearchPathDirectory)directory inDomains:(NSSearchPathDomainMask)domainMask];
    NSLog(@"\n list %@", list);
}

// using strings is the old way to access files

- (void)example2
{
    NSFileManager *defaultFileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *list = [defaultFileManager subpathsOfDirectoryAtPath:[NSString stringWithFormat:@"/"] error:&error];
    NSLog(@"\n list %@", list);
    
}

- (void)example3
{    
    // WARNING: This is recursive and it will find all files.
    
    // Running on the simulator, it will show the contents of the Macintosh disk.
    // NSString *docsDir = [NSString stringWithFormat:@"/Users"];
    
    //NSString *docsDir = [NSHomeDirectory() stringByAppendingPathComponent:  @"Documents"];
    NSString *docsDir = NSHomeDirectory();
    
    NSLog(@"\n\n\n docsDir %@\n", docsDir);
    
    NSFileManager *defaultFileManager = [NSFileManager defaultManager];
    
    NSDirectoryEnumerator *dirEnum = [defaultFileManager enumeratorAtPath:docsDir];
    
    NSString *file;
    while (file = [dirEnum nextObject]) {
        NSLog(@"%@\n", file);
    }
}

- (void)testExample
{
    [self example3];
}

@end
