//
//  CalculatorProgramsTableViewController.h
//  Calculator
//
//  Created by Duane Cawthron on 1/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CalculatorProgramsTableViewController;

@protocol CalculatorProgramsTableViewControllerDelegate
@optional
- (void) calculatorProgramsTableViewController:(CalculatorProgramsTableViewController *)sender
                                  choseProgram:(id)program;
@end

@interface CalculatorProgramsTableViewController : UITableViewController
@property (nonatomic, strong) NSArray* programs;; // CaculatorBrain programs
@property (nonatomic, weak) id <CalculatorProgramsTableViewControllerDelegate> delegate;
@end
