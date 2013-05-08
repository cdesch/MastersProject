//
//  SimplePoint.m
//  LeapPuzz
//
//  Created by cj on 2/19/13.
//
//

#import "SimplePoint.h"

@implementation SimplePoint

@synthesize x,y,z;
@synthesize is3d;


/** init 2d point with CGPoint */
- (id)initWithPosition:(CGPoint)p{
    if (self = [super init]) {

        self.x = p.x;
        self.y = p.y;
        self.z = 0.0f;
        self.is3d = false;
        
    }
    return self;
}

/** Init 2d Point with 2 separate values */
- (id)initWithX:(float)xVal withY:(float)yVal{
    
    if (self = [super init]) {
        
        self.x = xVal;
        self.y = yVal;
        self.z = 0.0f;
        self.is3d = false;
        
    }
    return self;
}


/** Init 3d point with CGPoint and z Value */
- (id)initWithPosition:(CGPoint)p withZ:(float)zVal{
    if (self = [super init]) {
        
        self.x = p.x;
        self.y = p.y;
        self.z = zVal;
        self.is3d = true;
        
    }
    return self;
}


/** Init 3d Point with 3 separate values */
- (id)initWithX:(float)xVal withY:(float)yVal withZ:(float)zVal{
    
    if (self = [super init]) {
        
        self.x = xVal;
        self.y = yVal;
        self.z = zVal;
        self.is3d = true;
        
    }
    return self;
}

/** Return the CGPoint type from the object */
- (CGPoint)point{
    return CGPointMake(self.x, self.y);
}


@end
