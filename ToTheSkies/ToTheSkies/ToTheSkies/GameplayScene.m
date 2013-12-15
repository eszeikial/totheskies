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
#import "CloudSpawner.h"
#import "PickupSpawner.h"
#import "ObstacleSpawner.h"
#import "Helper.h"


@implementation GameplayScene{

    // scene layers
    SKNode *_gameplayLayer;
    SKNode *_backgroundLayer;
    
    // clouds
    CloudSpawner *_cloudSpawner;
    
    // obstacles
    ObstacleSpawner *_smogSpawner;
    ObstacleSpawner *_planeSpawner;
    
    // player
    Player *_player;
    CGPoint _playerStartPoint;
    CGVector _playerStartVelocity;
    
    //JetPack stuff
    CMMotionManager *_motionManager;
    
    //Pickups
    PickupSpawner *_pickupSpawner;
    
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
    
    SKSpriteNode *_drawBox;
    
    // Scene stuff
    float _height;
    float _width;
    
    // Scoring
    SKLabelNode* _highScoreLabel;
    SKLabelNode* _scoreLabel;
    float _score;
    int _highScore;
    
    BOOL _paused;
}

//Method is called when the scene is presented by a view.
-(void) didMoveToView:(SKView *)view
{
    // -------------- layers --------------- //
    _gameplayLayer = [[SKNode alloc]init];
    _backgroundLayer = [[SKNode alloc]init];
    
    _gameplayLayer.zPosition = 0;
    _gameplayLayer.zPosition = 1;
    
    //-------------Misc Setup-------------//
    [self.physicsWorld setGravity:CGVectorMake(0, -1.0)]; // #ZACH  this is to make things easier to test for collisions. Change it to something else if you like.
    
    self.physicsWorld.contactDelegate = self;
    _height = self.size.height;
    _width = self.size.width;
    _trampExists = false;
    _trampolineCollideTimer = 5;
    _trampolineStrength = 1.4;
    _score = 0;
    self.backgroundColor = [SKColor colorWithRed:0.68 green:0.85 blue:0.98 alpha:1.0]; // #AEDAF9
    
    // add layers
    [self addChild:_gameplayLayer];
    [self addChild:_backgroundLayer];
    
    // by default, not paused

    
    //--------------Sound Buddy-----------//
    soundBuddy = [[SoundBuddy alloc] init];
    [soundBuddy setUp];
    [soundBuddy playBackgroundMusic];
    
    //--------------Player----------------//
    _playerStartPoint = CGPointMake(self.view.center.x, 800);
    _player = [[Player alloc] initWithStartPoint:_playerStartPoint];
    _player.physicsBody.allowsRotation = NO;
    _playerStartVelocity = _player.physicsBody.velocity;
    
    // --------- PICKUPS --------//
    
    _pickupSpawner = [[PickupSpawner alloc] initWithLayer:_gameplayLayer maxItemsOnScreen:kMaxPickupsOnScreen delay:kPickupSpawnDelay];
    _smogSpawner = [[ObstacleSpawner alloc] initWithObstacleType:ObstacleTypeSmog Layer:_gameplayLayer maxItemsOnScreen:kMaxCloudsOnScreen / 4 delay:kCloudSpawnDelay * 4];
    _planeSpawner = [[ObstacleSpawner alloc] initWithObstacleType:ObstacleTypePlane Layer:_gameplayLayer maxItemsOnScreen:1 delay:kCloudSpawnDelay * 4];
    
    //-------------trampoline-------------//
    
    _trampoline = [SKShapeNode node];
    _trampoline.strokeColor = [SKColor colorWithWhite:1.0 alpha:1.0];
    _trampoline.fillColor = [SKColor colorWithWhite:1.0 alpha:1.0];
    _trampoline.lineWidth = (float)2.0;
    _trampoline.name = @"trampoline";
    
    _drawBox = [[SKSpriteNode alloc]initWithImageNamed:@"drawZone.png"];
    _drawBox.position = CGPointMake(_width/2, 200);
    [self addChild:_drawBox];
    [self displayTouchBox];
    
    //---------JetPack/CoreMotion---------//
    
    _motionManager = [[CMMotionManager alloc] init];
    _motionManager.accelerometerUpdateInterval = .2;
    
    [_motionManager startAccelerometerUpdates];
    
    //-------------obstacles--------------//
    
    
    
    // ------------- clouds ------------ //
    _cloudSpawner = [[CloudSpawner alloc] initWithLayer:_backgroundLayer maxItemsOnScreen:kMaxCloudsOnScreen delay:kCloudSpawnDelay];
    
    
    // ------------- add stuff to layers -------------- //
    
    [_gameplayLayer addChild:_trampoline];
    [_gameplayLayer addChild:_player];
    
    // add our text labels
    [self createTextNodes];
    
    // starts off unpaused
    _paused = NO;
}

