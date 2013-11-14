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


- (IBAction)clickedStartGameButton
{
    NSLog(@"%s",__FUNCTION__);
    [self hideUIElements:YES];
    [self.spriteView presentScene: self.gameScene];
}

- (IBAction)clickedInstructionsButton
{
    NSLog(@"%s",__FUNCTION__);
    [self hideUIElements:YES];
    [self.spriteView presentScene: self.instructionScene];
}

- (void)clickedGoBackButton
{
    NSLog(@"%s",__FUNCTION__);
    [self hideUIElements:NO];
    [self.spriteView presentScene: self.titleScene];
}

- (void)hideUIElements:(BOOL)shouldHide
{
    CGFloat alpha = shouldHide ? 0.0f : 1.0f;
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        // fade out buttons
        self.playButton.alpha = alpha;
        self.instructionsButton.alpha = alpha;
        self.gameTitle.alpha = alpha;
        
        
    } completion:NULL];
}

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
