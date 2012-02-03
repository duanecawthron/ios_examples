//
//  CitiesTableViewController.h
//  CSV_core_data
//
//  Created by Duane Cawthron on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@interface CitiesTableViewController : CoreDataTableViewController

@property (nonatomic, strong) UIManagedDocument *populationDatabase;

@end
