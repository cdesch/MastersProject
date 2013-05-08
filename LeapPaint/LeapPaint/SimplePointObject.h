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

@interface SimplePointObject : NSObject {
    
    
}

@property (nonatomic, readwrite) CGPoint point; /**< point is the X and Y coordinates */

- (id)initWithPosition:(CGPoint)p;
- (id)initWithX:(float)x withY:(float)y;

@end
