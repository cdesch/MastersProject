//
//  Point.h
//  LeapPuzz
//
//  Created by cj on 2/19/13.
//
//

#import <Foundation/Foundation.h>

/**
 * 2D space coordinate for temporarily maniulapting points
 *
 */
@interface SimplePointObject : NSObject

@property (nonatomic, readwrite) CGPoint point; /**< point is the X and Y coordinates */
/**
 * Init constructor with existing point to create a 2d Point
 * @param p an point consisting of (x,y)
 * @return object instance
 */
- (id)initWithPosition:(CGPoint)p;
/**
 * Init constructor with existing point to create a 2d Point
 * @param x is x axis coordinate
 * @param y is y axis coordinate
 * @return object instance
 */
- (id)initWithX:(float)x withY:(float)y;

@end
