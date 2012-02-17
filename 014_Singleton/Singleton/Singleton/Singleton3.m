//
//  Singleton3.m
//  Singleton
//
//  Created by Duane Cawthron on 2/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Singleton3.h"

@implementation Singleton3


+ (Singleton3 *)singleton3
{
    static dispatch_once_t pred;
    static Singleton3 *theOneAndOnly = nil;
    
    dispatch_once(&pred, ^{
        theOneAndOnly = [[Singleton3 alloc] init];
    });
    return theOneAndOnly;
}

@end


/*
 From http://cocoasamurai.blogspot.com/2011/04/singletons-your-doing-them-wrong.html
 
 dispatch_once() solves the problem of safely being able to create a singleton in that
 (1) it guarantees that the code in the block will only be called once for the lifetime of the application
 (2) its thread safe as I noted in a previous article and
 (3) its faster than other methods like using @synchronize(),etc...
 
 "If called simultaneously from multiple threads, this function waits synchronously until the block has completed."
 lementation will be called if the subclass is first used.
*/
