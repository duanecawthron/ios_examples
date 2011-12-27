//
//  HelloWorldViewController.h
//  HelloWorld
//
//  Created by cawthron on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelloWorldViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textField;

- (IBAction)changeGreeting:(id)sender;
@end
