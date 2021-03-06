//
//  ObstacleSpawner.h
//  ToTheSkies
//
//  Created by Student on 12/3/13.
//  Copyright (c) 2013 Student. All rights reserved.
//
//  An object spawner specifically for negative collidables known as obstacles

#import "ObjectSpawner.h"
#import "Obstacle.h"


@interface ObstacleSpawner : ObjectSpawner

- (id)initWithObstacleType: (ObstacleType) oType
                     Layer: (SKNode*)layer
   maxItemsOnScreen: (int) maxItems
              delay: (double) spawnDelay;
@end
