//
//  Obstacle.h
//  ToTheSkies
//
//  Created by Student on 12/3/13.
//  Copyright (c) 2013 Student. All rights reserved.
//

#import "GameObject.h"

typedef enum {
    ObstacleTypeSmog,
    ObstacleTypePlane
} ObstacleType;


@interface Obstacle : GameObject

@property (nonatomic, assign) ObstacleType oType;

- (id)initWithObstacleType: (ObstacleType) obstacleType;

@end
