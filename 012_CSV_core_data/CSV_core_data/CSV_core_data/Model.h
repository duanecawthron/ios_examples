//
//  Model.h
//  CSV_core_data
//
//  Created by Duane Cawthron on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

// populationDatabase will be nil while the singleton is opening the database
@property (nonatomic, strong) UIManagedDocument *populationDatabase;

+ (Model *)model; // return the singleton instance of model

@end
