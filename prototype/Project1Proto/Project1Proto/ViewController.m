//
//  ViewController.m
//  Project1Proto
//
//  Created by Student on 10/9/13.
//  Copyright (c) 2013 Student. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end


@implementation ViewController{
    CADisplayLink *_timer;
    UITouch *_touch;
    float _vx;
    float _vy;
    float _ax;
    float _ay;
    float _lastX;
    float _lastY;
    float _screenWidth;
    float _screenHeight;
    CGRect dummyRect;
    LineDraw *ld;
    float _influence;
    CGPoint _startPos;
    
    UIImageView *cloudArray[kNumClouds];
    
    float _moveSpeed;
    float _score;
    
    SoundBuddy *sb;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    UIAccelerometer *accel = [UIAccelerometer sharedAccelerometer];
    accel.delegate = self;
    accel.updateInterval = 1.0f/30.0f; // 30 updates per second?
    _ay = .15;
    _influence = 25;
    _screenHeight = self.view.bounds.size.height;
    _screenWidth = self.view.bounds.size.width;
    
    _moveSpeed = 1.0;
    _startPos = self.Ball.center;
    
    sb = [[SoundBuddy alloc]init];
    [sb setUp];
    
    for (int i = 0; i < kNumClouds; i++) {
        cloudArray[i] = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cloud.png"]];
        cloudArray[i].center = CGPointMake(arc4random()%700, i*200);
        [self.view addSubview:cloudArray[i]];
    }
    
    dummyRect = CGRectMake(0, 0, _screenWidth, _screenHeight);
    
    ld = [[LineDraw alloc]initWithFrameAndParentVC:dummyRect parentVC:self];
    [self.view addSubview:ld];
    
    [self start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)start{
    if(_timer == nil)
    {
        _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(animate)];
        [_timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
    [sb playBackgroundMusic];
}

-(void)startAgain{
    if(_timer == nil)
    {
        _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(animate)];
        [_timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
}

-(void)startOver
{
    if(_timer == nil)
    {
        _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(animate)];
        [_timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
    _score = 0;
    _influence = 25;
    self.Ball.center = _startPos;
    _vx = 0;
    _vy = 0;
}

-(float)getRemainingInfluence
{
    return _influence;
}

-(void)accelerometer:(UIAccelerometer *)acel didAccelerate:(UIAcceleration *)acceleration{
    _ax = acceleration.x;
    //Dont use accelerometer if the rotation is minimal
    if(_ax >= -.1 && _ax <= .1)
    {
        _ax = 0;
    }
    
    _influence -= fabsf(_ax);
    
    if(_influence <= 0)
    {
        _influence = 0;
        _ax = 0;
    }
    
    //only redraw if influence was used.w
    if (_influence != 0) {
        [ld redraw];
    }
    
    //_ay = -acceleration.y;
    /*
    NSLog(@"x: %g", acceleration.x);
    NSLog(@"y: %g", acceleration.y);
    NSLog(@"");
    NSLog(@"z: %g", acceleration.z);
    */
}

-(void)animate{

   // NSLog(@"Animate called!");
    
    //Adjust velocity.
    _vx += _ax;
    _vy += _ay;
    
    _ScoreLabel.text = [[NSString alloc]initWithFormat:@"%i",(int)_score];
    
    //If the ball is higher up, movespeed increases.
    if(self.Ball.center.y < 400 )
    {
        float ballHeightAboveLine = -(self.Ball.center.y-400);
        _moveSpeed = ballHeightAboveLine/100;
    }
    else{
        _moveSpeed = 1;
    }
    
    //Move the clouds.
    for (int i = 0; i<kNumClouds; i++) {
        float point = cloudArray[i].center.y;
        point +=_moveSpeed;
        if(point > _screenHeight+75)
        {
            point -= 1100;
            cloudArray[i].center = CGPointMake(arc4random()%700, point);
        }
        else{
            cloudArray[i].center = CGPointMake(cloudArray[i].center.x,point);
        }
    }
    
    //make local values.
    float x = self.Ball.center.x + _vx;
    float y = self.Ball.center.y + _vy + _moveSpeed;
    _score += _moveSpeed;
    
    [ld sendScore:_score];
    
    self.Ball.center = CGPointMake(x, y);
    
    //Keep track of last position.
    _lastX = x;
    _lastY = y;
    
    if(x > _screenWidth)_vx = -_vx;
    else if(x < 0)_vx = -_vx;
    
    if(y > _screenHeight)
    {
        [self gameOver];
    }
    
    [ld getBallLoc:x yPoint:y];
}

- (void)pauseGame
{
    [_timer invalidate];
    _timer = nil;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Paused" message:@"Click to resume game" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
    [alert show];
}

-(void)gameOver
{
    [_timer invalidate];
    _timer = nil;
    NSString *scoreString = [[NSString alloc]initWithFormat:@"You scored %f points!",_score ];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Game Over!" message:scoreString delegate:self cancelButtonTitle:@"Play Again?" otherButtonTitles:nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Close"])
    {
        [self startAgain];
    }
    else if([title isEqualToString:@"Play Again?"])
    {
        [self startOver];
    }
    
}
-(void)trampCollide:(float)wSlope wallSize:(float)wSize distFromCenter:(float)distCenter
{
    [sb playJumpSound];
    
    //250 is the max distance from the wall. (because of max wall size.)
    //Sorry about the magic numbahs!
    float _velocityMod = ((250-distCenter)/150);
    
    //Get total velocity.
    float _totalVelocity = sqrtf(_vx*_vx + _vy*_vy);
    _totalVelocity *= _velocityMod;
    
    if(wSlope < 0)
    {
        wSlope = -wSlope;
        
        _vx = -_totalVelocity*wSlope;
        _vy = -_totalVelocity*(1-wSlope);
    }
    else{
        _vx = _totalVelocity*wSlope;
        _vy = -_totalVelocity*(1-wSlope);
    }
}

//---------------------------------------TOUCHES---------------------------------------//

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //For each touch...
    for(UITouch *touch in touches){
        //Get the touch point.
        CGPoint touchPoint = [touch locationInView: self.view];
        
        //If there isnt a touch on screen currently...
        if(_touch == nil){
            _touch = touch; // Set it.
            [ld addPoints:touchPoint.x yPoint:touchPoint.y];
            
            if(touchPoint.x <= 80 && touchPoint.y >= 920)
            {
                [self pauseGame];
            }
        }

    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    // iterate through our touch elements
    for (UITouch *touch in touches){
        
        //only do stuff its the first touch.
        if(touch == _touch)
        {
            // get the point of touch within the view
            CGPoint touchPoint = [touch locationInView: self.view];
            [ld addPoints:touchPoint.x yPoint:touchPoint.y];
            
        }
    }
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    _touch = nil;
    [ld endDraw];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [self touchesEnded:touches withEvent:event];
}

@end
