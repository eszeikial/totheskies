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
    newObstacle.position = CGPointMake(randInRange(0, self.gameLayer.scene.size.width), self.gameLayer.scene.size.height + newObstacle.size.height / 2);
    
    
    //NSLog(@"%.2f", self.gameLayer.scene.size.height);
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
    [node setPosition:CGPointMake(node.position.x, node.position.y - 1)]; //move on-screen items
    
} // end move

@end
