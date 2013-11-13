//
//  GameplayScene.h
//  ToTheSkies
//
//  Created by Student on 11/12/13.
//  Copyright (c) 2013 Student. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef enum : uint8_t {
    APAColliderTypeHero = 1,
    APAColliderTypeGoblinOrBoss = 2,
    APAColliderTypeProjectile = 4,
    APAColliderTypeWall = 8,
    APAColliderTypeCave = 16
} APAColliderType;


@interface GameplayScene : SKScene

//Method used to pass valid trampoline information from
//the viewcontroller to the gameplay scene.

//-(void)getTrampolinePath:(CGPathRef)path;  //#ZACH | you going to need this? Just commented out to remove the error. Sorry.

@end
