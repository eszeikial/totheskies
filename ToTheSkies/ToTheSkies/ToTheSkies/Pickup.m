//
//  Pickup.m  // extends GameObject
//  ToTheSkies
//
//  Created by Student on 11/12/13.
//  Copyright (c) 2013 Student. All rights reserved.
//
//  Represents objects that provide benefits when collided with

#import "Pickup.h"
#import "GameplayScene.h"
#import "Helper.h"

// constants for accessing images
static NSString *const kBlueBalloonImage = @"blueballoon.png";
static NSString *const kGreenBalloonImage = @"greenballoon.png";
static NSString *const kOrangeBalloonImage = @"orangeballoon.png";
static NSString *const kPurpleBalloonImage = @"purpleballoon.png";
static NSString *const kYellowBalloonImage = @"yellowballoon.png";
static NSString *const kFuelImage = @"oil.png";

// constants for balloon point values
static int const kBlueBalloonPoints = 5;
static int const kGreenBalloonPoints = 10;
static int const kOrangeBalloonPoints = 15;
static int const kPurpleBalloonPoints = 20;
static int const kYellowBalloonPoints = 50;

static int const kNumBalloonTypes = 5; // Should match number of consts above.

static const float kImageScaleFactor = 0.15;
static const float kOilScaleFactor = 0.25;

static const int kBalloonPoints = 100;
static const int kDefaultPoints = 10;

@implementation Pickup

// Initialize the pick up at a certain starting position
- (id)initWithStartPoint: (CGPoint) point{
    
    PickupType ptype;
    int chance = randInRange(0, 100);
    if (chance < 20){
        ptype = PickupTypeFuel;
    }
    else{
        ptype = PickupTypeBalloon;
    }
    
    if (ptype == PickupTypeBalloon){
    
        int balloonType = arc4random() % kNumBalloonTypes;
        switch(balloonType)
        {
            case 0: self = [self initBalloonWithColor:BalloonColorBlue]; break;
            case 1: self = [self initBalloonWithColor:BalloonColorGreen]; break;
            case 2: self = [self initBalloonWithColor:BalloonColorOrange]; break;
            case 3: self = [self initBalloonWithColor:BalloonColorPurple]; break;
            case 4: self = [self initBalloonWithColor:BalloonColorYellow]; break;
        }
    }
    else {
        self = [self initFuel];
    }
        
    if (self) {
        self.position = point;
    }
    return self;
}

// Initialize the balloon with a random color
- (id)initBalloonWithColor: (BalloonColor) color{
    
    switch(color)
    {
        case BalloonColorBlue: self = [super initWithImageNamed:kBlueBalloonImage andScaleFactor:kImageScaleFactor]; break;
        case BalloonColorGreen: self = [super initWithImageNamed:kGreenBalloonImage andScaleFactor:kImageScaleFactor]; break;
        case BalloonColorOrange: self = [super initWithImageNamed:kOrangeBalloonImage andScaleFactor:kImageScaleFactor]; break;
        case BalloonColorPurple: self = [super initWithImageNamed:kPurpleBalloonImage andScaleFactor:kImageScaleFactor]; break;
        case BalloonColorYellow: self = [super initWithImageNamed:kYellowBalloonImage andScaleFactor:kImageScaleFactor]; break;
    }
    
    if (self) {
        
        switch (color){
            case BalloonColorBlue:
                self.bColor = BalloonColorBlue;
                self.points = kBlueBalloonPoints;
                break;
            case BalloonColorGreen:
                self.bColor = BalloonColorGreen;
                self.points = kGreenBalloonPoints;
                break;
            case BalloonColorOrange:
                self.bColor = BalloonColorOrange;
                self.points = kOrangeBalloonPoints;
                break;
            case BalloonColorPurple:
                self.bColor = BalloonColorPurple;
                self.points = kPurpleBalloonPoints;
                break;
            case BalloonColorYellow:
                self.bColor = BalloonColorYellow;
                self.points = kYellowBalloonPoints;
                break;
        }
        
        
        self.pType = PickupTypeBalloon;
        self.name = @"pickup";
        self.physicsBody.categoryBitMask = CategoryPickupMask;
        self.physicsBody.contactTestBitMask = CategoryPlayerMask;
        self.physicsBody.collisionBitMask = 0; // shouldn't physically collide with things
        
        self.physicsBody.linearDamping = 1.0; // so it doesn't drop like a stone
    }
    return self;
    
}

// Initialize a fuel pickup
-(id)initFuel{
    self = [super initWithImageNamed:kFuelImage andScaleFactor:kOilScaleFactor];
    self.pType = PickupTypeFuel;
    self.name = @"pickup";
    self.physicsBody.categoryBitMask = CategoryPickupMask;
    self.physicsBody.contactTestBitMask = CategoryPlayerMask;
    self.physicsBody.collisionBitMask = 0; // shouldn't physically collide with things
    
    self.physicsBody.linearDamping = 1.0; // so it doesn't drop like a stone
    
    return self;
}

// Return how many points the pick up is worth when collided with
-(int)points{
    switch (_pType) {
        
        case PickupTypeBalloon:
            return _points;
            break;
            
        default:
            return kDefaultPoints;
            break;
    } // end switch
}




@end
