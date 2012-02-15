//
//  PlacesTableViewController.m
//  Flickr
//
//  Created by Duane Cawthron on 2/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PlacesTableViewController.h"
#import "FlickrFetcher.h"

@implementation PlacesTableViewController

@synthesize places = _places;

- (IBAction)refresh:(id)sender
{
    if (sender) {
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [spinner startAnimating];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    }
    
    dispatch_queue_t downloadQueue = dispatch_queue_create("flickr places", NULL);
    dispatch_async(downloadQueue, ^{
        NSArray *places = [FlickrFetcher topPlaces];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (sender) self.navigationItem.rightBarButtonItem = sender;
            self.places = places;
            //NSLog(@"\n places %@", places);
        });
    });
    dispatch_release(downloadQueue);
}

- (void)setPlaces:(NSArray *)places
{
    if (_places != places) {
        _places = places;
        [self.tableView reloadData];
    }
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refresh:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    NSDictionary *place= [self.places objectAtIndex:indexPath.row];
    if ([segue.destinationViewController respondsToSelector:@selector(setPlace:)]) {
        [segue.destinationViewController performSelector:@selector(setPlace:) withObject:place];
    }
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.places count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Places Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSDictionary *place= [self.places objectAtIndex:indexPath.row];
    cell.textLabel.text = [place valueForKey:FLICKR_PLACE_NAME];
    
    return cell;
}

@end
