//
//  ObstacleSpawner.m
//  ToTheSkies
//
//  Created by Student on 12/3/13.
//  Copyright (c) 2013 Student. All rights reserved.
//
//  An object spawner specifically for negative collidables known as obstacles

#import "ObstacleSpawner.h"
#import "Obstacle.h"
#import "Helper.h"


@implementation ObstacleSpawner{
    ObstacleType _oType;
}

// Initializer
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

// Spawn the obstacle
-(Obstacle*)spawn{
   
    int planeType = arc4random() % 2;
    Obstacle *newObstacle = [[Obstacle alloc] initWithObstacleType:_oType :planeType];
    
    switch (_oType) {
        case ObstacleTypeSmog:
            newObstacle.position = CGPointMake(randInRange(0, self.gameLayer.scene.size.width), self.gameLayer.scene.size.height + newObstacle.size.height);
            break;
        case ObstacleTypePlane:
            if(planeType == 0) // Plane Right
                newObstacle.position = CGPointMake(0 - newObstacle.size.width, randInRange(0, self.gameLayer.scene.size.height));
            else
                newObstacle.position = CGPointMake(self.gameLayer.scene.size.width + newObstacle.size.width, randInRange(0, self.gameLayer.scene.size.height));
            break;
        default:
            break;
    }
    
    return newObstacle;
}

// Despawn the obstacle
-(void)despawn{
    switch (_oType) {
        case ObstacleTypeSmog:
            [self despawnWithName:@"smog"];
            break;
        case ObstacleTypePlane:
            [self despawnWithName:@"planeright"];
            [self despawnWithName:@"planeleft"];
        default:
            break;
    }
}

// Move the obstacle
-(void)moveNode:(SKNode *)node{
    
    switch (_oType) {
        case ObstacleTypeSmog:
            [node setPosition:CGPointMake(node.position.x, node.position.y - 1)]; //move on-screen items
            break;
        case ObstacleTypePlane:
            if([node.name isEqualToString:@"planeright"])
                [node setPosition:CGPointMake(node.position.x + 3, node.position.y)]; //move on-screen items
            else
                [node setPosition:CGPointMake(node.position.x - 3, node.position.y)]; //move on-screen items
            break;
        default:
            break;
    }
} // end move

@end
