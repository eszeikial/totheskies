//
//  Obstacle.m
//  ToTheSkies
//
//  Created by Student on 12/3/13.
//  Copyright (c) 2013 Student. All rights reserved.
//

#import "Obstacle.h"

@implementation Obstacle


- (id)initWithObstacleType:(ObstacleType)oType{
    
    switch(oType)
    {
        case ObstacleTypeSmog: self = [self initSmogCloud];
        case ObstacleTypePlane: self = [self initPlane];
    }
    
    if (self) {
        self.physicsBody.categoryBitMask = CategoryObstacleMask;
    }
    return self;
}

- (id)initSmogCloud{
    
    self = [super initWithImageNamed:@"smogcloud.png" andScaleFactor:1.0];
    
    NSLog(@"created");
    if (self) {
        self.name = @"smog";
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.contactTestBitMask = CategoryPlayerMask;
        self.physicsBody.collisionBitMask = 0; // shouldn't physically collide with things
    }
    return self;
}

- (id)initPlane{
    
    self = [super initWithImageNamed:@"plane.png" andScaleFactor:1.0];
    
    if (self) {
        self.name = @"plane";
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.contactTestBitMask = CategoryPlayerMask;
        self.physicsBody.collisionBitMask = 1; // shouldn't physically collide with things
    }
    return self;
}
                                       
                                       

@end
