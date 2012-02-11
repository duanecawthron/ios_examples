//
//  CitiesTableViewController.m
//  CSV_core_data
//
//  Created by Duane Cawthron on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CitiesTableViewController.h"

@implementation CitiesTableViewController

- (void)setupFetchedResultsController
{
    Model *model = [Model model];
    UIManagedDocument *populationDatabase = [model populationDatabase];
    if (populationDatabase) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Population"];
        request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"population" ascending:YES]];
        
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:populationDatabase.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    }
}

@end
