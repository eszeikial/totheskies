//
//  Pickup.h  // Extends GameObject
//  ToTheSkies
//
//  Created by Student on 11/12/13.
//  Copyright (c) 2013 Student. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameObject.h"

typedef enum {
    PickupTypeBalloon = 1,
    PickupTypeFuel = 2,
    PickupTypeRing = 3
} PickupType;

typedef enum {
    BalloonColorBlue,
    BalloonColorGreen,
    BalloonColorOrange,
    BalloonColorPurple,
    BalloonColorYellow
} BalloonColor;

@interface Pickup : GameObject


@property (nonatomic, assign) PickupType pType;
@property (nonatomic, assign) BalloonColor bColor;
@property (nonatomic, assign) int points;

- (id)initWithStartPoint: (CGPoint) point;

@end
