//
//  LPPoint.m
//  LeapPaint
//
//  Created by cj on 5/8/13.
//  Copyright (c) 2013 cjdesch. All rights reserved.
//

#import "LPLinePoint.h"

@implementation LPLinePoint
@synthesize x;
@synthesize y;
@synthesize width;

/** init 2d point with CGPoint */
- (id)initWithPosition:(CGPoint)p{
    if (self = [super init]) {
        
        self.x = p.x;
        self.y = p.y;
        self.width = 0.0f;

        
    }
    return self;
}
/** Init Point with 2 separate values */
- (id)initWithX:(float)xVal withY:(float)yVal{
    if (self = [super init]) {
        
        self.x = xVal;
        self.y = yVal;
        self.width = 0.0f;
    }
    return self;
}
/** Init  point with CGPoint and width Value */
- (id)initWithPosition:(CGPoint)p withWidth:(float)wVal{
    if (self = [super init]) {
        self.x = p.x;
        self.y = p.y;
        self.width = wVal;
    }
    return self;
}
/** Init Point with x and y values with width*/
- (id)initWithX:(float)xVal withY:(float)yVal withWidth:(float)wVal{
    if (self = [super init]) {
        self.x = xVal;
        self.y = yVal;
        self.width = wVal;
    }
    return self;
}
/** Return the CGPoint type from the object */
- (CGPoint)point{
    return CGPointMake(self.x, self.y);
}
@end
