//
//  GameplayScene.h
//  ToTheSkies
//
//  Created by Student on 11/12/13.
//  Copyright (c) 2013 Student. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

static const int kPickupsOnScreenLimit = 5;

@class Pickup;
@class ViewController;


@interface GameplayScene : SKScene <SKPhysicsContactDelegate>

@property (nonatomic, weak)ViewController *viewController;


@end
