//
//  Singleton.m
//  Singleton
//
//  Created by Duane Cawthron on 2/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

+ (Singleton *)singleton
{
    static Singleton *theOneAndOnly = NULL;
    
    @synchronized(self)
    {
        if (!theOneAndOnly) {
            theOneAndOnly = [[Singleton alloc] init];
        }
    }
    return theOneAndOnly;
}

@end

/*
From http://stackoverflow.com/questions/145154/what-does-your-objective-c-singleton-look-like

@synchronized is there to handle the possible race-condition of two threads executing this
static function at the same time, both getting past the "if(!theOneAndOnly)" test at the
same time, and thus resulting in two [MySingleton alloc]s... The @synchronized {scope block}
forces that hypothetical second thread to wait for the first thread to exit the {scope block}
before being allowed to proceed into it.
*/
