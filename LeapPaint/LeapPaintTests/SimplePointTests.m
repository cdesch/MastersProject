//
//  SimplePointTests.m
//  LeapPuzz
//
//  Created by cj on 4/24/13.
//
//

#import "SimplePointTests.h"

@implementation SimplePointTests

/** SetUp
 Sets tests up and allocates objects, instances and default values
 */
- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    twoValuePoint = [SimplePoint alloc] initWithPosition:CGPointMake(5, 5);
    
    threeValuePoint = [[SimplePoint alloc] initWithX:5.0f withY:5.0f withZ:5.0f];
    
    
}
/** TearDown
 Tears down objects and frees allocated resources
 */
- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}


/** Test class initializers */
- (void)testInits
{
    NSString* testName = [NSString stringWithFormat:@"%s - %s",__FILE__, __PRETTY_FUNCTION__, nil];
    
    float pointValue = 5.0f;
    
    NSMutableArray* testPoints = [[NSMutableArray alloc] init];
    
    SimplePoint* testPoint = [[SimplePoint alloc] initWithPosition:CGPointMake(pointValue, pointValue)];
    [testPoints addObject:testPoint];
    
    testPoint = [[SimplePoint alloc] initWithPosition:CGPointMake(pointValue,pointValue) withZ:pointValue];
    [testPoints addObject:testPoint];
    
    testPoint = [[SimplePoint alloc] initWithX:pointValue withY:pointValue];
    [testPoints addObject:testPoint];
    
    testPoint = [[SimplePoint alloc] initWithX:pointValue withY:pointValue withZ:pointValue];
    [testPoints addObject:testPoint];
    
    
    //Check to make sure each point exists
    for(SimplePoint* point in testPoints){
        
        STAssertNotNil(testPoint, [NSString stringWithFormat:@"%@ - %@",testName, @"SimplePoint init not working",nil]);
        
        //Test that both values are equal to the point value
        STAssertEquals(testPoint.x, pointValue,  [NSString stringWithFormat:@"%@ - %@",testName, @"Values do not match",nil]);
        
        STAssertEquals(testPoint.y, pointValue,  [NSString stringWithFormat:@"%@ - %@",testName, @"Values do not match",nil]);
        
        
        //If it is a 3d point, test the z
        if (testPoint.is3d){
            STAssertEquals(testPoint.z, pointValue,  [NSString stringWithFormat:@"%@ - %@",testName, @"Values do not match",nil]);
            
        }else{
            
            //if not, test that it is 0.0f
            STAssertEquals(testPoint.z, 0.0f,  [NSString stringWithFormat:@"%@ - %@",testName, @"Values do not match",nil]);
            
        }
        
        
    }

}
@end
