//
//  LPLinePointTests.h
//  LeapPaint
//
//  Created by cj on 5/8/13.
//  Copyright (c) 2013 cjdesch. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "LPLinePoint.h"
/**
 * Tests the LPLinePointTests object
 */

@interface LPLinePointTests : SenTestCase{
    NSString* testName; /**< testName is the name of the test */
    LPLinePoint* pointNoWidth;     /**< pointNoWidth is a test point without width variable at init */
    LPLinePoint* pointWithWidth;   /**< pointNoWidth is a test point width variable at init */
    
}

@end
