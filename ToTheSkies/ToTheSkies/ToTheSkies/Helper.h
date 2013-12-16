//
//  Helper.h
//  ToTheSkies
//
//  Created by Student on 11/15/13.
//  Copyright (c) 2013 Student. All rights reserved.
//
#include <stdlib.h>
#include <stdio.h>
#include <math.h>

#ifndef ToTheSkies_Helper_h
#define ToTheSkies_Helper_h

// a struct to represent a point since CGPoint isn't compatible with C
typedef struct {
    float x, y;
}cPoint;


int randInRange(int lowerBound, int upperBound);
float calcDistance(cPoint start, cPoint end, cPoint playerPosition, float height);

#endif


