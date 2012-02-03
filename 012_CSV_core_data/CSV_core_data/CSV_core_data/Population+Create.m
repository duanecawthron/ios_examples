//
//  Population+Create.m
//  CSV_core_data
//
//  Created by Duane Cawthron on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Population+Create.h"

@implementation Population (Create)

+ (Population *) populationWithcsvRow:(NSArray *)csvRow
                inManagedObjectContext:(NSManagedObjectContext *)context
{
    Population *population = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Population"];
    request.predicate = [NSPredicate predicateWithFormat:@"city = %@", [csvRow objectAtIndex:0]];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"city" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];

    if (!matches || ([matches count] > 1)) {
        // handle error
    } else if ([matches count] == 0) {
        population = [NSEntityDescription insertNewObjectForEntityForName:@"Population" inManagedObjectContext:context];
        
        // the next 2 lines are equivalent
        population.city = [csvRow objectAtIndex:0];
        //[population setValue:[csvRow objectAtIndex:0] forKey:@"city"];
        
        population.state = [csvRow objectAtIndex:1];
        population.population = [formatter numberFromString:[csvRow objectAtIndex:2]];
        
        
    } else {
        population = [matches lastObject];
    }
    
    return population;
}

@end
