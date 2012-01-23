//
//  GraphViewController.m
//  Calculator
//
//  Created by Duane Cawthron on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GraphViewController.h"
//#import "GraphView.h"

@interface GraphViewController() <GraphViewDataSource>
@end

@implementation GraphViewController

@synthesize brain = _brain;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (double)yValueForGraphView:(GraphView *)sender forXValue:(double)xValue
{
    NSDictionary *variableValues = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:xValue], @"x", nil];
    double result = [[self.brain class] runProgram:self.brain.program usingVariableValues:variableValues];
    return result;
}

- (NSString *)descriptionOfGraph:(GraphView *)sender
{
    return [[self.brain class] descriptionOfProgram:self.brain.program];
}

@end
