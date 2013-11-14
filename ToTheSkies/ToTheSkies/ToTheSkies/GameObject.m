//
//  GameObject.m
//  ToTheSkies
//
//  Created by Student on 11/13/13.
//  Copyright (c) 2013 Student. All rights reserved.
//

#import "GameObject.h"

@implementation GameObject{
    
    SKPhysicsBody *_spriteBody;
}

- (id)initWithStartPoint: (CGPoint) point{
    
    //self = [super init];
    self = [super initWithColor:[SKColor colorWithRed:0.0 green:.7 blue:.3 alpha:1.0] size:CGSizeMake(20, 20)];
    
    if (self) {
        _spriteBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(20, 20)];
        
        self.physicsBody = _spriteBody; // point property to reference
        
        self.position = point;
        // initialize instance variables here
    }
    return self;
}

- (id)initWithColor:(UIColor *)color size:(CGSize)size{
    
    //self = [super init];
    self = [super initWithColor:color size:size];
    
    if (self) {
        _spriteBody = [SKPhysicsBody bodyWithRectangleOfSize:size];
        
        self.physicsBody = _spriteBody; // point property to reference
        // initialize instance variables here
    }
    return self;
}


- (id)initWithImageNamed:(NSString *)name andScaleFactor:(float)scaleFactor{
    
    self = [super initWithImageNamed:name];
    
    if (self) {
        [self setSize:CGSizeMake(self.size.width * scaleFactor, self.size.height * scaleFactor)]; // scale everything
        _spriteBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size]; // make new physics body
        
        self.physicsBody = _spriteBody; // point property to reference
    }
    return self;
}



@end
