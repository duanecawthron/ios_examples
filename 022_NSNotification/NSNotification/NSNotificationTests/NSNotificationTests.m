//
//  NSNotificationTests.m
//  NSNotificationTests
//
//  Created by Duane Cawthron on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSNotificationTests.h"
#import "Model.h"
#import "Observer.h"

@implementation NSNotificationTests

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
    Model *model = [Model model];
    Observer *observer = [[Observer alloc] init];
    
    NSLog(@"\n\n\n");
    model.one = @"a";
    STAssertEqualObjects(model.one, observer.one_copy, @"one and one_copy should be the same");
    model.one = @"b";
    STAssertEqualObjects(model.one, observer.one_copy, @"one and one_copy should be the same");
    NSLog(@"\n Model.model.one %@", Model.model.one);
    NSLog(@"\n observer.one_copy %@", observer.one_copy);
}

@end
