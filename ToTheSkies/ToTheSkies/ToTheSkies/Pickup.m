//
//  Pickup.m
//  ToTheSkies
//
//  Created by Student on 11/12/13.
//  Copyright (c) 2013 Student. All rights reserved.
//

#import "Pickup.h"

@implementation Pickup {
    SKPhysicsBody *_spriteBody;
}

- (id)initWithStartPoint: (CGPoint) point{
    
    //self = [super init];
    self = [super initWithColor:[SKColor colorWithRed:0.0 green:.7 blue:.3 alpha:1.0] size:CGSizeMake(20, 20)];
    
    if (self) {
        _spriteBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(20, 20)];
        
        self.physicsBody = _spriteBody; // point property to reference
        
        self.name = @"pickup";
        self.position = point;
        // initialize instance variables here
    }
    return self;
}

@end
