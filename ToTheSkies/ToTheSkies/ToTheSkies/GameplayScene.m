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
#import "SoundBuddy.h"


@implementation GameplayScene{
    //SKSpriteNode *player;
    Player *_player;
    
    //JetPack stuff
    CMMotionManager *_motionManager;
    
    //Pickups
    NSMutableArray *_pickupArray;
    NSMutableArray *_forRemoval;
    NSTimeInterval _timeSinceLastSpawn;
    NSDate *_timeLastSpawn;
    
    // Sound Buddy
    SoundBuddy* soundBuddy;
    
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
    self.physicsWorld.contactDelegate = self;
    _height = self.size.height;
    _width = self.size.width;
    _trampExists = false;
    _trampolineCollideTimer = 5;
    _trampolineStrength = 1.4;
    self.backgroundColor = [SKColor colorWithRed:0.68 green:0.85 blue:0.98 alpha:1.0]; // #AEDAF9
    
    
    //--------------Sound Buddy-----------//
    soundBuddy = [[SoundBuddy alloc] init];
    [soundBuddy setUp];
    [soundBuddy playBackgroundMusic];
    
    
    //--------------Player----------------//
    
    _player = [[Player alloc] initWithStartPoint:CGPointMake(self.view.center.x, 800)];
    
    
    // --------- PICKUPS --------//
    
    //Pickup *myPickup = [[Pickup alloc] initWithStartPoint:CGPointMake(self.view.center.x + 100, 800)];
    //myPickup.name = @"balloon";
    //[self addChild:myPickup];
    _forRemoval = [NSMutableArray array];
    _pickupArray = [NSMutableArray arrayWithCapacity:kPickupsOnScreenLimit];
    _timeLastSpawn = [NSDate date];
    _timeSinceLastSpawn = fabs([_timeLastSpawn timeIntervalSinceNow]);
    
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

// Performs any scene-specific updates that need to occur before scene actions are evaluated.
// UPDATE 0
- (void)update:(NSTimeInterval)currentTime{
    
    //----------- PICKUP REMOVAL ---------
    for (Pickup *p in _pickupArray){
        if (p.position.x < 0 || p.position.x > self.size.width || p.position.y < 0 || p.position.y > self.size.height){
            [_forRemoval addObject:p];
            NSLog(@"Pickup removed!"); 
        }
    }
    
    for (Pickup *p in _forRemoval){
        [_pickupArray removeObject:p];
    }
    
    [_forRemoval removeAllObjects];
    
    // ---------- PICKUP SPAWN -------------
    _timeSinceLastSpawn = fabs([_timeLastSpawn timeIntervalSinceNow]);
    
    if (_pickupArray.count < kPickupsOnScreenLimit && _timeSinceLastSpawn > 2.0){
        Pickup *tempPickup = [[Pickup alloc] initWithStartPoint:CGPointMake(arc4random()%700, kPickupsOnScreenLimit * 200)];
        _timeLastSpawn = [NSDate date]; // reset time last spawned to RIGHT NAO
        [_pickupArray addObject:tempPickup];
        [self addChild:tempPickup];
        NSLog(@"added pickup");
    }
    
    
    //NSLog(@"%.2f", _timeSinceLastSpawn);
    
    
} // end update



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
            //CGVector velocity = [_player getVelocity];
            CGVector velocity =_player.physicsBody.velocity; // #ZACH | There's a reason I made the player/GameObject inherit from SKSpriteNode :P
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
            
            
            [soundBuddy playJumpSound];
            _player.physicsBody.velocity = CGVectorMake(vx, vy);
        }
    }
    
    //Temporary debug stuff for Accelerometer.
    //CMAccelerometerData *data = _motionManager.accelerometerData;
    //NSLog(@"Accelerometer x: %f, y: %f, z: %f", data.acceleration.x, data.acceleration.y, data.acceleration.z);
    
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

// ---------- DEBUG Helper for array ---------




// --------------- General Collision Stuff ------------- //
- (void)didBeginContact:(SKPhysicsContact *)contact
{

    if (contact.bodyA.categoryBitMask == ColliderTypePlayer|| contact.bodyB.categoryBitMask == ColliderTypePlayer) { // if one of the bodies is the player
        if (contact.bodyA.categoryBitMask == ColliderTypePlayer){ // if it's bodyA
            [_player collide:(GameObject*)contact.bodyB.node withCategory:contact.bodyB.categoryBitMask]; //trigger collide with bodyB
            [_pickupArray removeObject:contact.bodyB.node];
            NSLog(@"Pickup count: %d", _pickupArray.count); 
        }
        else { // if it's bodyB
            [_player collide:(GameObject*)contact.bodyA.node withCategory:contact.bodyA.categoryBitMask]; // trigger collide wtih bodyA
            [_pickupArray removeObject:contact.bodyA.node];
        }
    } // end if
    
    // this is bad code but we will fix it for the next deliverable when we have more pickups implemented
    // we will ultimately be moving soundBuddy into the player
    if([contact.bodyB.node.name  isEqual: @"balloon"] || [contact.bodyA.node.name  isEqual: @"balloon"])
    {
        [soundBuddy playPopSound];
        
    }
    
    NSLog(@"Contact!");
    
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
