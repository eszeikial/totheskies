//
//  PickupSpawner.m
//  ToTheSkies
//
//  Created by Student on 11/15/13.
//  Copyright (c) 2013 Student. All rights reserved.
//

#import "PickupSpawner.h"
#import "Pickup.h"
#import <SpriteKit/SpriteKit.h>

@implementation PickupSpawner

-(Pickup*)spawn{
    Pickup *tempPickup = [[Pickup alloc] initWithStartPoint:CGPointMake(randInRange(0, self.gameLayer.scene.size.width), self.gameLayer.scene.size.height + 20)]; // spawn pickup
    return tempPickup;
}

-(void)despawn{
    [self despawnWithName:@"pickup"];
}


@end
