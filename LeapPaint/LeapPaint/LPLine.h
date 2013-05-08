//
//  LPLine.h
//  LeapPuzz
//
//  Created by cj on 4/2/13.
//
//

#import <Foundation/Foundation.h>
/**
 LPLine is tracks the points in one line from beginning to end
 */
@interface LPLine : NSObject {
    
}

@property (nonatomic, strong) NSMutableArray* points;  /**< points is a an array of points for the line */
@property (nonatomic, readwrite) float width;    /**< width is a constant width for the line */

@end
