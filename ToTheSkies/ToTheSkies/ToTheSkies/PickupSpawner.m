//
//  PickupSpawner.m
//  ToTheSkies
//
//  Created by Student on 11/15/13.
//  Copyright (c) 2013 Student. All rights reserved.
//
//  An object spawner specifically for pick ups

#import "PickupSpawner.h"
#import "Pickup.h"
#import <SpriteKit/SpriteKit.h>

@implementation PickupSpawner

// Spawn a pick up
-(Pickup*)spawn{
    Pickup *tempPickup = [[Pickup alloc] initWithStartPoint:CGPointMake(randInRange(0, self.gameLayer.scene.size.width), self.gameLayer.scene.size.height + 20)]; // spawn pickup
    return tempPickup;
}

// Despawn the pickups
-(void)despawn{
    [self despawnWithName:@"pickup"];
}


@end
