//
//  Key_Value_ObservingTests.m
//  Key_Value_ObservingTests
//
//  Created by Duane Cawthron on 2/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Key_Value_ObservingTests.h"
#import "Model.h"
#import "Observer.h"


@implementation Key_Value_ObservingTests

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
    model.two = @"b";
    observer.three = @"c";
    STAssertEqualObjects(model.one, observer.one_copy, @"one and one_copy should be the same");
    STAssertEqualObjects(model.two, observer.two_copy, @"one and one_copy should be the same");
    STAssertEqualObjects(observer.three, observer.three_copy, @"one and one_copy should be the same");
}

@end
