//
//  ViewController.m
//  NSDataConverter
//
//  Created by Duane Cawthron on 4/23/12.
//  Copyright (c) 2012 Cawthron Consulting Services, Inc. All rights reserved.
//

#import "ViewController.h"
#import "ISS_LowRes.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)convertStructVertexDataTexturedToNSData
{
    // Convert a struct vertexDataTextured to an NSData object
    // Write the data to a file: ISS_LowRes_MeshVertexData.data
    // Read the file and compare to make sure it worked
    
    NSData *ISSData = [NSData dataWithBytes:(void *)ISS_LowRes_MeshVertexData
                                     length:sizeof(ISS_LowRes_MeshVertexData)];
    
    NSURL *userDocumentDirectory = [[[NSFileManager defaultManager] URLsForDirectory: NSDocumentDirectory inDomains: NSUserDomainMask] lastObject];
    NSString *filePath = @"ISS_LowRes_MeshVertexData.data";
    NSURL *fileURL = [userDocumentDirectory URLByAppendingPathComponent: filePath];
    
    [ISSData writeToURL:fileURL atomically:NO];
    
    NSData *ISSData2 = [NSData dataWithContentsOfURL:fileURL];
    
    NSAssert(ISSData2.length == sizeof(ISS_LowRes_MeshVertexData), @"NSData length should match size of struct");
    NSAssert([ISSData2 isEqual:ISSData], @"NSData read from file should be equal to original NSData");
    
    /*
     Look for ISS_LowRes_MeshVertexData.data in the iPhone Simulator folder
     /Users/cawthron/Library/"Application Support/iPhone Simulator"/5.1/Applications/APP_UUID/Documents/ISS_LowRes_MeshVertexData.data
     where APP_UUID is soemthing like A0BE6722-0C63-4A4C-A989-D937FBC634F1
     */
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self convertStructVertexDataTexturedToNSData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
