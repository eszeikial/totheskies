//
//  Obstacle.h
//  ToTheSkies
//
//  Created by Student on 12/3/13.
//  Copyright (c) 2013 Student. All rights reserved.
//
//  A game object that has a negative effect when the player collides with it

#import "GameObject.h"

typedef enum {
    ObstacleTypeSmog,
    ObstacleTypePlane
} ObstacleType;

static float const kSmogSlowFactor = -0.05;

@interface Obstacle : GameObject

@property (nonatomic, assign) ObstacleType oType;

- (id)initWithObstacleType: (ObstacleType) obstacleType :(int) planeType;

@end
