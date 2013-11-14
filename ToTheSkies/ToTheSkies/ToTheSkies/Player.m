//
//  Player.m
//  ToTheSkies
//
//  Created by Student on 11/12/13.
//  Copyright (c) 2013 Student. All rights reserved.
//

#import "Player.h"
#import "Pickup.h"

// constants
static const float kImageScaleFactor = 0.5;
static NSString *const kImageFileName = @"character.png";



@implementation Player

- (id)initWithStartPoint: (CGPoint) point{

    self = [super initWithImageNamed:kImageFileName andScaleFactor:kImageScaleFactor];
    
    if (self) {
        self.name = @"player";
        self.physicsBody.categoryBitMask = ColliderTypePlayer;
        self.physicsBody.collisionBitMask = self.physicsBody.contactTestBitMask = ColliderTypeTrampoline | ColliderTypeObstacle | ColliderTypePickup;
        self.position = point;
    }
    return self;
}

- (void)collide: (GameObject*) collisionObject withCategory:(uint8_t) collideCategory{
    
    switch (collideCategory) {
        case ColliderTypeObstacle:
            NSLog(@"Obstacle");
            break;
        case ColliderTypePickup:
            NSLog(@"Pickup");
            NSLog(@"%@", collisionObject.scene.children.debugDescription);
            [collisionObject removeFromParent];
            [self addPoints:((Pickup*) collisionObject).points];
            break;
            
        default:
            break;
    }
}

- (void)addPoints: (int)points{
    NSLog(@"Added %d points!", points);
}

/*-(CGVector)getVelocity  Don't need this, unless you really want it #ZACH
{
    return self.physicsBody.velocity;
} */

-(void)setVelocityX:(float)x yVector:(float)y
{
    CGVector vec = CGVectorMake(x,y);
    self.physicsBody.velocity = vec;
}

@end
