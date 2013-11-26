//
//  CreditsScene.m
//  ToTheSkies
//
//  Created by Student on 11/22/13.
//  Copyright (c) 2013 Student. All rights reserved.
//

#import "CreditsScene.h"
#import "ViewController.h"

@implementation CreditsScene
{
    
    UILabel* _label;
}

- (void)didMoveToView:(SKView *)view
{
    self.backgroundColor = [SKColor colorWithRed:0.68 green:0.85 blue:0.98 alpha:1.0]; // #AEDAF9
    [self createSceneContents];
}

-(void)createSceneContents
{
    [self.viewController.spriteView addSubview: [self createLabel]];
    [self.viewController.spriteView addSubview: [self createButton]];
}

-(UILabel*)createLabel
{
    _label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.frame) - 200, 0, 300, 700)];
    _label.backgroundColor = [UIColor clearColor];
    _label.textColor= [UIColor whiteColor];
    _label.lineBreakMode = NSLineBreakByWordWrapping;
    _label.numberOfLines = 0;
    _label.text = @"Credits\n\nDeveloped by Zachary Butler, Lindsey Ellis, and Sarah Plotkin\n\nSound effects from SoundBible.com\n\nGame inspired by Trampoline Time from New Super Mario Bros";
    _label.font = [UIFont boldSystemFontOfSize:30];
    
    return _label;
}

- (UIButton*)createButton
{
    UIButton* goBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [goBackButton addTarget:self
                     action:@selector(goBack:)
           forControlEvents:UIControlEventTouchDown];
    [goBackButton setTitle:@"Go Back" forState:UIControlStateNormal];
    
    goBackButton.frame = CGRectMake(300, 800, 160.0, 40.0);
    goBackButton.titleLabel.font = [UIFont boldSystemFontOfSize:40];
    
    return goBackButton;
}

-(void)goBack:(UIButton*)button
{
    button.alpha = 0.0;
    _label.hidden = true;
    [self.viewController clickedGoBackButton];
}

@end
