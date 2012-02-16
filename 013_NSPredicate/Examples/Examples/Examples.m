//
//  Examples.m
//  Emp
//
//  Created by Duane Cawthron on 2/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Examples.h"

@implementation Examples


+ (void)example1
{
    NSArray *data = [NSArray arrayWithObject:[NSMutableDictionary dictionaryWithObject:@"foo" forKey:@"BAR"]];    
    NSArray *filtered = [data filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(BAR == %@)", @"foo"]];
    NSLog(@"%@", filtered);
}

+ (void)example2
{
    NSArray *keys = [NSArray arrayWithObjects:@"key1", @"key2", @"key3", nil];
    NSArray *objects = [NSArray arrayWithObjects:@"How", @"are", @"you", nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    for (id key in dictionary) {
        NSLog(@"key: %@, value: %@", key, [dictionary objectForKey:key]);
    }
}

+ (void)example3
{
    NSString *address = @"210 North Elm";
    NSNumber *len = [address valueForKeyPath:@"length"];
    //NSNumber *len = [house valueForKeyPath:@"address.length"];
    NSLog(@"The address has %d characters in it", [len intValue]);
}

+ (void)example4
{
    NSSet *set1 = [NSSet setWithObjects:@"a", @"b", @"c", nil];
    NSLog(@"set1= %@", set1);
    
    NSSet *set2 = [NSSet setWithObjects:@"1", @"2", @"3", nil];
    NSLog(@"set2= %@", set2);
    
    NSSet *set3 = [set1 setByAddingObjectsFromSet:set2];
    NSLog(@"set1 + set2= %@", set3);       
}

+ (void)example5
{
    // This does not work.

    NSSet *set = [NSSet setWithObjects:@"b", @"a", @"c", nil];
    
    NSSortDescriptor * descriptor =
    [[NSSortDescriptor alloc] initWithKey:@"String"
                                ascending:YES];
    
    NSArray *array = [set sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptor]];
    NSLog(@"%@", array);
}

+ (void)example6
{
    NSArray *array = [NSArray arrayWithObjects:@"b", @"a", @"c", nil];
    NSLog(@"%@", array);
    
    NSArray *sorta = [array sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    NSLog(@"sorted= %@", sorta);
}

+ (void)example7
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"val1", @"key1", @"val2", @"key2", nil];
    NSLog(@"%@", dictionary);
}

