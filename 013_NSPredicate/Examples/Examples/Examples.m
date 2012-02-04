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
    
    

    
    NSArray *filtered = [array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(name == %@)", @"Xentro"]];
    NSLog(@"filtered= %@", filtered);
    
    // does not work
    // filtered = [array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(%@ == %@)", NAME, @"Xentro"]];
    
    NSString *format = [NSString stringWithFormat:@"(%@ == %%@)", NAME];
    NSLog(@"format= %@", format);
    filtered = [array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:format, @"Xentro"]];
    NSLog(@"filtered= %@", filtered);
    
    // does not work
    // filtered = [array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(%@ == %@)"
    //                                                                 argumentArray:[NSArray arrayWithObjects:NAME, @"Xentro", nil]]];
    

    
    
    NSLog(@"sum of frequency= %@", [array valueForKeyPath:@"@sum.frequency"]);
}

+ (void)example10
{
    NSArray *array = [NSArray arrayWithObjects:@"Stig", @"Shaffiq", @"Chris", nil];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF IN %@", array];
    NSLog(@"should be YES= %@", [predicate evaluateWithObject:@"Shaffiq"] ? @"YES" : @"NO");
}

+ (void) run
{
    [Examples example9];
}

@end
