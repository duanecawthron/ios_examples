//
//  SQLiteTests.m
//  SQLiteTests
//
//  Created by Duane Cawthron on 2/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SQLiteTests.h"

@implementation SQLiteTests

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
    /* When I tried to run sqlite3 from this file, I got these errors.
    Undefined symbols for architecture i386:
        "_sqlite3_open", referenced from:
        -[SQLiteTests example1] in SQLiteTests.o
        "_sqlite3_exec", referenced from:
        -[SQLiteTests example1] in SQLiteTests.o
        "_sqlite3_close", referenced from:
        -[SQLiteTests example1] in SQLiteTests.o
    */
}

@end
