//
//  LineDraw.m
//  Project1Proto
//
//  Created by Student on 10/10/13.
//  Copyright (c) 2013 Student. All rights reserved.
//

#import "LineDraw.h"

@implementation LineDraw{
    UIBezierPath *_path;
    struct point _points[200];
    int _pts;
    struct trampoline _tr;
    BOOL _trExists;
    BOOL _colliding;
    float _trSize;
     ViewController *_parent;
    int _collisionTimer;
    float _score;
    
    float _infRectX;
    float _infRectY;
    float _infRectMaxWidth;
    float _infRectMaxHeight;
    
    float _ballX;
    float _ballY;
    
    float _arrowX;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //dont think I need to do anything here.
        self.opaque = NO;
    }
    return self;
}

-(id)initWithFrameAndParentVC:(CGRect)frame parentVC:(ViewController*)pVC
{
    self = [super initWithFrame:frame];
    if (self) {
        //dont think I need to do anything here.
        self.opaque = NO;
        _parent = pVC;
        _infRectX = 10;
        _infRectY = 10;
        _infRectMaxHeight = 40;
        _infRectMaxWidth = 200;
        _arrowX = 10;
    }
    return self;
}


-(void)endDraw
{
    //NSLog(@"end Draw called");
    //Create the trampoline out of the first and last point, then throw in a control pt.
    _tr.pt1 = _points[0];
    _tr.pt2 = _points[_pts-1];
    
    float absDiffX = fabsf(_points[0].x - _points[_pts-1].x);
    float absDiffY = fabsf(_points[0].y - _points[_pts-1].y);
    
    //Pythagorean theorum to find distance.
    _trSize = sqrtf(absDiffX*absDiffX + absDiffY*absDiffY);
 
    //Set up the control point for the quadratic.
    //The larger the trampoline, the further below the center point
    //the control point will be found.
    _tr.controlPt.x = (_points[0].x + _points[_pts-1].x) /2;
    _tr.controlPt.y = ((_points[0].y + _points[_pts-1].y) /2)+(_trSize/5);
    
    
    
    //Trampoline is only created if the angle is <45 degrees
    if(absDiffY>absDiffX)
    {
        _trExists = NO;
    }
    else
    {
        //Make sure wall is below halfway mark.
        if(_tr.pt1.y < 600 || _tr.pt2.y < 600)
        {
            //Wall is too high.
            _trExists = NO;
        }
        else{
            //Get distance of wall.
            float aDist = fabsf(_tr.pt1.y - _tr.pt2.y);
            float bDist = fabsf(_tr.pt1.x - _tr.pt2.x);
            float wallLength = sqrtf(aDist*aDist + bDist*bDist);
            if(wallLength < 500 && wallLength > 50)
            {
                _trExists = YES;
            }
            else{
                _trExists = NO;
            }
        }
    }
    
    [self setNeedsDisplay];
    
    //Mem set starts from the beginning of the array, and runs until the end,
    //Setting all values to 0, basically nullifying the array.
    memset(&_points[0], 0, sizeof(_points));
    _pts = 0;
}

-(void)addPoints:(int)x yPoint:(int)y
{
    _points[_pts].x = x;
    _points[_pts].y = y;
    _pts++;
    [self setNeedsDisplay];
}



