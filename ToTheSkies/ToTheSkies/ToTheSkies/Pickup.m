//
//  Pickup.m  // extends GameObject
//  ToTheSkies
//
//  Created by Student on 11/12/13.
//  Copyright (c) 2013 Student. All rights reserved.
//

#import "Pickup.h"

@implementation Pickup

- (id)initWithStartPoint: (CGPoint) point{
    
    self = [super initWithColor:[SKColor colorWithRed:0.0 green:.7 blue:.3 alpha:1.0] size:CGSizeMake(20, 20)];
    
    if (self) {
        self.name = @"pickup";
        self.position = point;
    }
    return self;
}

@end
