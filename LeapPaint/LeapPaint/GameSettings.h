//
//  GameSettings.h
//  LeapPuzz
//
//  Created by cj on 4/16/13.
//
//

#import <Foundation/Foundation.h>


#define kVelMax 1000
#define kVelMin 0

#define kOpMinRange -80
#define kOpMaxRange 120

#define kOpMin 0
#define kOpMax 100

#define kNormalizedVelMax 15
#define kNormalizedVelMin 0

#define kMaxFrames 1000

extern int const BLOCK_SIZE;


typedef enum {
    kPressKeyMode,
    kDepthMode,
    
} InputMode;

@interface GameSettings : NSObject{
    
    
}

@property (nonatomic,readwrite) BOOL depthOpacityMode;      /**< depthOpacityMode controls use of z axis control of opacity */
@property (nonatomic,readwrite) BOOL eraserMode;            /**< eraserMode controls erasing on drawing canvas */
@property (nonatomic,readwrite) InputMode inputMode;        /**< inputMode controller input mode for leapmotion */

+ (GameSettings *)sharedInstance;

@end
