//
//  Model.m
//  NSNotification
//
//  Created by Duane Cawthron on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Model.h"

@implementation Model

@synthesize one = _one;

- (void)setOne:(NSString *)one
{
    _one = one;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ModelSetOne" object:one];
}

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
