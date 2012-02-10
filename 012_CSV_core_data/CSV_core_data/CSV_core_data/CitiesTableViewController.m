//
//  CitiesTableViewController.m
//  CSV_core_data
//
//  Created by Duane Cawthron on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CitiesTableViewController.h"
#import "NSString+ParsingExtension.h"
#import "Population+Create.h"

@implementation CitiesTableViewController

@synthesize populationDatabase = _populationDatabase;

- (void)setupFetchedResultsController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Population"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"population" ascending:NO]];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.populationDatabase.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
}

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

- (void)useDocument
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // remove the file so that it reads the CSV file every time
    NSError *error;
    [fileManager removeItemAtURL:self.populationDatabase.fileURL error:&error];
    
    if (![fileManager fileExistsAtPath:[self.populationDatabase.fileURL path]]) {
        [self.populationDatabase saveToURL:self.populationDatabase.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            [self setupFetchedResultsController];
            [self fetchCSVDataIntoDocument:self.populationDatabase];
        }];
    } else if (self.populationDatabase.documentState == UIDocumentStateClosed) {
        [self.populationDatabase openWithCompletionHandler:^(BOOL success) {
            [self setupFetchedResultsController];
        }];
    } else if (self.populationDatabase.documentState == UIDocumentStateNormal) {
        [self setupFetchedResultsController];
    }
}

- (void) setPopulationDatabase:(UIManagedDocument *)populationDatabase
{
    if (_populationDatabase != populationDatabase) {
        _populationDatabase = populationDatabase;
        [self useDocument];
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // create database
    if (!self.populationDatabase) {
        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        url = [url URLByAppendingPathComponent:@"Default Population Database"];
        self.populationDatabase = [[UIManagedDocument alloc] initWithFileURL:url];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"City Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Population *population = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = population.city;
    cell.detailTextLabel.text = [population.population stringValue];

    return cell;
}

@end
