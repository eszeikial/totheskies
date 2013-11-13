//
//  GameplayScene.m
//  ToTheSkies
//
//  Created by Student on 11/12/13.
//  Copyright (c) 2013 Student. All rights reserved.
//

#import "GameplayScene.h"
#import <SpriteKit/SpriteKit.h>
#import "Player.h"
#import "Pickup.h"


@implementation GameplayScene{
    //SKSpriteNode *player;
    Player *_player;
    SKPhysicsBody *playerBody;
    
    //Trampoline - drawing
    UITouch *_touch;
    SKShapeNode *trampoline;
    CGPoint _startPoint;
    CGPoint _endPoint;
    BOOL _trampExists;
    CGMutablePathRef _mutablePath;
    
    //Scene stuff
    float _height;
    float _width;
}


//Method is called when the scene is presented by a view.
-(void) didMoveToView:(SKView *)view
{
    //-------------Misc Setup-------------//
    [self.physicsWorld setGravity:CGVectorMake(0, -1.0)]; // #ZACH  this is to make things easier to test for collisions. Change it to something else if you like.
    _height = self.size.height;
    _width = self.size.width;
    _trampExists = false;
    self.backgroundColor = [SKColor colorWithRed:0.68 green:0.85 blue:0.98 alpha:1.0]; // #AEDAF9
    
    
    //--------------Player----------------//
    
    _player = [[Player alloc] initWithStartPoint:CGPointMake(self.view.center.x, 800)];
    
    // ----------- DEBUG -- PICKUPS --------//
    
    Pickup *myPickup = [[Pickup alloc] initWithStartPoint:CGPointMake(self.view.center.x + 100, 800)];
    [self addChild:myPickup]; 
    
    
    //-------------trampoline-------------//
    
    trampoline = [SKShapeNode node];
    trampoline.strokeColor = [SKColor colorWithWhite:1.0 alpha:1.0];
    trampoline.fillColor = [SKColor colorWithWhite:1.0 alpha:1.0];
    trampoline.lineWidth = (float)2.0;
    trampoline.name = @"trampoline";
    
    
    
    //-------------obstacles--------------//
    
    
    
    [self addChild:trampoline];
    [self addChild:_player];
}



//Preforms scene-specific updates after actions are evaluated.
//This is where we will check collisions that are non-rigidbody collisions
// UPDATE 1
-(void)didEvaluateActions
{
    
}



//Performs any scene-specific updates that need to occur after physics simulations are performed.
// UPDATE 2
-(void)didSimulatePhysics
{
    
}

// ---------------------TOUCHES------------------------ //


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for(UITouch *touch in touches){
        //Get the touch point.
        CGPoint touchPoint = [touch locationInView: self.view];
        
        //If there isnt a touch on screen currently...
        if(_touch == nil){
            _touch = touch; // Set it.
            _startPoint = CGPointMake(touchPoint.x, touchPoint.y);
        }
        
    }

}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // iterate through our touch elements
    for (UITouch *touch in touches){
        
        //only do stuff its the first touch.
        if(touch == _touch)
        {
            // get the point of touch within the view
            CGPoint touchPoint = [touch locationInView: self.view];
            _endPoint = CGPointMake(touchPoint.x, touchPoint.y);
            
            //Updating the mutable path
            _mutablePath = CGPathCreateMutable();
            CGPathMoveToPoint(_mutablePath, NULL, _startPoint.x, -_startPoint.y + _height);
            CGPathAddLineToPoint(_mutablePath, NULL, _endPoint.x, -_endPoint.y + _height);
            
            //Setting the path to the trampoline
            trampoline.path = CGPathCreateCopy(_mutablePath);
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    _trampExists = YES;
    trampoline.path = CGPathCreateCopy(_mutablePath);
    _touch = nil;
}



@end
