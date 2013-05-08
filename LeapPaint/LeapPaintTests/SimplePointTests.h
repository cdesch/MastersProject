//
//  SimplePointTests.h
//  LeapPuzz
//
//  Created by cj on 4/24/13.
//
//

#import <SenTestingKit/SenTestingKit.h>
#import "SimplePoint.h"
#import "cocos2d.h"

/**
 * Tests the SimplePoint object
 */
@interface SimplePointTests : SenTestCase {
    
    NSString* testName; /**< name of the test */
    SimplePoint* twoValuePoint;     /**< two coordinate point (x,y) */
    SimplePoint* threeValuePoint;   /**< three coordinate point (x,y,z) */
    
}

@end
