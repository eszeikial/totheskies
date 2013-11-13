//
//  GameObject.h
//  ToTheSkies
//
//  Created by Student on 11/13/13.
//  Copyright (c) 2013 Student. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameObject : SKSpriteNode

- (id)initWithStartPoint: (CGPoint) point;
- (id)initWithImageNamed:(NSString *)name andScaleFactor:(float)scaleFactor;
- (id)initWithColor:(UIColor *)color size:(CGSize)size;

@end
