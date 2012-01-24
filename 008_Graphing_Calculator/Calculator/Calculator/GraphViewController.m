//
//  GraphViewController.m
//  Calculator
//
//  Created by Duane Cawthron on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GraphViewController.h"
#import "CalculatorBrain.h"
#import "CalculatorProgramsTableViewController.h"

@interface GraphViewController() <GraphViewDataSource, CalculatorProgramsTableViewControllerDelegate>
@property (nonatomic, weak) IBOutlet UIToolbar *toolbar;
@end

@implementation GraphViewController

@synthesize graphView = _graphView;
@synthesize splitViewBarButtonItem =_splitViewBarButtonItem;
@synthesize toolbar = _toolbar;
@synthesize program = _program;

#define FAVORITES_KEY @"CalculatorGraphViewController.Favorites"

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show Favorite Graphs"]) {
        NSArray *programs = [[NSUserDefaults standardUserDefaults] objectForKey:FAVORITES_KEY];
        [segue.destinationViewController setPrograms:programs];
        [segue.destinationViewController setDelegate:self];
    }
}

- (IBAction)addToFavorites:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *favorites = [[defaults objectForKey:FAVORITES_KEY] mutableCopy];
    if (!favorites) favorites = [NSMutableArray array];
    [favorites addObject:self.program];
    [defaults setValue:favorites forKey:FAVORITES_KEY];
    [defaults synchronize];
}

- (void) setSplitViewBarButtonItem:(UIBarButtonItem *)splitViewBarButtonItem
{
    if (_splitViewBarButtonItem != splitViewBarButtonItem) {
        NSMutableArray *toolbarItems = [self.toolbar.items mutableCopy];
        if (_splitViewBarButtonItem) [toolbarItems removeObject:_splitViewBarButtonItem];
        if (splitViewBarButtonItem) [toolbarItems insertObject:splitViewBarButtonItem atIndex:0];
        self.toolbar.items = toolbarItems;
        _splitViewBarButtonItem = splitViewBarButtonItem;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (double)yValueForGraphView:(GraphView *)sender forXValue:(double)xValue
{
    NSDictionary *variableValues = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:xValue], @"x", nil];
    double result = [CalculatorBrain runProgram:self.program usingVariableValues:variableValues];
    return result;
}

- (NSString *)descriptionOfGraph:(GraphView *)sender
{
    return [CalculatorBrain descriptionOfProgram:self.program];
}

- (void)setProgram:(id)program
{
    _program = program;
    [self.graphView setNeedsDisplay];
}

- (void) calculatorProgramsTableViewController:(CalculatorProgramsTableViewController *)sender
                                  choseProgram:(id)program
{
    self.program = program;
    
    // if you wanted to close the popover when a graph was selected
    // you could uncomment the following line
    // you'd probably want to set self.popoverController = nil after doing so
    // [self.popoverController dismissPopoverAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES]; // added after lecture to support iPhone
}

- (void)calculatorProgramsTableViewController:(CalculatorProgramsTableViewController *)sender
                               deletedProgram:(id)program
{
    NSString *deletedProgramDescription = [CalculatorBrain descriptionOfProgram:program];
    NSMutableArray *favorites = [NSMutableArray array];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    for (id program in [defaults objectForKey:FAVORITES_KEY]) {
        if (![[CalculatorBrain descriptionOfProgram:program] isEqualToString:deletedProgramDescription]) {
            [favorites addObject:program];
        }
    }
    [defaults setObject:favorites forKey:FAVORITES_KEY];
    [defaults synchronize];
    sender.programs = favorites;
}

@end
