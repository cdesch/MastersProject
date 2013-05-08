//
//  Utility.h
//  LeapPuzz
//
//  Created by cj on 4/24/13.
//
//

#import <Foundation/Foundation.h>



/**
 Utility class provides common usage function throughout the application. 
 */

@interface Utility : NSObject {
}

/**
 Generates a random number between two designated integers
 @param from is the bottom of the range
 @param to is the top of the range
 @return a random number between the from and to parameters
 */
+ (int)getRandomNumberBetween:(int)from to:(int)to;
/**
 Generates a random number between 0 designated integer
 @param to is the top of the range
 @return a random number between 0 and to parameters
 */
+ (int)getRandomUniformNumberUnder:(int)to;
/**
 Generates a random number between 0 designated integer
 @param to is the top of the range
 @return a random number between 0 and to parameters
 */
+ (int)getRandomNumberUnder:(int)to;
//- (void) initRandomSeed(long firstSeed);
//float nextRandomFloat();
@end
