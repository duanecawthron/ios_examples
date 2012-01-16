//
//  CalculatorViewController.m
//  Calculator
//
//  Created by cawthron on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"
#import "GraphView.h"

@interface CalculatorViewController() <GraphViewDataSource>
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize formula = _formula;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

- (CalculatorBrain *) brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    
    // NSLog(@"digit pressed = %@", digit);

    if (self.userIsInTheMiddleOfEnteringANumber) {
        NSRange range = [self.display.text rangeOfString:@"."];
        if ([digit isEqualToString:@"."] && range.location != NSNotFound) {
            // don't add another period
        } else {
            self.display.text = [self.display.text stringByAppendingString:digit];
        }
    } else if ([digit isEqualToString:@"0"]) {
        self.display.text = digit;
    } else if ([digit isEqualToString:@"."]) {
        self.display.text = @"0";
        self.display.text = [self.display.text stringByAppendingString:digit];
        self.userIsInTheMiddleOfEnteringANumber = YES;
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.formula.text = [self.formula.text stringByAppendingFormat:@"%@ ", self.display.text];

}

- (IBAction)operationPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) [self enterPressed];
    double result = [self.brain performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
    
    if ([sender.currentTitle isEqualToString:@"C"]) {
        self.formula.text = @"";
    } else {
        self.formula.text = [self.formula.text stringByAppendingFormat:@"%@ ", sender.currentTitle];
    }
}

- (IBAction)variablePressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) [self enterPressed];
    self.display.text = sender.currentTitle;
    [self.brain pushVariable:self.display.text];
    self.formula.text = [self.formula.text stringByAppendingFormat:@"%@ ", self.display.text];
}

- (IBAction)testPressed:(UIButton *)sender {
    NSArray *keys = [NSArray arrayWithObjects:@"x", @"y", @"z", nil];
    NSArray *values = nil;
    if ([sender.currentTitle isEqualToString:@"Test 1"]) {
        values = [NSArray arrayWithObjects:[NSNumber numberWithDouble:1.0], [NSNumber numberWithDouble:2.0], [NSNumber numberWithDouble:3.0], nil];
    } else if ([sender.currentTitle isEqualToString:@"Test 2"]) {
        values = [NSArray arrayWithObjects:[NSNumber numberWithDouble:4.0], [NSNumber numberWithDouble:5.0], [NSNumber numberWithDouble:6.0], nil];
    } else if ([sender.currentTitle isEqualToString:@"Test 3"]) {
        values = [NSArray arrayWithObjects:[NSNumber numberWithDouble:7.0], [NSNumber numberWithDouble:8.0], [NSNumber numberWithDouble:9.0], nil];
    }
    NSDictionary *variableValues = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    double result = [[self.brain class] runProgram:self.brain.program usingVariableValues:variableValues];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
}

- (double)yValueForGraphView:(GraphView *)sender usingXValue:(double)xValue
{
    return 40;
}

- (IBAction)enterPI {
    if (self.userIsInTheMiddleOfEnteringANumber) [self enterPressed];
    self.display.text = [NSString stringWithFormat:@"%g", M_PI];
    [self enterPressed];
}

- (void)viewDidUnload {
    [self setFormula:nil];
    [super viewDidUnload];
}
@end
