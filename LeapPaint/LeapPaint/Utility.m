//
//  Utility.m
//  LeapPuzz
//
//  Created by cj on 4/24/13.
//
//

#import "Utility.h"

@implementation Utility

/** returns random number within a range with defined upper and lower bounds */
+ (int)getRandomNumberBetween:(int)from to:(int)to {
    
    //Check that one isn't greater than the other
    //if so, flip them
    
    return (int)from + arc4random() % (to-from+1);
}

/** Returns a random number from 0 to an upper bound */
+ (int)getRandomNumberUnder:(int)to{
    return (arc4random() % to);
}


/** Returns a Uniform Random Number from 0 to an upper bound */
+ (int)getRandomUniformNumberUnder:(int)to{
    //Check if uniform available
    if (arc4random_uniform != NULL)
        return  arc4random_uniform (to);
    else
        return  (arc4random() % to);
}





/*
static unsigned long seed;

void initRandomSeed(long firstSeed)
{
    seed = firstSeed;
}

float nextRandomFloat()
{
    return (((seed= 1664525*seed + 1013904223)>>16) / (float)0x10000);
}*/



@end
