//
//  ViewController.h
//  Project1Proto
//
//  Created by Student on 10/9/13.
//  Copyright (c) 2013 Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreMotion/CoreMotion.h>
#import "LineDraw.h"
#import "SoundBuddy.h"

const int kNumClouds = 5;
const int kMaxHeight = 800;

@interface ViewController : UIViewController <UIAlertViewDelegate>


@property (weak, nonatomic) IBOutlet UIView *Ball;
@property (nonatomic, assign) id<UIAccelerometerDelegate> accelDelegate;
@property (weak, nonatomic) IBOutlet UILabel *ScoreLabel;


//For now has no parameters. will need some later.
-(void)trampCollide:(float)wSlope wallSize:(float)wSize distFromCenter:(float)distCenter;
-(float)getRemainingInfluence;
@end
