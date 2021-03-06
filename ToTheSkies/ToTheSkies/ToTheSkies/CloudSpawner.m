//
//  CloudSpawner.m
//  ToTheSkies
//
//  Created by Student on 11/15/13.
//  Copyright (c) 2013 Student. All rights reserved.
//
//  An object spawner specifically for clouds

#import "Helper.h"
#import "CloudSpawner.h"

@implementation CloudSpawner

// Spawn a new cloud
-(SKSpriteNode*)spawn{
    SKSpriteNode *newCloud = [[SKSpriteNode alloc]initWithImageNamed:@"cloud.png"];
    newCloud.position = CGPointMake(randInRange(0, self.gameLayer.scene.size.width), self.gameLayer.scene.size.height + newCloud.size.height);
    newCloud.name = @"cloud";
    return newCloud;
}

// Despawn the clouds
-(void)despawn{
    [self despawnWithName:@"cloud"];
}

@end
