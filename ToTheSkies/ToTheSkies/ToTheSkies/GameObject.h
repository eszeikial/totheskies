//
//  GameObject.h
//  ToTheSkies
//
//  Created by Student on 11/13/13.
//  Copyright (c) 2013 Student. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef enum : uint8_t {
    ColliderTypePlayer = 1,
    ColliderTypeWall = 2,
    ColliderTypeTrampoline = 4,
    ColliderTypePickup = 8,
    ColliderTypeObstacle = 16
} ColliderType;


@interface GameObject : SKSpriteNode

- (id)initWithStartPoint: (CGPoint) point;
- (id)initWithImageNamed:(NSString *)name andScaleFactor:(float)scaleFactor;
- (id)initWithColor:(UIColor *)color size:(CGSize)size;

@end
