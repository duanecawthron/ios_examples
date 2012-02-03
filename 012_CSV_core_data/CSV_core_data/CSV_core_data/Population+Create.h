//
//  Population+Create.h
//  CSV_core_data
//
//  Created by Duane Cawthron on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Population.h"

@interface Population (Create)

+ (Population *) populationWithcsvRow:(NSArray *)csvRow
               inManagedObjectContext:(NSManagedObjectContext *)context;
@end
