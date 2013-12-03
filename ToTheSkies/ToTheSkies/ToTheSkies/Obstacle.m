//
//  Obstacle.m
//  ToTheSkies
//
//  Created by Student on 12/3/13.
//  Copyright (c) 2013 Student. All rights reserved.
//

#import "Obstacle.h"

@implementation Obstacle


- (id)initWithObstacleType:(ObstacleType)obstacleType{
    
    switch(obstacleType)
    {
        case ObstacleTypeSmog: self = [self initSmogCloud]; break;
        case ObstacleTypePlane: self = [self initPlane]; break;
    }
    
    if (self) {
        // stuff
    }
    return self;
}

- (id)initSmogCloud{
    
    self = [super initWithImageNamed:@"smogcloud.png" andScaleFactor:1.0];
    

    if (self) {
        self.name = @"smog";
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.contactTestBitMask = CategoryPlayerMask;
        self.physicsBody.categoryBitMask = CategorySmogMask;
        self.physicsBody.collisionBitMask = 0; // shouldn't physically collide with things
    }
    return self;
}

- (id)initPlane{
    
    self = [super initWithImageNamed:@"plane.png" andScaleFactor:1.0];
        NSLog(@"created");
    if (self) {
        self.name = @"plane";
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.contactTestBitMask = CategoryPlayerMask;
        self.physicsBody.categoryBitMask = CategoryObstacleMask;
        self.physicsBody.collisionBitMask = 1; // shouldn't physically collide with things
    }
    return self;
}
                                       
                                       

@end
