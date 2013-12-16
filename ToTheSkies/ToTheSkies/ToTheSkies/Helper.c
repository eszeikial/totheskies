#include "Helper.h"

// Return a random number within a range, inclusive
int randInRange(int lowerBound, int upperBound)
{
    return rand() % upperBound + lowerBound;
    
}

// Use general form to calculate distance
float calcDistance(cPoint start, cPoint end, cPoint playerPosition, float height)
{
      /* Getting general form from two points.
      a = y1-y2,
      b = x2-x1,
      c = (x1-x2)*y1 + (y2-y1)*x1
      */
    
    float a = start.y - end.y;
    float b = end.x - start.x;
    float c = (start.x - end.x) * start.y + (end.y - start.y) * start.x;
    float x = playerPosition.x;
    float y = -playerPosition.y + height;
    
    // Using general form to calculate distance
    float distance = (fabsf(a*x+b*y+c))/(sqrtf(a*a+b*b));
    return distance;
}