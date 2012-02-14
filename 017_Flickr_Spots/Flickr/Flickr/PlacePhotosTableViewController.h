//
//  PlacePhotosTableViewController.h
//  Flickr
//
//  Created by Duane Cawthron on 2/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlacePhotosTableViewController : UITableViewController
@property (nonatomic, strong) NSDictionary *place;
@property (nonatomic, strong) NSArray *photos;
@end
