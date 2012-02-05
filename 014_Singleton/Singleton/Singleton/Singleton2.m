//
//  Singleton2.m
//  Singleton
//
//  Created by Duane Cawthron on 2/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Singleton2.h"

@implementation Singleton2

static Singleton2 *theOneAndOnly = NULL;

+ (void)initialize
{
    if (!theOneAndOnly) {
        theOneAndOnly = [[Singleton2 alloc] init];
    }
}

+ (Singleton2 *)singleton2
{
    return theOneAndOnly;
}

@end


/*
From http://stackoverflow.com/questions/145154/what-does-your-objective-c-singleton-look-like

The runtime sends initialize to each class in a program exactly one time just before the class,
or any class that inherits from it, is sent its first message from within the program. (Thus the 
method may never be invoked if the class is not used.) The runtime sends the initialize
message to classes in a thread-safe manner. Superclasses receive this message before their subclasses.
 
"if (!theOneAndOnly)" is a precaution since the function can also be called directly. 

This also is required because there could be subclasses. If they don’t override +initialize their
superclasses implementation will be called if the subclass is first used.
*/
