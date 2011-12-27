//
//  CalculatorViewController.m
//  Calculator
//
//  Created by cawthron on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    
    // NSLog(@"digit pressed = %@", digit);

    if (self.userIsInTheMiddleOfEnteringANumber) {
        // UILabel *myDisplay = self.display; // or [self display];
        // NSString *currentText = myDisplay.text; // or [myDisplay text];
        // NSString *newText = [currentText stringByAppendingString:digit];
        // myDisplay.text = newText; // or [myDisplay setText:newText];
        // or
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}

- (IBAction)operationPressed:(UIButton *)sender {
}

- (IBAction)enterPressed {
}

@end
