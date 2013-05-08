//
//  LPPoint.h
//  LeapPaint
//
//  Created by cj on 5/8/13.
//  Copyright (c) 2013 cjdesch. All rights reserved.
//

#import <Foundation/Foundation.h>



/**
 LPLinePoint is a plotted point for drawing onto the canvas
 */
@interface LPLinePoint : NSObject

@property (nonatomic, readwrite) float x; /**< x coordinate */
@property (nonatomic, readwrite) float y; /**< y coordinate */
@property (nonatomic, readwrite) float width; /**< width of the point */

/**
 * Init constructor with existing point to create with no width
 * @param p an point (x,y)
 * @return object instance
 */
- (id)initWithPosition:(CGPoint)p;
/**
 * Init constructor with x and y values with no width
 * @param xVal coordinate value
 * @param yVal coordinate value
 * @return object instance
 */
- (id)initWithX:(float)xVal withY:(float)yVal;
/**
 * Init constructor with existing point with width
 * @param p a point (x,y)
 * @param wVal width of the point
 * @return object instance
 */
- (id)initWithPosition:(CGPoint)p withWidth:(float)wVal;
/**
 * Init constructor with x and y values with width
 * @param xVal coordinate value
 * @param yVal coordinate value
 * @param wVal width of the point
 * @return object instance
 */
- (id)initWithX:(float)xVal withY:(float)yVal withWidth:(float)wVal;

/**
 * Returns point based on x and y
 * @return CGPoint
 */
- (CGPoint)point;
@end
