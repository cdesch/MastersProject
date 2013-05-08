//
//  GameSettings.m
//  LeapPuzz
//
//  Created by cj on 4/16/13.
//
//

#import "GameSettings.h"

//Constants
int const  BLOCK_SIZE = 128;

@implementation GameSettings
@synthesize depthOpacityMode;
@synthesize eraserMode;
@synthesize inputMode;
@synthesize painting;

/** Singleton SharedInstance
 Intiailizes and Returns a shared instance of the class
 */
+ (GameSettings *)sharedInstance
{
    static GameSettings *sharedInstance;
    
    @synchronized(self)
    {
        if (!sharedInstance)
            sharedInstance = [[GameSettings alloc] init];
        return sharedInstance;
    }
}

/** 
 Initialize the class and sets the default values 
 */
- (id)init
{
    if (self = [super init]) {
        // Init Defaults
        self.depthOpacityMode = false;
        self.painting = false;
    }
    return self;
}
@end
