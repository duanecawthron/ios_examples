//
//  CalculatorBrain.m
//  Calculator
//
//  Created by cawthron on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

- (NSMutableArray *)operandStack
{
    // lazy instantiation
    if (_operandStack == nil) _operandStack = [[ NSMutableArray alloc] init];

    return _operandStack;
}

- (void)setOperandStack:(NSMutableArray *)operandStack
{
    _operandStack = operandStack;
}

- (void) pushOperand:(double)operand
{
    // NSNumber *operandObject = [NSNumber numberWithDouble:operand];
    // [self.operandStack addObject:operandObject];
    // or
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
}

- (double) popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}

- (double) performOperation:(NSString *)operation
{
    double result = 0;
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    } else if ([@"*" isEqualToString:operation]) {
        result = [self popOperand] * [self popOperand];
    } else if ([operation isEqualToString:@"-"]) {
        double temp = [self popOperand];
        result = [self popOperand] - temp;
    } else if ([@"/" isEqualToString:operation]) {
        double temp = [self popOperand];
        result = [self popOperand] / temp;
    }
    [self pushOperand:result];
    return result;
}

@end
