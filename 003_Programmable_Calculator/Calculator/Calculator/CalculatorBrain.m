//
//  CalculatorBrain.m
//  Calculator
//
//  Created by cawthron on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *programStack;
@end

@implementation CalculatorBrain

@synthesize programStack = _programStack;

- (NSMutableArray *)programStack
{
    // lazy instantiation
    if (_programStack == nil) _programStack = [[NSMutableArray alloc] init];
    return _programStack;
}

- (void)setProgramStack:(NSMutableArray *)programStack
{
    _programStack = programStack;
}

- (id)program
{
    return [self.programStack copy];
}

+ (NSString *)descriptionOfProgram:(id)program
{
    return @"Implement this in assignment 2";
}

- (void)pushOperand:(double)operand
{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}

- (void)pushVariable:(NSString *)variable
{
    [self.programStack addObject:variable];
}

- (double)performOperation:(NSString *)operation
{
    [self.programStack addObject:operation];
    return [[self class] runProgram:self.program];
}

+ (double)popOperandOffProgramStack:(NSMutableArray *)stack
{
    double result = 0;

    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeLastObject];

    if ([topOfStack isKindOfClass:[NSNumber class]]) {
        result = [topOfStack doubleValue];
    }
    else if ([topOfStack isKindOfClass:[NSString class]]) {
        NSString *operation = topOfStack;

        // Binary operations
        if ([operation isEqualToString:@"+"]) {
            result = [self popOperandOffProgramStack:stack] + [self popOperandOffProgramStack:stack];
        } else if ([@"*" isEqualToString:operation]) {
            result = [self popOperandOffProgramStack:stack] * [self popOperandOffProgramStack:stack];
        } else if ([operation isEqualToString:@"-"]) {
            double temp = [self popOperandOffProgramStack:stack];
            result = [self popOperandOffProgramStack:stack] - temp;
        } else if ([operation isEqualToString:@"/"]) {
            double temp = [self popOperandOffProgramStack:stack];
            result = [self popOperandOffProgramStack:stack] / temp;

        // Unary operations
        } else if ([operation isEqualToString:@"sin"]) {
            result = sin([self popOperandOffProgramStack:stack]);
        } else if ([operation isEqualToString:@"cos"]) {
            result = cos([self popOperandOffProgramStack:stack]);
        } else if ([operation isEqualToString:@"sqrt"]) {
            result = sqrt([self popOperandOffProgramStack:stack]);

        // Clear program
        } else if ([operation isEqualToString:@"C"]) {
            [stack removeAllObjects];
            // should also clear _programStack
            result = 0;
        }

        // Variables return 0
    }

    return result;
}

+ (double)runProgram:(id)program
{    
    return [self runProgram:program usingVariableValues:nil];
}

+ (double)runProgram:(id)program usingVariableValues:(NSDictionary *)variableValues
{
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
        if (variableValues != nil) {
            // replace variables with their values
            for (NSUInteger i = 0; i < [stack count]; ++i) {
                id key = [stack objectAtIndex:i];
                if ([key isKindOfClass:[NSString class]]) {
                    id value = [variableValues valueForKey:key];
                    if ([value isKindOfClass:[NSNumber class]]) {
                        [stack replaceObjectAtIndex:i withObject:value];
                        //NSLog(@"count = %d, key = %@, value = %g", i, key, [value doubleValue]);
                    }
                }
            }

        }
    }
    
    return [self popOperandOffProgramStack:stack];
}

+ (NSSet *)variablesUsedInProgram:(id)program
{
    
}

@end
