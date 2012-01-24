//
//  GraphViewController.h
//  Calculator
//
//  Created by Duane Cawthron on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphView.h"
#import "SplitViewBarButtonItemPresenter.h"

@interface GraphViewController : UIViewController <SplitViewBarButtonItemPresenter>
@property (nonatomic, strong) id program;
@property (nonatomic, weak) IBOutlet GraphView *graphView;
@end
