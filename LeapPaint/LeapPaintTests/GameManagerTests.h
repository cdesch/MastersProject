//
//  GameManagerTests.h
//  LeapPuzz
//
//  Created by cj on 4/24/13.
//
//

#import <SenTestingKit/SenTestingKit.h>
#import "GameManager.h"
#import "GameSettings.h"
/**
 * Tests the GameManager object
 */
@interface GameManagerTests : SenTestCase {
    
    NSString* testName; /**< testName is the name of the test */
    GameManager* node; /**< gameManager instance  */
}

@end
