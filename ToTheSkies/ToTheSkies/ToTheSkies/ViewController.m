//
//  ViewController.m
//  ToTheSkies
//
//  Created by Student on 11/12/13.
//  Copyright (c) 2013 Student. All rights reserved.
//

#import "ViewController.h"
#import <SpriteKit/SpriteKit.h>
#import "GameplayScene.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

// spriteview lazy loader
-(SKView *)spriteView
{
    if (!_spriteView){
        NSLog(@"%s",__FUNCTION__);
        // configure the view
        _spriteView = (SKView *) self.view;
        _spriteView.showsDrawCount = YES;
        _spriteView.showsNodeCount = YES;
        _spriteView.showsFPS = YES;
    }
    return _spriteView;
}

// title screen lazy loader
- (TitleScene*)titleScene
{
    if (!_titleScene) {
        NSLog(@"%s",__FUNCTION__);
        _titleScene = [TitleScene sceneWithSize: self.spriteView.bounds.size];
        _titleScene.scaleMode = SKSceneScaleModeAspectFill;
        _titleScene.viewController = self;
    }
    return _titleScene;
}

// credits screen lazy loader
- (CreditsScene*)creditsScene
{
    if (!_creditsScene) {
        NSLog(@"%s",__FUNCTION__);
        _creditsScene = [CreditsScene sceneWithSize: self.spriteView.bounds.size];
        _creditsScene.scaleMode = SKSceneScaleModeAspectFill;
        _creditsScene.viewController = self;
    }
    return _creditsScene;
}

// instruction screen lazy loader
- (InstructionScene*)instructionScene
{
    if (!_instructionScene) {
        NSLog(@"%s",__FUNCTION__);
        _instructionScene = [InstructionScene sceneWithSize:self.spriteView.bounds.size];
        _instructionScene.scaleMode = SKSceneScaleModeAspectFill;
        _instructionScene.viewController = self;
    }
    return _instructionScene;
}

// game screen lazy loader
- (GameplayScene*)gameScene
{
    if (!_gameScene) {
        NSLog(@"%s",__FUNCTION__);
        _gameScene = [GameplayScene sceneWithSize:self.spriteView.bounds.size];
        _gameScene.scaleMode = SKSceneScaleModeAspectFill;
        _gameScene.viewController = self;
    }
    return _gameScene;
}

// When the user clicks game start, transition to game screen
- (IBAction)clickedStartGameButton
{
    NSLog(@"%s",__FUNCTION__);
    [self hideUIElements:YES];
    [self.spriteView presentScene: self.gameScene];
}

// When the user clicks instructions, transition to instruction screen
- (IBAction)clickedInstructionsButton
{
    NSLog(@"%s",__FUNCTION__);
    [self hideUIElements:YES];
    [self.spriteView presentScene: self.instructionScene];
}

// When the user clicks credits button, transition to credits screen
- (IBAction)clickedCreditsButton
{
    NSLog(@"%s",__FUNCTION__);
    [self hideUIElements:YES];
    [self.spriteView presentScene: self.creditsScene];
}

// When the user clicks go back, transition back to the title screen
- (void)clickedGoBackButton
{
    NSLog(@"%s",__FUNCTION__);
    [self hideUIElements:NO];
    [self.spriteView presentScene: self.titleScene];
}

// Used to hide non-spritekit UI elements
- (void)hideUIElements:(BOOL)shouldHide
{
    CGFloat alpha = shouldHide ? 0.0f : 1.0f;
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        // fade out buttons
        self.playButton.alpha = alpha;
        self.instructionsButton.alpha = alpha;
        self.creditsButton.alpha = alpha;
        self.gameTitle.alpha = alpha;
        
    } completion:NULL];
}

// Pause the game, used by app delegate
-(void)pauseGame
{
    [_gameScene pause];
}

// Resume the game, used by app delegate
-(void)resumeGame
{
    [_gameScene resume];
}

// Start off using the title scene
-(void)viewWillAppear:(BOOL)animated
{
    [self.spriteView presentScene:self.titleScene];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

@end
