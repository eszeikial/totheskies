//
//  ViewController.h
//  ToTheSkies
//
//  Created by Student on 11/12/13.
//  Copyright (c) 2013 Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameplayScene.h"
#import "TitleScene.h"
#import "InstructionScene.h"

@interface ViewController : UIViewController

@property(nonatomic, strong) GameplayScene* gameScene;
@property(nonatomic, strong) TitleScene* titleScene;
@property(nonatomic, strong) InstructionScene* instructionScene;
@property(nonatomic, weak) SKView* spriteView;
@property(weak, nonatomic) IBOutlet UIButton* playButton;
@property(weak, nonatomic) IBOutlet UIButton* instructionsButton;
@property(weak, nonatomic) IBOutlet UIImageView* gameTitle;

- (IBAction)clickedStartGameButton;
- (IBAction)clickedInstructionsButton;
- (void)clickedGoBackButton;
- (void)pauseGame;
- (void)resumeGame;

@end
