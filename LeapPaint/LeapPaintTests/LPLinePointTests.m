//
//  LPLinePointTests.m
//  LeapPaint
//
//  Created by cj on 5/8/13.
//  Copyright (c) 2013 cjdesch. All rights reserved.
//

#import "LPLinePointTests.h"

@implementation LPLinePointTests


/** SetUp
 Sets tests up and allocates objects, instances and default values
 */
- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    pointNoWidth = [[LPLinePoint alloc] initWithPosition:CGPointMake(5, 5)];
    
    pointWithWidth = [[LPLinePoint alloc] initWithX:5.0f withY:5.0f withWidth:5.0f];
    
    
}
/** TearDown
 Tears down objects and frees allocated resources
 */
- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}


/** Test Class Initializers */
- (void)testInits
{
    testName = [NSString stringWithFormat:@"%s - %s",__FILE__, __PRETTY_FUNCTION__, nil];
    
    float pointValue = 5.0f;
    
    NSMutableArray* testPoints = [[NSMutableArray alloc] init];
    
    LPLinePoint* testPoint = [[LPLinePoint alloc] initWithPosition:CGPointMake(pointValue, pointValue)];
    [testPoints addObject:testPoint];
    
    testPoint = [[LPLinePoint alloc] initWithPosition:CGPointMake(pointValue,pointValue) withWidth:pointValue];
    [testPoints addObject:testPoint];
    
    testPoint = [[LPLinePoint alloc] initWithX:pointValue withY:pointValue];
    [testPoints addObject:testPoint];
    
    testPoint = [[LPLinePoint alloc] initWithX:pointValue withY:pointValue withWidth:pointValue];
    [testPoints addObject:testPoint];
    
    
    //Check to make sure each point exists
    for(LPLinePoint* point in testPoints){
        
        STAssertNotNil(testPoint, [NSString stringWithFormat:@"%@ - %@",testName, @"SimplePoint init not working",nil]);
        
        //Test that both values are equal to the point value
        STAssertEquals(testPoint.x, pointValue,  [NSString stringWithFormat:@"%@ - %@",testName, @"Values do not match",nil]);
        
        STAssertEquals(testPoint.y, pointValue,  [NSString stringWithFormat:@"%@ - %@",testName, @"Values do not match",nil]);
        
        //if not, test that it is 0.0f
        STAssertNotNil(testPoint.width,  [NSString stringWithFormat:@"%@ - %@",testName, @"Values do not match",nil]);
        
    }
    
}


@end
