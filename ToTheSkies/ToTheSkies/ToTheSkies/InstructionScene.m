//
//  InstructionScene.m
//  ToTheSkies
//
//  Created by Student on 11/13/13.
//  Copyright (c) 2013 Student. All rights reserved.
//
//  Controls the instruction screen

#import "InstructionScene.h"
#import "ViewController.h"

@implementation InstructionScene
{
    UILabel* _label;
}

// When the screen is presented
- (void)didMoveToView:(SKView *)view
{
    self.backgroundColor = [SKColor colorWithRed:0.68 green:0.85 blue:0.98 alpha:1.0]; // #AEDAF9
    [self createSceneContents];
}

// Create the elements for the scene
-(void)createSceneContents
{
    [self.viewController.spriteView addSubview: [self createLabel]];
    [self.viewController.spriteView addSubview: [self createButton]];
}

// Create a text label
-(UILabel*)createLabel
{
    _label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.frame) - 130, 80, 300, 700)];
    _label.backgroundColor = [UIColor clearColor];
    _label.textColor= [UIColor whiteColor];
    _label.lineBreakMode = NSLineBreakByWordWrapping;
    _label.numberOfLines = 0;
    _label.text = @"Instructions:\n\nUse your finger to draw a trampoline under the character!\n\nColliding with objects will have various positive and negative effects.\n\nDifferent colored balloons award different amounts of points.\n\nAscending higher will also award points!";
    _label.font = [UIFont boldSystemFontOfSize:30];
    
    return _label;
}

// Create a go back button
- (UIButton*)createButton
{
    UIButton* goBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [goBackButton addTarget:self
               action:@selector(goBack:)
     forControlEvents:UIControlEventTouchDown];
    [goBackButton setTitle:@"Go Back" forState:UIControlStateNormal];
    
    goBackButton.frame = CGRectMake(300, 840, 160.0, 40.0);
    goBackButton.titleLabel.font = [UIFont boldSystemFontOfSize:40];
    
    return goBackButton;
}

// Return to title screen when pressed
-(void)goBack:(UIButton*)button
{
    button.alpha = 0.0;
    _label.hidden = true;
    [self.viewController clickedGoBackButton];
}

@end
