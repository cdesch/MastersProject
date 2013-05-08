//
//  PenTool.h
//  LeapPaint
//
//  Created by cj on 3/17/13.
//  Copyright (c) 2013 cjdesch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DrawingTool.h"

@interface PenTool : DrawingTool

@property (assign) float pathDistance;
@property (assign) CGPoint previousPoint1;
@property (assign) CGPoint previousPoint2;
@property (assign) CGMutablePathRef path;
@property (assign) CGPoint lastPoint;


- (void)createPath;


@end