+ (void)example8
{
    NSArray *keys = [NSArray arrayWithObjects:@"key1", @"key2", @"key3", nil];
    NSArray *values = [NSArray arrayWithObjects:@"val1", @"val2", @"val3", nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    NSLog(@"%@", dictionary);
}

+ (void)example9
{
    NSString * NAME      = @"name";
    NSString * ADDRESS   = @"address";
    NSString * FREQUENCY = @"frequency";
    NSString * TYPE      = @"type";
    
    NSMutableArray * array = [NSMutableArray array];
    
    NSDictionary * dict;
    
    dict = [NSDictionary dictionaryWithObjectsAndKeys:
            @"Alehandro", NAME, @"Sydney", ADDRESS,
            [NSNumber numberWithInt:100], FREQUENCY,
            @"T", TYPE, nil];
    [array addObject:dict];
    
    dict = [NSDictionary dictionaryWithObjectsAndKeys:
            @"Xentro", NAME, @"Melbourne", ADDRESS,
            [NSNumber numberWithInt:50], FREQUENCY,
            @"X", TYPE, nil];
    [array addObject:dict];
    
    dict = [NSDictionary dictionaryWithObjectsAndKeys:
            @"John", NAME, @"Perth", ADDRESS,
            [NSNumber numberWithInt:75],
            FREQUENCY, @"A", TYPE, nil];
    [array addObject:dict];
    
    dict = [NSDictionary dictionaryWithObjectsAndKeys:
            @"Fjord", NAME, @"Brisbane", ADDRESS,
            [NSNumber numberWithInt:20], FREQUENCY,
            @"B", TYPE, nil];
    [array addObject:dict];
    
    NSSortDescriptor * frequencyDescriptor =
    [[NSSortDescriptor alloc] initWithKey:FREQUENCY
                                ascending:YES];
    
    for (id obj in array) NSLog(@"%@", obj);
    
    NSArray * descriptors =
    [NSArray arrayWithObjects:frequencyDescriptor, nil];
    NSArray * sortedArray =
    [array sortedArrayUsingDescriptors:descriptors];
    
    NSLog(@"\nSorted ...");
    for (id obj in sortedArray) NSLog(@"%@", obj);
    
    NSLog(@"\nSearch for Xentro ...");
    NSArray *filtered = [array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(name == %@)", @"Xentro"]];
    NSLog(@"filtered= %@", filtered);

    // WARNING look at this. It uses %K instead of the usual %@ in @"(%K == %@)". I think %@ adds single quotes.
    NSLog(@"\nSearch 2 for Xentro ...");
    filtered = [array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(%K == %@)", NAME, @"Xentro"]];
    NSLog(@"filtered= %@", filtered);

    NSLog(@"\nSearch 3 for Xentro ...");
    NSString *format = [NSString stringWithFormat:@"(%@ == %%@)", NAME];
    NSLog(@"format= %@", format);
    filtered = [array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:format, @"Xentro"]];
    NSLog(@"filtered= %@", filtered);
    
    NSLog(@"\nSearch 4 for Xentro ...");
    filtered = [array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(%K == %@)"
                                                                     argumentArray:[NSArray arrayWithObjects:NAME, @"Xentro", nil]]];
    NSLog(@"filtered= %@", filtered);

    NSLog(@"sum of frequency= %@", [array valueForKeyPath:@"@sum.frequency"]);
}

+ (void)example10
{
    NSArray *array = [NSArray arrayWithObjects:@"Stig", @"Shaffiq", @"Chris", nil];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF IN %@", array];
    NSLog(@"should be YES= %@", [predicate evaluateWithObject:@"Shaffiq"] ? @"YES" : @"NO");
}

// From http://stackoverflow.com/questions/1844031/how-to-sort-nsmutablearray-using-sortedarrayusingdescriptors
+ (void)example11
{
    NSArray *population = 
    [NSArray arrayWithObjects:
     [NSDictionary dictionaryWithObjectsAndKeys:
      @"New York",@"City",
      @"New York",@"State",
      [NSNumber numberWithInt:8175133],@"Population",nil],
     [NSDictionary dictionaryWithObjectsAndKeys:
      @"Los Angeles",@"City",
      @"California",@"State",
      [NSNumber numberWithInt:3792621],@"Population",nil],
     [NSDictionary dictionaryWithObjectsAndKeys:
      @"Chicago",@"City",
      @"Illinois",@"State",
      [NSNumber numberWithInt:2695598],@"Population",nil],
     [NSDictionary dictionaryWithObjectsAndKeys:
      @"Houston",@"City",
      @"Texas",@"State",
      [NSNumber numberWithInt:2099451],@"Population",nil],
     [NSDictionary dictionaryWithObjectsAndKeys:
      @"Philadelphia",@"City",
      @"Pennsylvania",@"State",
      [NSNumber numberWithInt:1526006],@"Population",nil],
     [NSDictionary dictionaryWithObjectsAndKeys:
      @"Phoenix",@"City",
      @"Arizona",@"State",
      [NSNumber numberWithInt:1445632],@"Population",nil],
     [NSDictionary dictionaryWithObjectsAndKeys:
      @"San Antonio",@"City",
      @"Texas",@"State",
      [NSNumber numberWithInt:1327407],@"Population",nil],
     [NSDictionary dictionaryWithObjectsAndKeys:
      @"San Diego",@"City",
      @"California",@"State",
      [NSNumber numberWithInt:1307402],@"Population",nil],
     [NSDictionary dictionaryWithObjectsAndKeys:
      @"Dallas",@"City",
      @"Texas",@"State",
      [NSNumber numberWithInt:1197816],@"Population",nil],
     [NSDictionary dictionaryWithObjectsAndKeys:
      @"San Jose",@"City",
      @"California",@"State",
      [NSNumber numberWithInt:945942],@"Population",nil],
     nil];
    
    NSLog(@"\nRaw Data");
    for (id obj in population)
        NSLog(@"%@, %@ %ld",
              [obj valueForKeyPath:@"City"],
              [obj valueForKeyPath:@"State"],
              [(NSNumber *)[obj valueForKeyPath:@"Population"] longValue]);

    NSArray *states = [population valueForKeyPath:@"@distinctUnionOfObjects.State"];
    
    NSLog(@"\nStates");
    for (id obj in states)
        NSLog(@"%@", obj);

    NSSortDescriptor *sortStateDescriptor = [[NSSortDescriptor alloc] initWithKey:@"State" ascending:YES];
    NSSortDescriptor *sortCityDescriptor = [[NSSortDescriptor alloc] initWithKey:@"City" ascending:YES];
    NSSortDescriptor *sortPopulationDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Population" ascending:NO];
    
    NSArray *descriptors = [NSArray arrayWithObjects:sortStateDescriptor, sortCityDescriptor, nil];
    NSArray *sortedStatesAndCities =[population sortedArrayUsingDescriptors:descriptors];
    
    NSLog(@"\nSort by State and City");
    for (id obj in sortedStatesAndCities)
        NSLog(@"%@, %@",
              [obj valueForKeyPath:@"State"],
              [obj valueForKeyPath:@"City"]);
    
    NSLog(@"\nSort by Population and show total State Population");
    descriptors = [NSArray arrayWithObjects:sortPopulationDescriptor, nil];
    for (id state in states) {
        NSArray *filtered = [population filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(State == %@)", state]];
        NSArray *sorted =[filtered sortedArrayUsingDescriptors:descriptors];
        
        //NSLog(@"%@", filtered);
        //NSLog(@"%@", sorted);
        
        for (id obj in sorted)
            NSLog(@"%@, %@ %ld",
                  [obj valueForKeyPath:@"City"],
                  [obj valueForKeyPath:@"State"],
                  [(NSNumber *)[obj valueForKeyPath:@"Population"] longValue]);
        
        NSLog(@"TOTAL %@ %ld", state, [(NSNumber *)[sorted valueForKeyPath:@"@sum.Population"] longValue]);
    }
}

+ (void)example12
{
    NSSet *sourceSet = [NSSet setWithObjects:@"One", @"Two", @"Three", @"Four", nil];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith 'T'"];
    NSSet *filteredSet = [sourceSet filteredSetUsingPredicate:predicate];
    // filteredSet contains (Two, Three)
    NSLog(@"%@", filteredSet);
}

+ (void)example13
{
    NSSet *population = 
    [NSSet setWithObjects:
     [NSDictionary dictionaryWithObjectsAndKeys:
      @"New York",@"City",
      @"New York",@"State",
      [NSNumber numberWithInt:8175133],@"Population",nil],
     [NSDictionary dictionaryWithObjectsAndKeys:
      @"Los Angeles",@"City",
      @"California",@"State",
      [NSNumber numberWithInt:3792621],@"Population",nil],
     [NSDictionary dictionaryWithObjectsAndKeys:
      @"Chicago",@"City",
      @"Illinois",@"State",
      [NSNumber numberWithInt:2695598],@"Population",nil],
     [NSDictionary dictionaryWithObjectsAndKeys:
      @"Houston",@"City",
      @"Texas",@"State",
      [NSNumber numberWithInt:2099451],@"Population",nil],
     [NSDictionary dictionaryWithObjectsAndKeys:
      @"Philadelphia",@"City",
      @"Pennsylvania",@"State",
      [NSNumber numberWithInt:1526006],@"Population",nil],
     [NSDictionary dictionaryWithObjectsAndKeys:
      @"Phoenix",@"City",
      @"Arizona",@"State",
      [NSNumber numberWithInt:1445632],@"Population",nil],
     [NSDictionary dictionaryWithObjectsAndKeys:
      @"San Antonio",@"City",
      @"Texas",@"State",
      [NSNumber numberWithInt:1327407],@"Population",nil],
     [NSDictionary dictionaryWithObjectsAndKeys:
      @"San Diego",@"City",
      @"California",@"State",
      [NSNumber numberWithInt:1307402],@"Population",nil],
     [NSDictionary dictionaryWithObjectsAndKeys:
      @"Dallas",@"City",
      @"Texas",@"State",
      [NSNumber numberWithInt:1197816],@"Population",nil],
     [NSDictionary dictionaryWithObjectsAndKeys:
      @"San Jose",@"City",
      @"California",@"State",
      [NSNumber numberWithInt:945942],@"Population",nil],
     nil];
    
    NSLog(@"\nRaw Data");
    for (id obj in population)
        NSLog(@"%@, %@ %ld",
              [obj valueForKeyPath:@"City"],
              [obj valueForKeyPath:@"State"],
              [(NSNumber *)[obj valueForKeyPath:@"Population"] longValue]);
    
    NSArray *states = [population valueForKeyPath:@"@distinctUnionOfObjects.State"];
    
    NSLog(@"\nStates");
    for (id obj in states)
        NSLog(@"%@", obj);
    
    NSSortDescriptor *sortStateDescriptor = [[NSSortDescriptor alloc] initWithKey:@"State" ascending:YES];
    NSSortDescriptor *sortCityDescriptor = [[NSSortDescriptor alloc] initWithKey:@"City" ascending:YES];
    NSSortDescriptor *sortPopulationDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Population" ascending:NO];
    
    NSArray *descriptors = [NSArray arrayWithObjects:sortStateDescriptor, sortCityDescriptor, nil];
    NSArray *sortedStatesAndCities =[population sortedArrayUsingDescriptors:descriptors];
    
    NSLog(@"\nSort by State and City");
    for (id obj in sortedStatesAndCities)
        NSLog(@"%@, %@",
              [obj valueForKeyPath:@"State"],
              [obj valueForKeyPath:@"City"]);
    
    NSLog(@"\nSort by Population and show total State Population");
    descriptors = [NSArray arrayWithObjects:sortPopulationDescriptor, nil];
    for (id state in states) {
        NSSet *filtered = [population filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"(State == %@)", state]];
        NSArray *sorted =[filtered sortedArrayUsingDescriptors:descriptors];
        
        //NSLog(@"%@", filtered);
        //NSLog(@"%@", sorted);
        
        for (id obj in sorted)
            NSLog(@"%@, %@ %ld",
                  [obj valueForKeyPath:@"City"],
                  [obj valueForKeyPath:@"State"],
                  [(NSNumber *)[obj valueForKeyPath:@"Population"] longValue]);
        
        NSLog(@"TOTAL %@ %ld", state, [(NSNumber *)[sorted valueForKeyPath:@"@sum.Population"] longValue]);
    }
}

+ (void)example14
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    // this is not required
    //[numberFormatter setAllowsFloats:YES];
    
    for (NSString *stringValue in [NSArray arrayWithObjects:@"one", @"3", @"4.5", nil]) {
        NSNumber *numberValue = [numberFormatter numberFromString:stringValue];
        if (numberValue) {
            NSLog(@" %@ number from string %@", numberValue, stringValue);
        } else {
            NSLog(@"%@", stringValue);
        }
    }
}

+ (void)example15
{
    NSDictionary *arnold = [NSDictionary dictionaryWithObjectsAndKeys:@"arnold", @"name", @"california", @"state", nil];
    NSDictionary *jimmy = [NSDictionary dictionaryWithObjectsAndKeys:@"jimmy", @"name", @"new york", @"state", nil];
    NSDictionary *henry = [NSDictionary dictionaryWithObjectsAndKeys:@"henry", @"name", @"michigan", @"state", nil];
    NSDictionary *woz = [NSDictionary dictionaryWithObjectsAndKeys:@"woz", @"name", @"california", @"state", nil];
    
    NSArray *people = [NSArray arrayWithObjects:arnold, jimmy, henry, woz, nil];
    
    NSLog(@"Unique States:\n %@", [people valueForKeyPath:@"@distinctUnionOfObjects.state"]);
}

+ (void) run
{
    [Examples example15];
}

@end
