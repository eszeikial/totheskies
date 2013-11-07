//
//  LineDraw.h
//  Project1Proto
//
//  Created by Student on 10/10/13.
//  Copyright (c) 2013 Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <math.h>
#import "ViewController.h"

@interface LineDraw : UIView

struct point
{
    float x;
    float y;
};

struct trampoline
{
    struct point pt1;
    struct point pt2;
    struct point controlPt;
};

//Special init method
-(id)initWithFrameAndParentVC:(CGRect)frame parentVC:(UIViewController*)pVC;

-(void)redraw;
-(void)endDraw;
-(void)addPoints:(int)x yPoint:(int)y;
-(void)drawRect:(CGRect)rect;
-(void)getBallLoc:(float)x yPoint:(float)y;
-(void)sendScore:(float)score;

@end