// Performs any scene-specific updates that need to occur before scene actions are evaluated.
// UPDATE 0
- (void)update:(NSTimeInterval)currentTime
{
    if(!_paused)
    {
        [_cloudSpawner update];
        [_pickupSpawner update];
        [_smogSpawner update];
        [_planeSpawner update]; 
        
        // update the score label
        if(_player.position.y >= _height/2 && _player.physicsBody.velocity.dy > 0)
        {
            [self updateScore:(_player.physicsBody.velocity.dy / 2000.0)];
        }
        
        // check if player went off the screen
        if(_player.position.y < 0)
        {

            
            [self endGame];
        }
    }
} // end update

-(void)updateScore: (float) points
{
    _score += points;
    [self updateScoreLabel];
}

-(void)updateScoreLabel
{
    _scoreLabel.text = [[NSString alloc]initWithFormat:@"Score: %i", (int)_score];
    
    if((int)_score > _highScore)
    {
        _highScore = (int)_score;
        _highScoreLabel.text = [[NSString alloc]initWithFormat:@"High Score: %i", (int)_highScore];
    }
}


-(void)createTextNodes{
	// player score text node
    _scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Noteworthy"];
    
    _scoreLabel.name = @"scoreNode";
    _scoreLabel.text = @"Score: 0";
    _scoreLabel.fontSize = 32.0;
    CGPoint textPosition = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height -50.0);
    
    _scoreLabel.position = textPosition;
    [self addChild: _scoreLabel];
    
    // High Score text node
     _highScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Noteworthy"];
     _highScoreLabel.name = @"highScoreNode";
     
     // grab high score from NSUserDefaults if it has been set
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
     _highScore = [defaults integerForKey:@"highScoreKey"];
     _highScoreLabel.text = [NSString stringWithFormat:@"High Score: %d", _highScore];
     
     _highScoreLabel.fontSize = 32.0;
     _highScoreLabel.fontColor = [UIColor whiteColor];
     _highScoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
     
     textPosition = CGPointMake(10, self.frame.size.height -50.0);
     _highScoreLabel.position = textPosition;
     [self addChild: _highScoreLabel];
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
    
    cPoint startPoint = {(float)(_startPoint.x), (float)(_startPoint.y)};
    cPoint endPoint = {(float)(_endPoint.x), (float)(_endPoint.y)};
    cPoint playerPosition = {(float)(_player.position.x), (float)(_player.position.y)};
    float distance = calcDistance(startPoint, endPoint, playerPosition, _height);
    
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

//-------------- Helper Method for touch box --------------//
-(void)displayTouchBox
{
    [_drawBox removeAllActions];
    SKAction *startFaded = [SKAction fadeOutWithDuration:0];
    SKAction *fadeIn = [SKAction fadeInWithDuration:1];
    SKAction *fadeOut = [SKAction fadeOutWithDuration:1];
    
    SKAction *sequence = [SKAction sequence:@[startFaded,fadeIn,fadeOut,fadeIn,fadeOut]];
    [_drawBox runAction:sequence];
}


// --------------- General Collision Stuff ------------- //
- (void)didBeginContact:(SKPhysicsContact *)contact
{

    GameObject *playerGameObj;
    GameObject *objectGameObj;
    
    // check to see which body is the player, and which is the object he's in contact with
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask){
        playerGameObj = (GameObject*)contact.bodyA.node;
        objectGameObj = (GameObject*)contact.bodyB.node;
    }
    else {
        playerGameObj = (GameObject*)contact.bodyB.node;
        objectGameObj = (GameObject*)contact.bodyA.node;
    }
    
    [_player collide:objectGameObj];
    
    if([objectGameObj isKindOfClass:[Pickup class]])
    {
        [_pickupSpawner itemHit]; // So the spawner can keep track of objects on screen.
    }
    
    
    
    // this is bad code but we will fix it for the next deliverable when we have more pickups implemented
    // we will ultimately be moving soundBuddy into the player
    if([objectGameObj.name isEqual: @"pickup"])
    {
        [soundBuddy playPopSound];
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
            
            //Out of touch box!
            if(1024 - touchPoint.y > 400)
            {
                //Show draw box.
                [self displayTouchBox];
                _touch = Nil;
            }
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //If both the start and end point were in the drawing box...
    if(1024 - _endPoint.y < 400 && 1024 - _startPoint.y < 400)
    {
        _trampExists = YES;
        _trampoline.path = CGPathCreateCopy(_mutablePath);
    }
    else
    {
        _trampExists = NO;
        _trampoline.path = NULL;
    }
    
    _touch = nil;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self reset];
}

-(void)pause
{
    self.view.paused = YES;
    _paused = YES;
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger: _highScore forKey: @"highScoreKey"];
    [defaults synchronize];
}

-(void)reset
{
    _score = 0;
    _player.position = _playerStartPoint;
    _player.physicsBody.velocity = _playerStartVelocity;
    [self updateScoreLabel];
    [self resume];
}

-(void)resume
{
    self.view.paused = NO;
    _paused = NO;
}


-(void)endGame{
    
    [self pause];
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle: @"Game Over"
                                                    message: @"Play again?"
                                                   delegate: self
                                          cancelButtonTitle: @"OK"
                                          otherButtonTitles: nil];
    [alert show];
}

@end
