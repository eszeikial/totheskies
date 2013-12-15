//
//  Player.m
//  ToTheSkies
//
//  Created by Student on 11/12/13.
//  Copyright (c) 2013 Student. All rights reserved.
//

#import "Player.h"
#import "Pickup.h"
#import "GameplayScene.h"
#import "Obstacle.h"

// constants
static const float kImageScaleFactor = 0.5;
static NSString *const kImageFileName = @"character.png";



@implementation Player

- (id)initWithStartPoint: (CGPoint) point{

    self = [super initWithImageNamed:kImageFileName andScaleFactor:kImageScaleFactor];
    
    if (self) {
        self.name = @"player";
        self.physicsBody.categoryBitMask = CategoryPlayerMask;
        self.physicsBody.contactTestBitMask = CategoryPickupMask | CategoryObstacleMask | CategorySmogMask;// what contact to test for?
        self.physicsBody.collisionBitMask = CategoryObstacleMask; // what can the player physically collide with?
        self.position = point;
    }
    return self;
}

- (void)collide: (GameObject*) collisionObject{
 
     switch (collisionObject.physicsBody.categoryBitMask) {
         case CategorySmogMask:
             //[self.physicsBody setVelocity:CGVectorMake(self.physicsBody.velocity.dx, self.physicsBody.velocity.dy - (self.physicsBody.velocity.dy / 2.0))];
             [self.physicsBody applyImpulse:CGVectorMake(0.0,  kSmogSlowFactor * self.physicsBody.velocity.dy)];
             break;
         
         case CategoryObstacleMask:
             
             break;
         case CategoryPickupMask:
             [collisionObject removeFromParent];
             //[self addPoints:((Pickup*) collisionObject).points];
             [(GameplayScene*)self.scene updateScore:((Pickup*) collisionObject).points];
             break;
     
         default:
             break;
     }
 }

-(void)setVelocityX:(float)x yVector:(float)y
{
    CGVector vec = CGVectorMake(x,y);
    self.physicsBody.velocity = vec;
}

@end
