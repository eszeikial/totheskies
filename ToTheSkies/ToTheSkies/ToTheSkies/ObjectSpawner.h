//
//  ObjectSpawner.h
//  ToTheSkies
//
//  Created by Student on 11/15/13.
//  Copyright (c) 2013 Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>


@interface ObjectSpawner : NSObject

@property (strong,nonatomic) SKNode *gameLayer;

- (id)initWithLayer: (SKNode*)layer
   maxItemsOnScreen: (int) maxItems
              delay: (double) spawnDelay;

- (void)update; 
-(SKSpriteNode*)spawn;
-(void)despawn;
-(void)despawnWithName: (NSString*)nodeName;
-(void)moveNode: (SKNode*)node;
-(void)itemHit;

@end
