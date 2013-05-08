//
//  UtilityTests.m
//  LeapPuzz
//
//  Created by cj on 4/24/13.
//
//

#import "UtilityTests.h"

@implementation UtilityTests

/** SetUp
 Sets tests up and allocates objects, instances and default values
 */
- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    testName = @"UtilityTests";
}

/** TearDown
 Tears down objects and frees allocated resources
 */
- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

/** Test generating random numbers */
- (void)testRandomNumbers
{
    NSString* testCase = [NSString stringWithFormat:@"%@ - %s - %s",testName, __FILE__, __PRETTY_FUNCTION__, nil];
        
    int randomNumber = [Utility getRandomNumberUnder:100];
    STAssertTrue((randomNumber >= 0 && randomNumber < 100) , testCase);
    
    
    //Test within a range
}
@end
