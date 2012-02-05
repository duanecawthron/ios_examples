//
//  SingletonTests.m
//  SingletonTests
//
//  Created by Duane Cawthron on 2/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SingletonTests.h"
#import "Singleton.h"
#import "Singleton2.h"

@implementation SingletonTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    Singleton *x = [Singleton singleton];
    Singleton *y = [Singleton singleton];
    STAssertTrue((x == y), @"Expect [Singleton singleton] to always return the same pointer");
    
    Singleton2 *x2 = [Singleton2 singleton2];
    Singleton2 *y2 = [Singleton2 singleton2];
    STAssertTrue((x2 == y2), @"Expect [Singleton singleton] to always return the same pointer");
}

@end
