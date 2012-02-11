//
//  Model.m
//  CSV_core_data
//
//  Created by Duane Cawthron on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Model.h"

@implementation Model
#import "NSString+ParsingExtension.h"
#import "Population+Create.h"

@synthesize populationDatabase = _populationDatabase;

- (void)fetchCSVDataIntoDocument:(UIManagedDocument *)document
{
    dispatch_queue_t fetchQ = dispatch_queue_create("CSV fetcher", NULL);
    dispatch_async(fetchQ, ^{
        NSError* error = nil;
        NSString *path = [[NSBundle mainBundle] pathForResource: @"population" ofType: @"csv"];
        NSString *data = [NSString stringWithContentsOfFile: path encoding:NSUTF8StringEncoding error: &error];
        //NSLog(@"%@", data);
        
        NSArray *rows = [data csvRows];
        //NSLog(@"%@", rows);
        
        [document.managedObjectContext performBlock:^{
            BOOL skipHeaderRow = YES;
            for (NSArray *row in rows) {
                if (skipHeaderRow) skipHeaderRow = NO;
                else [Population populationWithcsvRow:row inManagedObjectContext:document.managedObjectContext];
            }
        }];
    });
    dispatch_release(fetchQ);
}

- (void)setup
{
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    url = [url URLByAppendingPathComponent:@"Default Population Database"];
    UIManagedDocument *managedDocument = [[UIManagedDocument alloc] initWithFileURL:url];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // remove the file so that it reads the CSV file every time
    NSError *error;
    [fileManager removeItemAtURL:managedDocument.fileURL error:&error];
    
    
    if (![fileManager fileExistsAtPath:[managedDocument.fileURL path]]) {
        [managedDocument saveToURL:managedDocument.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            self.populationDatabase = managedDocument;
            [self fetchCSVDataIntoDocument:managedDocument];
        }];
    } else if (managedDocument.documentState == UIDocumentStateClosed) {
        [managedDocument openWithCompletionHandler:^(BOOL success) {
            self.populationDatabase = managedDocument;
        }];
    }
}

- (id)init
{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

+ (Model *)model
{
    static Model *theOneAndOnly = NULL;
    
    @synchronized(self)
    {
        if (!theOneAndOnly) {
            theOneAndOnly = [[Model alloc] init];
        }
    }
    return theOneAndOnly;
}

@end
