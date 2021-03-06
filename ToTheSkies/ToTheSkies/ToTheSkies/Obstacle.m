//
//  Obstacle.m
//  ToTheSkies
//
//  Created by Student on 12/3/13.
//  Copyright (c) 2013 Student. All rights reserved.
//
//  A game object that has a negative effect when the player collides with it

#import "Obstacle.h"

@implementation Obstacle

// Initialize as a specfic type of obstacles
- (id)initWithObstacleType:(ObstacleType)obstacleType :(int)planeType{
    
    switch(obstacleType)
    {
        case ObstacleTypeSmog: self = [self initSmogCloud]; break;
        case ObstacleTypePlane: self = [self initPlane:planeType]; break;
    }
    
    if (self) {
        // stuff
    }
    return self;
}

// Initialize as a smog cloud
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

// Initialize as a plane
- (id)initPlane: (int)planeType{
    if(planeType == 0)
        self = [super initWithImageNamed:@"planeright.png" andScaleFactor:.5];
    else
        self = [super initWithImageNamed:@"planeleft.png" andScaleFactor:.5];
    
    if (self) {
        if(planeType == 0)
            self.name = @"planeright";
        else
            self.name = @"planeleft";
        
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.contactTestBitMask = CategoryPlayerMask;
        self.physicsBody.categoryBitMask = CategoryKillMask;
        self.physicsBody.collisionBitMask = 1; // shouldn't physically collide with things
    }
    return self;
}
                                       
                                       

@end
