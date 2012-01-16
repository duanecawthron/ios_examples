//
//  GraphView.h
//  Calculator
//
//  Created by Duane Cawthron on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GraphView;

@protocol GraphViewDataSource
- (double)yValueForGraphView:(GraphView *)sender usingXValue:(double)xValue;
@end

@interface GraphView : UIView
@property (nonatomic, weak) IBOutlet id <GraphViewDataSource> dataSource;
@property (nonatomic) CGFloat scale;
@property (nonatomic) CGPoint origin;

- (IBAction)handlePinch:(UIPinchGestureRecognizer *)gesture;
- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer;

@end