-(void)getBallLoc:(float)x yPoint:(float)y
{
    //Check collision. Trampoline must exist and collision must not
    // have happened recently.
    _ballX = x;
    _ballY = y;
    
    if(_trExists && _collisionTimer <= 0)
    {
        //Slope is needed later.
        float slope = (_tr.pt2.y-_tr.pt1.y)/(_tr.pt2.x-_tr.pt1.x);
        
        //Basic pythag to get length
        float aDist = fabsf(_tr.pt1.y - _tr.pt2.y);
        float bDist = fabsf(_tr.pt1.x - _tr.pt2.x);
        float wallLength = sqrtf(aDist*aDist + bDist*bDist);
        
        /* working with y = mx+b doesn't work.
        float b = _tr.pt1.y - slope*_tr.pt1.x;
        */
        
        /* Getting general form from two points.
        a = y1-y2,
        b = x2-x1,
        c = (x1-x2)*y1 + (y2-y1)*x1
        */
        
        float a = _tr.pt1.y-_tr.pt2.y;
        float b = _tr.pt2.x-_tr.pt1.x;
        float c = (_tr.pt1.x-_tr.pt2.x)*_tr.pt1.y + (_tr.pt2.y-_tr.pt1.y)*_tr.pt1.x;
        
        float distance = (fabsf(a*x+b*y+c))/(sqrtf(a*a+b*b));
        //NSLog(@"DISTANCE: %f",distance);
        
        
        if (distance < 15) {
            //Close to line
            
            //This check makes sure the line doesn't extend beyond the actual points.
            if(!((x > _tr.pt1.x && x > _tr.pt2.x) || (x < _tr.pt1.x && x < _tr.pt2.x)))
            {
                //On collision, let the parent (the ball) know collision has occured.
                //Also set the collision timer to 5, preventing glitchy collisions.
                //Then get rid of the trampoline and redraw.
                //NSLog(@"Collision!");
                
                float centerPointX = (_tr.pt1.x+_tr.pt2.x)/2;
                float centerPointY = (_tr.pt1.y+_tr.pt2.y)/2;
                
                float xDist = fabsf(centerPointX-x);
                float yDist = fabsf(centerPointY-y);
                
                float totalDist = sqrtf(xDist*xDist + yDist*yDist);
                
                [_parent trampCollide:slope wallSize:wallLength distFromCenter:totalDist];
                _collisionTimer = 5;
                _trExists = false;
                [self setNeedsDisplay];
            }
        }
    }
    
    _collisionTimer--;
}

-(void)sendScore:(float)score{
    _score = score;
}

- (void)drawRect:(CGRect)rect
{
    
    //Getting context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //drawing prep.
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 5.0);
    
    //Start the path.
    CGContextBeginPath(context);
    
    for(int i = 0; i < _pts; i++)
    {
        if(i == 0)
        {
            CGContextMoveToPoint(context, _points[i].x, _points[i].y);
        }
        
        else{
            CGContextAddLineToPoint(context, _points[i].x, _points[i].y);
        }
    }
    
    //Stroking the drawn path.
    CGContextStrokePath(context);
    
    //Create a separate trampoline.
    if(_trExists)
    {
        
        if(_colliding)
        {
            //NSLog(@"point 1x = %f and point 1y = %f",_tr.pt1.x,_tr.pt1.y);
            //NSLog(@"point 2x = %f and point 2y = %f",_tr.pt2.x,_tr.pt2.y);
            
            CGContextMoveToPoint(context, _tr.pt1.x, _tr.pt1.y);
            CGContextAddQuadCurveToPoint(context, _tr.controlPt.x, _tr.controlPt.y, _tr.pt2.x, _tr.pt2.y);
            CGContextStrokePath(context);

        }
        else
        {
            CGContextMoveToPoint(context, _tr.pt1.x, _tr.pt1.y);
            CGContextAddLineToPoint(context, _tr.pt2.x, _tr.pt2.y);
            CGContextStrokePath(context);
        }
    }
    
    
    if(_ballY < 0)
    {
        //Drawing the arrow to display above screen ball.
       
        float _arrowHeight = -(_ballY/30)+15;
        //NSLog(@"Arrow height: %f",_arrowHeight);
        
        CGContextMoveToPoint(context, _ballX, 5);
        CGContextAddLineToPoint(context, _ballX+_arrowX, _arrowHeight);
        CGContextAddLineToPoint(context, _ballX+(-_arrowX), _arrowHeight);
        CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
        CGContextFillPath(context);
    }

    
    //Drawing for the influence box.
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGRect outerRect = CGRectMake(_infRectX, _infRectY, _infRectMaxWidth, _infRectMaxHeight);
    CGContextAddRect(context, outerRect);
    CGContextFillPath(context);
    CGContextStrokePath(context);
    
    float influenceWidth = [_parent getRemainingInfluence];
    float scaledInfluence = (influenceWidth / 25) * _infRectMaxWidth;

    CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
    CGRect innerRect = CGRectMake(_infRectX+2,_infRectY+2,scaledInfluence-4,_infRectMaxHeight-4);
    CGContextAddRect(context, innerRect);
    CGContextFillPath(context);
   
}

-(void)redraw
{
    [self setNeedsDisplay];
}

@end
