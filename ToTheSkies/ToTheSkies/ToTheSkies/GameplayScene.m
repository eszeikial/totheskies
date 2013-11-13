//
//  GameplayScene.m
//  ToTheSkies
//
//  Created by Student on 11/12/13.
//  Copyright (c) 2013 Student. All rights reserved.
//


#import <SpriteKit/SpriteKit.h>
#import <UIKit/UIKit.h> // not 100% sure if we need this.
#import <CoreMotion/CoreMotion.h>

#import "GameplayScene.h"
#import "Player.h"
#import "Pickup.h"


@implementation GameplayScene{
    //SKSpriteNode *player;
    Player *_player;
    SKPhysicsBody *_playerBody;
    
    //JetPack stuff
    CMMotionManager *_motionManager;
    
    
    //Trampoline - drawing
    UITouch *_touch;
    SKShapeNode *_trampoline;
    CGPoint _startPoint;
    CGPoint _endPoint;
    BOOL _trampExists;
    CGMutablePathRef _mutablePath;
    int _trampolineCollideTimer;
    float _trampolineStrength;
    
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
    _trampolineCollideTimer = 5;
    _trampolineStrength = 1.4;
    self.backgroundColor = [SKColor colorWithRed:0.68 green:0.85 blue:0.98 alpha:1.0]; // #AEDAF9
    
    
    //--------------Player----------------//
    
    _player = [[Player alloc] initWithStartPoint:CGPointMake(self.view.center.x, 800)];
    
    
    // --------- DEBUG -- PICKUPS --------//
    
    Pickup *myPickup = [[Pickup alloc] initWithStartPoint:CGPointMake(self.view.center.x + 100, 800)];
    [self addChild:myPickup]; 
    
    
    //-------------trampoline-------------//
    
    _trampoline = [SKShapeNode node];
    _trampoline.strokeColor = [SKColor colorWithWhite:1.0 alpha:1.0];
    _trampoline.fillColor = [SKColor colorWithWhite:1.0 alpha:1.0];
    _trampoline.lineWidth = (float)2.0;
    _trampoline.name = @"trampoline";
    
    //---------JetPack/CoreMotion---------//
    
    _motionManager = [[CMMotionManager alloc] init];
    _motionManager.accelerometerUpdateInterval = .2;
    
    [_motionManager startAccelerometerUpdates];
    
    //-------------obstacles--------------//
    
    
    
    [self addChild:_trampoline];
    [self addChild:_player];
}


//Preforms scene-specific updates after actions are evaluated.
//This is where we will check collisions that are non-rigidbody collisions
// UPDATE 1
-(void)didEvaluateActions
{
    
    //NSLog(@"tramp Pt1 x: %f , y: %f, Player Pos x: %f, y: %f",_startPoint.x,_startPoint.y,_player.position.x, -_player.position.y+_height);
    
    //If there hasn't been a collision in 5 frames
    if(_trampolineCollideTimer == 0)
    {
        if([self checkTrampolineCollision])
        {
            NSLog(@"Collision with tramp should occur");
            //Getting values from player.
            CGVector velocity = [_player getVelocity];
            float vx = velocity.dx;
            float vy = velocity.dy;
            
            //Making necessary calculations.
            float totalVelocity = sqrtf(vx*vx + vy*vy)*_trampolineStrength;
            float wallSlope = (_endPoint.y-_startPoint.y)/(_endPoint.x-_startPoint.x);
            
            
            if(wallSlope < 0)
            {
                wallSlope = -wallSlope;
                
                vx = -totalVelocity*wallSlope;
                vy = totalVelocity*(1-wallSlope);
            }
            else
            {
                vx = totalVelocity*wallSlope;
                vy = totalVelocity*(1-wallSlope);
            }
            
            _player.physicsBody.velocity = CGVectorMake(vx, vy);
        }
    }
    
    //Temporary debug stuff for Accelerometer.
    CMAccelerometerData *data = _motionManager.accelerometerData;
    NSLog(@"Accelerometer x: %f, y: %f, z: %f", data.acceleration.x, data.acceleration.y, data.acceleration.z);
    
    //Trampoline timer decrements towards 0 every frame.
    _trampolineCollideTimer--;
    if(_trampolineCollideTimer < 0)
        _trampolineCollideTimer = 0;
}



//Performs any scene-specific updates that need to occur after physics simulations are performed.
// UPDATE 2
-(void)didSimulatePhysics
{
    [self screenWrap];
}


//Helper method to wrap screen if necessary.
-(void)screenWrap
{
    if(_player.position.x > _width + 20)
        _player.position = CGPointMake(-20, _player.position.y);
    else if (_player.position.x < -20)
        _player.position = CGPointMake(_width+20, _player.position.y);
}

//Helper method to segment out trampoline collision code.
-(BOOL)checkTrampolineCollision
{
    //Don't bother checking anything if the trampoline isn't created.
    if(!_trampExists)
        return NO;
    
    
    /* Getting general form from two points.
     a = y1-y2,
     b = x2-x1,
     c = (x1-x2)*y1 + (y2-y1)*x1
     */
    
    float a = _startPoint.y - _endPoint.y;
    float b = _endPoint.x - _startPoint.x;
    float c = (_startPoint.x-_endPoint.x)* _startPoint.y + (_endPoint.y-_startPoint.y) * _startPoint.x;
    
    float x = _player.position.x;
    float y = -_player.position.y+_height;
    
    
    // Using general form to calculate distance
    float distance = (fabsf(a*x+b*y+c))/(sqrtf(a*a+b*b));
    
    //Pretty close.
    if(distance < 30)
    {
        _trampolineCollideTimer = 5; // Prevents multiple collisions
        _trampExists = false; // Gets rid of trampoline after it has been collided with.
        _trampoline.path = NULL;
        return YES;
    }
    else
    {
        return NO;
    }
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
            _trampExists = NO;
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
            _trampoline.path = CGPathCreateCopy(_mutablePath);
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    _trampExists = YES;
    _trampoline.path = CGPathCreateCopy(_mutablePath);
    _touch = nil;
}



@end
