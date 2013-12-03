//
//  ObstacleSpawner.m
//  ToTheSkies
//
//  Created by Student on 12/3/13.
//  Copyright (c) 2013 Student. All rights reserved.
//

#import "ObstacleSpawner.h"
#import "Obstacle.h"
#import "Helper.h"


@implementation ObstacleSpawner{
    ObstacleType _oType;
}

- (id)initWithObstacleType: (ObstacleType) oType
                     Layer: (SKNode*)layer
          maxItemsOnScreen: (int) maxItems
                     delay: (double) spawnDelay{
    
    self = [super initWithLayer:layer maxItemsOnScreen:maxItems delay:spawnDelay];
    
    if (self){
        _oType = oType;
    }
    return self;
}

-(Obstacle*)spawn{
    Obstacle *newObstacle = [[Obstacle alloc] initWithObstacleType:_oType];
    
    switch (_oType) {
        case ObstacleTypeSmog:
            newObstacle.position = CGPointMake(randInRange(0, self.gameLayer.scene.size.width), self.gameLayer.scene.size.height + newObstacle.size.height);
            break;
        case ObstacleTypePlane:
            newObstacle.position = CGPointMake(0 - newObstacle.size.width, randInRange(0, self.gameLayer.scene.size.height));
            break;
        default:
            break;
    }
    
    
    return newObstacle;
}

-(void)despawn{
    switch (_oType) {
        case ObstacleTypeSmog:
            [self despawnWithName:@"smog"];
            break;
        case ObstacleTypePlane:
             [self despawnWithName:@"plane"];
        default:
            break;
    }
}// end despawn




-(void)moveNode:(SKNode *)node{
    
    switch (_oType) {
        case ObstacleTypeSmog:
            [node setPosition:CGPointMake(node.position.x, node.position.y - 1)]; //move on-screen items
            break;
        case ObstacleTypePlane:
            [node setPosition:CGPointMake(node.position.x + 3, node.position.y)]; //move on-screen items
            break;
        default:
            break;
    }
} // end move

@end
