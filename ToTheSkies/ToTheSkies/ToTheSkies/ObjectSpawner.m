//
//  ObjectSpawner.m
//  ToTheSkies
//
//  Created by Student on 11/15/13.
//  Copyright (c) 2013 Student. All rights reserved.
//
// This class can be used to spawn objects and is the base class for the obstacle spawner and pickup spawner

#import "ObjectSpawner.h"

@implementation ObjectSpawner {
    NSTimeInterval _timeSinceLastSpawn;
    NSDate *_timeLastSpawn;
    
    int _maxItems;
    int _itemsOnScreen;
    double _spawnDelay;
}

// Initializer
- (id)initWithLayer: (SKNode*)layer
   maxItemsOnScreen: (int) maxItems
              delay: (double) spawnDelay {
    
    self = [super init];
    
    if (self) {
        // init iVars
        _gameLayer = layer;
        _maxItems = maxItems;
        _itemsOnScreen = 0;
        _spawnDelay = spawnDelay;
        _timeLastSpawn = [NSDate date];
        _timeSinceLastSpawn = fabs([_timeLastSpawn timeIntervalSinceNow]);
        
    } // end if
    
    return self;
}


// Update by spawning new objects if necessary and remove lost objects
-(void)update {
    _timeSinceLastSpawn = fabs([_timeLastSpawn timeIntervalSinceNow]);
    
    // spawn items
    if (_itemsOnScreen < _maxItems && _timeSinceLastSpawn > _spawnDelay){
        
        SKSpriteNode* newChild = [self spawn];
        
        [_gameLayer addChild:newChild];
        _timeLastSpawn = [NSDate date]; // reset time last spawned to RIGHT NAO
        _itemsOnScreen++;
    }
    // remove and move off-screen items
    [self despawn]; 

}

// Spawn an object
-(SKSpriteNode*)spawn{
    SKSpriteNode *tempSprite = [[SKSpriteNode alloc] init];
    return tempSprite;
}

// Despawn an object using a generic name
-(void)despawn{
    [self despawnWithName:@"genericItem"];
}

// Despawn an object using its name
-(void)despawnWithName: (NSString*)nodeName{
    [_gameLayer enumerateChildNodesWithName:nodeName usingBlock: ^(SKNode *node, BOOL *stop) {
        if (node.position.x  < -((SKSpriteNode*)node).size.width || node.position.x > _gameLayer.scene.size.width +((SKSpriteNode*)node).size.width || node.position.y < -((SKSpriteNode*)node).size.height){ // if item offscreen
            [node removeFromParent]; // remove item from scene
            _itemsOnScreen--;
        }
        else{
            //NSLog(@"My name is %@", nodeName);
            [self moveNode:node];
        }
    }];
}


// Object lost to collision
-(void)itemHit
{
    _itemsOnScreen--;
}

// Move a specfic node
-(void)moveNode:(SKNode *)node{
    [node setPosition:CGPointMake(node.position.x, node.position.y - 1)]; //move on-screen items
}


@end
