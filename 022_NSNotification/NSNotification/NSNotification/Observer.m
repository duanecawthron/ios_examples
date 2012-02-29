//
//  Observer.m
//  Key_Value_Observing
//
//  Created by Duane Cawthron on 2/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Observer.h"
#import "Model.h"

@implementation Observer

@synthesize one_copy = _one_copy;

- (void) observeModel:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"ModelSetOne"])
        self.one_copy = Model.model.one;
}

- (void)setup
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(observeModel:) 
                                                 name:@"ModelSetOne"
                                               object:nil];
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
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
