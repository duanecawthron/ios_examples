//
//  Observer.m
//  Key_Value_Observing
//
//  Created by Duane Cawthron on 2/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Observer.h"

@implementation Observer

@synthesize three = _three;

@synthesize one_copy = _one_copy;
@synthesize two_copy = _two_copy;
@synthesize three_copy = _three_copy;

 - (void)setup
{
    Model *model = [Model model];
    [model addObserver:self forKeyPath:@"one" options:0 context:0];
    [model addObserver:self forKeyPath:@"two" options:0 context:0];
    [self addObserver:self forKeyPath:@"three" options:0 context:0];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"\n observe %@= %@", keyPath, [object valueForKey:keyPath]);
    
    // copy the observed property to my local copy
    NSString *local_name = [keyPath stringByAppendingString:@"_copy"];
    [self setValue:[object valueForKey:keyPath] forKey:local_name];
}

- (id)init
{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)dealloc
{
    Model *model = [Model model];
    [model removeObserver:self forKeyPath:@"one"];
    [model removeObserver:self forKeyPath:@"two"];
    [self removeObserver:self forKeyPath:@"three"];
}

@end
