//
//  Pickup.m  // extends GameObject
//  ToTheSkies
//
//  Created by Student on 11/12/13.
//  Copyright (c) 2013 Student. All rights reserved.
//

#import "Pickup.h"
#import "GameplayScene.h"

static NSString *const kBlueBalloonImage = @"blueballoon.png";
static NSString *const kGreenBalloonImage = @"greenballoon.png";
static NSString *const kOrangeBalloonImage = @"orangeballoon.png";
static NSString *const kPurpleBalloonImage = @"purpleballoon.png";
static NSString *const kYellowBalloonImage = @"yellowballoon.png";
static int const kNumBalloonTypes = 5; // Should match number of consts above.

static const float kImageScaleFactor = 0.15;

static const int kBalloonPoints = 100;

@implementation Pickup

- (id)initWithStartPoint: (CGPoint) point{
    
    
    int balloonType = arc4random() % kNumBalloonTypes;
    switch(balloonType)
    {
        case 0: self = [super initWithImageNamed:kBlueBalloonImage andScaleFactor:kImageScaleFactor]; break;
        case 1: self = [super initWithImageNamed:kGreenBalloonImage andScaleFactor:kImageScaleFactor]; break;
        case 2: self = [super initWithImageNamed:kOrangeBalloonImage andScaleFactor:kImageScaleFactor]; break;
        case 3: self = [super initWithImageNamed:kPurpleBalloonImage andScaleFactor:kImageScaleFactor]; break;
        case 4: self = [super initWithImageNamed:kYellowBalloonImage andScaleFactor:kImageScaleFactor]; break;
    }
    
    if (self) {
        self.type = PickupTypeBalloon;
        self.name = @"pickup";
        self.physicsBody.categoryBitMask = CategoryPickupMask;
        self.physicsBody.contactTestBitMask = CategoryPlayerMask;
        self.physicsBody.collisionBitMask = 0; // shouldn't physically collide with things
        
        self.physicsBody.linearDamping = 1.0; // so it doesn't drop like a stone
        self.position = point;
    }
    return self;
}


-(int)points{
    switch (self.type) {
        
        case PickupTypeBalloon:
            return kBalloonPoints;
            break;
            
        default:
            return 10;
            break;
    } // end switch
}




@end
