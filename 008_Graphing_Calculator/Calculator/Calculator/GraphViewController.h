//
//  GraphViewController.h
//  Calculator
//
//  Created by Duane Cawthron on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphView.h"
#import "CalculatorBrain.h"

@interface GraphViewController : UIViewController
@property (nonatomic, strong) CalculatorBrain *brain;
@property (nonatomic, weak) IBOutlet GraphView *graphView;
@end
