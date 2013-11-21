//
//  ObjectSpawner.m
//  ToTheSkies
//
//  Created by Student on 11/15/13.
//  Copyright (c) 2013 Student. All rights reserved.
//

#import "ObjectSpawner.h"

@implementation ObjectSpawner {
    NSTimeInterval _timeSinceLastSpawn;
    NSDate *_timeLastSpawn;
    
    int _maxItems;
    int _itemsOnScreen;
    double _spawnDelay;
}

// ------------- Init Method ---------------- //

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
} // end init



// ----------- Update layer ------------ //

-(void)update {
    _timeSinceLastSpawn = fabs([_timeLastSpawn timeIntervalSinceNow]);
    
    // spawn items
    if (_itemsOnScreen < _maxItems && _timeSinceLastSpawn > _spawnDelay){
        
        [_gameLayer addChild:[self spawn]];
        _timeLastSpawn = [NSDate date]; // reset time last spawned to RIGHT NAO
        _itemsOnScreen++;
    }
    // remove off-screen items
    [self despawn]; 

}

// ------------ Spawn ------------------- //

-(SKSpriteNode*)spawn{
    SKSpriteNode *tempSprite = [[SKSpriteNode alloc] init];
    return tempSprite;
}

// ------------ Despawn ------------- //
-(void)despawn{
    [self despawnWithName:@"genericItem"];
}

// ------------ Despawn With Name ------------ //

-(void)despawnWithName: (NSString*)nodeName{
    [_gameLayer enumerateChildNodesWithName:nodeName usingBlock: ^(SKNode *node, BOOL *stop) {
        if (node.position.x < 0 || node.position.x > _gameLayer.scene.size.width|| node.position.y < -((SKSpriteNode*)node).size.height){ // if item offscreen
            [node removeFromParent]; // remove item from scene
            _itemsOnScreen--;
        }
        else{
            [self moveNode:node];
        }
    }];
}

// --------------- moveNode --------------- //

-(void)moveNode:(SKNode *)node{
    [node setPosition:CGPointMake(node.position.x, node.position.y - 1)]; //move on-screen items
} // end move


@end
