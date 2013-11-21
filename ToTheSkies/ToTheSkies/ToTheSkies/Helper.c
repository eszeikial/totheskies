//
//  Helper.c
//  ToTheSkies
//
//  Created by Student on 11/15/13.
//  Copyright (c) 2013 Student. All rights reserved.
//
#include "Helper.h"


int randInRange(int lowerBound, int upperBound){
    return rand() % upperBound + lowerBound;
}