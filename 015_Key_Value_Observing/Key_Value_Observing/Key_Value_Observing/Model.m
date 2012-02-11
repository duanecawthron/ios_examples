//
//  Model.m
//  Key_Value_Observing
//
//  Created by Duane Cawthron on 2/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Model.h"

@implementation Model

@synthesize one = _one;
@synthesize two = _two;

+ (Model *)model
{
    static Model *theOneAndOnly = NULL;
    
    @synchronized(self)
    {
        if (!theOneAndOnly) {
            theOneAndOnly = [[Model alloc] init];
        }
    }
    return theOneAndOnly;
}

@end
