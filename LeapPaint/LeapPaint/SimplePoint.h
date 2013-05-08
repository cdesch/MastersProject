//
//  SimplePoint.h
//  LeapPuzz
//
//  Created by cj on 2/19/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


/**
 * 2D or 3D space coordinate for temporarily maniulapting points
 *
 */

@interface SimplePoint : NSObject {


}

@property (nonatomic, readwrite) float x; /**< x coordinate */
@property (nonatomic, readwrite) float y; /**< y coordinate */
@property (nonatomic, readwrite) float z; /**< z coordinate */
@property (nonatomic, readwrite) BOOL is3d; /**< is3d is 2d or 3d point type */


/**
 * Init constructor with existing point to create a 2d Point
 * @param p an point (x,y)
 * @return object instance
 */
- (id)initWithPosition:(CGPoint)p;
/**
 * Init constructor with existing point to create a 2d Point
 * @param xVal coordinate value
 * @param yVal coordinate value
 * @return object instance
 */
- (id)initWithX:(float)xVal withY:(float)yVal;
/**
 * Init constructor with existing point to create a 3d Point
 * @param p a point (x,y)
 * @param zVal coordinateValue
 * @return object instance
 */
- (id)initWithPosition:(CGPoint)p withZ:(float)zVal;
/**
 * Init constructor with existing point to create a 2d Point
 * @param xVal coordinate value
 * @param yVal coordinate value
 * @param zval coordinate value
 * @return object instance
 */
- (id)initWithX:(float)xVal withY:(float)yVal withZ:(float)zVal;

/**
 * Returns point based on x and y
 * @return CGPoint
 */
- (CGPoint)point;
@end
