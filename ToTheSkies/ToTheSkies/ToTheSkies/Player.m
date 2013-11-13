//
//  Player.m
//  ToTheSkies
//
//  Created by Student on 11/12/13.
//  Copyright (c) 2013 Student. All rights reserved.
//

#import "Player.h"

// constants
static const float kImageScaleFactor = 0.5;
static NSString *const kImageFileName = @"character.png";



@implementation Player

- (id)initWithStartPoint: (CGPoint) point{

    self = [super initWithImageNamed:kImageFileName andScaleFactor:kImageScaleFactor];
    
    if (self) {
        self.name = @"player";
        self.physicsBody.categoryBitMask = ColliderTypePlayer;
        self.position = point;
    }
    return self;
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
