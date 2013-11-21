//
//  GameObject.h
//  ToTheSkies
//
//  Created by Student on 11/13/13.
//  Copyright (c) 2013 Student. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef enum : uint8_t{
    CategoryPlayerMask = 1,
    CategoryPickupMask = 2,
    CategoryObstacleMask = 3,
    CategoryTrampolineMask = 4,
} CategoryMask;


@interface GameObject : SKSpriteNode

- (id)initWithStartPoint: (CGPoint) point;
- (id)initWithImageNamed:(NSString *)name andScaleFactor:(float)scaleFactor;
- (id)initWithColor:(UIColor *)color size:(CGSize)size;

@end
