//
//  GameObject.h
//  ToTheSkies
//
//  Created by Student on 11/13/13.
//  Copyright (c) 2013 Student. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef enum : uint32_t{
    CategoryPlayerMask = 0x1 << 0,
    CategoryPickupMask = 0x1 << 1,
    CategoryObstacleMask = 0x1 << 2,
    CategorySmogMask = 0x1 << 3,
    CategoryKillMask = 0x1 << 4
} CategoryMask;


@interface GameObject : SKSpriteNode

- (id)initWithStartPoint: (CGPoint) point;
- (id)initWithImageNamed:(NSString *)name andScaleFactor:(float)scaleFactor;
- (id)initWithColor:(UIColor *)color size:(CGSize)size;

@end
