//
//  RecentPhotosTableViewController.m
//  Flickr
//
//  Created by Duane Cawthron on 2/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RecentPhotosTableViewController.h"
#import "RecentPhotos.h"
#import "FlickrFetcher.h"
#import "PhotoViewController.h"

@interface  RecentPhotosTableViewController()
@property (nonatomic, strong) NSArray *photos;
@end
    
@implementation RecentPhotosTableViewController

@synthesize photos = _photos;

- (void)setPhotos:(NSArray *)photos
{
    if (_photos != photos) {
        _photos = photos;
    }
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.photos = [[RecentPhotos recentPhotos] photos];
    [self.tableView reloadData];
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
    static NSString *CellIdentifier = @"Recent Photos Cell";
    
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
