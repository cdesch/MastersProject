//
//  GameSettingsTests.m
//  LeapPuzz
//
//  Created by cj on 4/24/13.
//
//

#import "GameSettingsTests.h"

@implementation GameSettingsTests

/** SetUp 
    Sets tests up and allocates objects, instances and default values
 */
- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    
    gameSettings = [GameSettings sharedInstance];
    
    //Test that the shared instance created a new singleton
    STAssertNotNil(gameSettings, @"GameSettings not init as singleton");
    
}
/** TearDown
    Tears down objects and frees allocated resources 
 */
- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}


/**
 Test all the defined values are within their bounds
     //Assert values are true to their names such that Min is less than max and vise versa
 */

- (void)testDefinedValues{

    //Assert values are true to their names such that Min is less than max and vise versa
    STAssertTrue(kVelMax > kVelMin, @"kVel Constant Values are within range of their definition.");
    
    STAssertTrue((kOpMaxRange > kOpMinRange), @"kOp Constant Values are within range of their definition.");
    
    STAssertTrue((kOpMax > kOpMin), @"kNormalized Constant Values are within range of their definition.");
    
    STAssertTrue((kNormalizedVelMax > kNormalizedVelMin), @"kNormalized Constant Values are within range of their definition.");
    
    //Assert that it exists
    STAssertNotNil(kMaxFrames, @"kMax does not exist");
    
}


/** Test Singleton instance availability */
- (void)testSharedInstance{
    
    STAssertNotNil([GameSettings sharedInstance], @"GameSettings Does not provide SharedInstance");
}

/** Test each property in the classe */
- (void)testProperties{
    
    
    //Set to false
    gameSettings.depthOpacity = false;
    //Check
    STAssertFalse(gameSettings.depthOpacity, @"depthOpacity cannot be set to false");
    
    //Set to true
    gameSettings.depthOpacity = true;
    //Check
    STAssertTrue(gameSettings.depthOpacity, @"depthOpacity cannot be set to true");
    
    
}



@end
