//
//  AskerViewController.m
//  KitchenSink
//
//  Created by Duane Cawthron on 2/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AskerViewController.h"

@interface AskerViewController() <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UITextField *answerTextField;

@end

@implementation AskerViewController
@synthesize questionLabel = _questionLabel;
@synthesize answerTextField = _answerTextField;

@synthesize question = _question;
@synthesize answer = _answer;
@synthesize delegate = _default;

- (void)setQuestion:(NSString *)question
{
    _question = question;
    
    // this does not work because outlets have not yet been set
    // self.questionLabel.text = self.question;
}

#pragma mark - View lifecycle

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.questionLabel.text = self.question;
    self.answerTextField.placeholder = self.answer;
    self.answerTextField.delegate = self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.answerTextField becomeFirstResponder];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)viewDidUnload {
    [self setQuestionLabel:nil];
    [self setAnswerTextField:nil];
    [super viewDidUnload];
}

#pragma mark UITextFieldDelegate

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    self.answer = textField.text;
    if (![textField.text length]) {
        [[self presentedViewController] dismissModalViewControllerAnimated:YES];
    } else {
        [self.delegate askerViewController:self didAskQuestion:self.question andGotAnswer:self.answer];
    }
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if ([textField.text length]) {
        [textField resignFirstResponder];
        return YES;
    } else {
        return NO;
    }
}

@end
