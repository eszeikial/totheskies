//
//  GameplayScene.h
//  ToTheSkies
//
//  Created by Student on 11/12/13.
//  Copyright (c) 2013 Student. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

static const int kMaxPickupsOnScreen = 5;
static const int kMaxCloudsOnScreen = 8; 
static const double kPickupSpawnDelay = 2.0;
static const double kCloudSpawnDelay = 3.0; 

@class Pickup;
@class ViewController;


@interface GameplayScene : SKScene <SKPhysicsContactDelegate, UIAlertViewDelegate>

@property (nonatomic, weak)ViewController *viewController;

-(void)pause;
-(void)resume;
-(void)updateScore: (float) points;

@end
