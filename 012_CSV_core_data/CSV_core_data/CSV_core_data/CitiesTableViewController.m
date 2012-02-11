//
//  CitiesTableViewController.m
//  CSV_core_data
//
//  Created by Duane Cawthron on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CitiesTableViewController.h"
#import "Model.h"
#import "Population.h"

@implementation CitiesTableViewController

- (void)setupFetchedResultsController
{
    Model *model = [Model model];
    UIManagedDocument *populationDatabase = [model populationDatabase];
    if (populationDatabase) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Population"];
        request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"population" ascending:NO]];
        
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:populationDatabase.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"populationDatabase"]) {
        [self setupFetchedResultsController];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    Model *model = [Model model];
    [model addObserver:self forKeyPath:@"populationDatabase" options:0 context:0];
    [self setupFetchedResultsController];
}

- (void)viewDidDisappear:(BOOL)animated
{
    Model *model = [Model model];
    [model removeObserver:self forKeyPath:@"populationDatabase"];
    
    [super viewDidDisappear:animated];
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
