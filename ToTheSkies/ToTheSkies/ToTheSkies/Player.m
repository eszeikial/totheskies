//
//  Player.m
//  ToTheSkies
//
//  Created by Student on 11/12/13.
//  Copyright (c) 2013 Student. All rights reserved.
//
//  Represents the player of the game

#import "Player.h"
#import "Pickup.h"
#import "GameplayScene.h"
#import "Obstacle.h"

// constants
static const float kImageScaleFactor = 0.5;
static NSString *const kImageFileName = @"character.png";



@implementation Player

// Initialize the player at a certain position ons creen
- (id)initWithStartPoint: (CGPoint) point{

    self = [super initWithImageNamed:kImageFileName andScaleFactor:kImageScaleFactor];
    
    if (self) {
        self.name = @"player";
        self.physicsBody.categoryBitMask = CategoryPlayerMask;
        self.physicsBody.contactTestBitMask = CategoryPickupMask | CategoryObstacleMask | CategoryKillMask | CategorySmogMask;// what contact to test for?
        self.physicsBody.collisionBitMask = CategoryObstacleMask; // what can the player physically collide with?
        self.position = point;
    }
    return self;
}

// Determine what we collided with and how to react
- (void)collide: (GameObject*) collisionObject{
 
     switch (collisionObject.physicsBody.categoryBitMask) {
         case CategorySmogMask:
             //[self.physicsBody setVelocity:CGVectorMake(self.physicsBody.velocity.dx, self.physicsBody.velocity.dy - (self.physicsBody.velocity.dy / 2.0))];
             [self.physicsBody applyImpulse:CGVectorMake(0.0,  kSmogSlowFactor * self.physicsBody.velocity.dy)];
             break;
         
         case CategoryObstacleMask:
             
             break;
             
             
         case CategoryKillMask:
             [((GameplayScene*)self.scene).soundBuddy playPlaneSound];
             [(GameplayScene*)self.scene endGame];
             break;
             
         case CategoryPickupMask:
             [collisionObject removeFromParent];
             if (((Pickup *)collisionObject).pType == PickupTypeBalloon){
                 [((GameplayScene*)self.scene).soundBuddy playPopSound];
                 [(GameplayScene*)self.scene updateScore:((Pickup*) collisionObject).points];
             }
             else {
                 [(GameplayScene*)self.scene addFuel];
             }
             
             break;
     
         default:
             break;
     }
 }

// Set the velocity of the player
-(void)setVelocityX:(float)x yVector:(float)y
{
    CGVector vec = CGVectorMake(x,y);
    self.physicsBody.velocity = vec;
}

@end
