//
//  Pickup.m  // extends GameObject
//  ToTheSkies
//
//  Created by Student on 11/12/13.
//  Copyright (c) 2013 Student. All rights reserved.
//

#import "Pickup.h"

static NSString *const kBalloonImage = @"redballoon.png";
static const float kImageScaleFactor = 0.5;

@implementation Pickup

- (id)initWithStartPoint: (CGPoint) point{
    
    self = [super initWithImageNamed:kBalloonImage andScaleFactor:kImageScaleFactor];
    
    if (self) {
        self.type = PickupTypeBalloon;
        self.name = @"pickup";
        self.physicsBody.categoryBitMask = ColliderTypePickup;
        self.physicsBody.affectedByGravity = NO; // DEBUG
        
        self.position = point;
    }
    return self;
}

@end
