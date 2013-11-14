//
//  GameObject.h
//  ToTheSkies
//
//  Created by Student on 11/13/13.
//  Copyright (c) 2013 Student. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef enum : uint8_t {
    ColliderTypePlayer = 0x1 << 0,
    ColliderTypeWall = 0x1 << 1,
    ColliderTypeTrampoline = 0x1 << 2,
    ColliderTypePickup = 0x1 << 3,
    ColliderTypeObstacle = 0x1 << 4
} ColliderType;


@interface GameObject : SKSpriteNode

- (id)initWithStartPoint: (CGPoint) point;
- (id)initWithImageNamed:(NSString *)name andScaleFactor:(float)scaleFactor;
- (id)initWithColor:(UIColor *)color size:(CGSize)size;

@end
