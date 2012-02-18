//
//  AskerViewController.h
//  KitchenSink
//
//  Created by Duane Cawthron on 2/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AskerViewController;

@protocol AskerViewControllerDelegate <NSObject>

- (void)askerViewController:(AskerViewController *)sender
             didAskQuestion:(NSString *)question
               andGotAnswer:(NSString *)answer;

@end
@interface AskerViewController : UIViewController

@property (nonatomic, copy) NSString *question;
@property (nonatomic, copy) NSString *answer;

@property (nonatomic, weak) id <AskerViewControllerDelegate> delegate;

@end
