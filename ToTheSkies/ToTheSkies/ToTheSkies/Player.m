//
//  Player.m
//  ToTheSkies
//
//  Created by Student on 11/12/13.
//  Copyright (c) 2013 Student. All rights reserved.
//

#import "Player.h"

@implementation Player{
    SKPhysicsBody *_spriteBody;
}


- (id)initWithStartPoint: (CGPoint) point{
    
    //self = [super init];
    self = [super initWithColor:[SKColor colorWithRed:.6 green:.1 blue:.1 alpha:1.0] size:CGSizeMake(20, 20)];
    
    if (self) {
        _spriteBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(20, 20)];
        
        self.physicsBody = _spriteBody; // point property to reference
        
        self.name = @"player";
        self.position = point;
        // initialize instance variables here
    }
    return self;
}

@end
