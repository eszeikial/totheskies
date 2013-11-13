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

@interface Pickup : GameObject


@property (nonatomic, assign) PickupType type;

- (id)initWithStartPoint: (CGPoint) point;

@end
