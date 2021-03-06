//
//  GameplayScene.h
//  ToTheSkies
//
//  Created by Student on 11/12/13.
//  Copyright (c) 2013 Student. All rights reserved.
//
//  Constrols the scene where the game is running

#import <SpriteKit/SpriteKit.h>
#import "SoundBuddy.h"

static const NSString* kMaxPickupsOnScreen = @"maxPickUps";
static const NSString* kMaxCloudsOnScreen = @"maxClouds";
static const NSString* kPickupSpawnDelay = @"pickUpSpawnDelay";
static const NSString* kCloudSpawnDelay = @"cloudSpawnDelay";

@class Pickup;
@class ViewController;


@interface GameplayScene : SKScene <SKPhysicsContactDelegate, UIAlertViewDelegate>

@property (nonatomic, weak)ViewController *viewController;
@property (nonatomic, strong)SoundBuddy *soundBuddy;

-(void)pause;
-(void)resume;
-(void)updateScore: (float) points;
-(void)endGame;
-(void)addFuel;

@end
