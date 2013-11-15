//
//  Helper.h
//  ToTheSkies
//
//  Created by Student on 11/15/13.
//  Copyright (c) 2013 Student. All rights reserved.
//
#include <stdlib.h>

#ifndef ToTheSkies_Helper_h
#define ToTheSkies_Helper_h

static int randInRange(int lowerBound, int upperBound){
    return rand() % upperBound + lowerBound;
};

#endif


