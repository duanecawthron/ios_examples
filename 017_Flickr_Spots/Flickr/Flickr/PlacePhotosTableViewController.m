//
//  PlacePhotosTableViewController.m
//  Flickr
//
//  Created by Duane Cawthron on 2/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PlacePhotosTableViewController.h"
#import "FlickrFetcher.h"
#import "PhotoViewController.h"

@implementation PlacePhotosTableViewController

@synthesize place = _place;
@synthesize photos = _photos;

- (IBAction)refresh:(id)sender
{
    if (sender) {
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [spinner startAnimating];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    }
    
    dispatch_queue_t downloadQueue = dispatch_queue_create("flickr place photos", NULL);
    dispatch_async(downloadQueue, ^{
        NSArray *photos = [FlickrFetcher photosInPlace:self.place maxResults:50];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (sender) self.navigationItem.rightBarButtonItem = sender;
            self.photos = photos;
            //NSLog(@"\n photos %@", photos);
        });
    });
    dispatch_release(downloadQueue);
}

- (void)setPhotos:(NSArray *)photos
{
    if (_photos != photos) {
        _photos = photos;
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
    NSDictionary *photo= [self.photos objectAtIndex:indexPath.row];
    if ([segue.destinationViewController respondsToSelector:@selector(setPhoto:)]) {
        [segue.destinationViewController performSelector:@selector(setPhoto:) withObject:photo];
        [segue.destinationViewController setTitle:[photo valueForKey:FLICKR_PHOTO_TITLE]];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.photos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Place Photo Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSDictionary *photo= [self.photos objectAtIndex:indexPath.row];
    cell.textLabel.text = [photo valueForKey:FLICKR_PHOTO_TITLE];
    cell.detailTextLabel.text = [photo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UINavigationController *navigationController = [self.splitViewController.viewControllers lastObject];
    PhotoViewController *photoViewController = [[navigationController viewControllers] objectAtIndex:0];
    
    if ([photoViewController respondsToSelector:@selector(setPhoto:)]) {
        NSDictionary *photo= [self.photos objectAtIndex:indexPath.row];
        [photoViewController performSelector:@selector(setPhoto:) withObject:photo];
        [photoViewController setTitle:[photo valueForKey:FLICKR_PHOTO_TITLE]];
    }
}

@end
