//
//  Player.h
//  ToTheSkies
//
//  Created by Student on 11/12/13.
//  Copyright (c) 2013 Student. All rights reserved.
//
//  Represents the player of the game

#import <SpriteKit/SpriteKit.h>
#import "GameObject.h"



@interface Player : GameObject

- (id)initWithStartPoint: (CGPoint) point;
- (void)collide: (GameObject*) collisionObject;
- (void)setVelocityX:(float)x yVector:(float)y;


@end
