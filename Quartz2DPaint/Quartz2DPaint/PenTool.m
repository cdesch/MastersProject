//
//  PenTool.m
//  LeapPaint
//
//  Created by cj on 3/17/13.
//  Copyright (c) 2013 cjdesch. All rights reserved.
//

#import "PenTool.h"

@implementation PenTool

static const CGFloat kPointMinDistance = 5;
static const CGFloat kPointMinDistanceSquared = kPointMinDistance * kPointMinDistance;

- (void)inputBegan:(NSEvent *)theEvent locationInView:(CGPoint)currentPoint withSettings:(ToolSettings *)settings{
    
    //[super touchBegan:touch inImageView:imageView withSettings:settings];
    [super inputBegan:theEvent locationInView:currentPoint withSettings:settings];
    
    [self createPath];
    
    //self.previousPoint1 = [touch previousLocationInView:self.drawingImageView];
    //self.previousPoint2 = [touch previousLocationInView:self.drawingImageView];
    
    self.previousPoint1 = currentPoint;
    self.previousPoint2 = currentPoint;
    
    
    [self inputMoved:theEvent locationInView:currentPoint];
    
}

- (void)inputMoved:(NSEvent *)theEvent locationInView:(CGPoint)currentPoint{
    
    //CGPoint currentPoint = [touch locationInView:self.drawingImageView];
    //NSPoint tvarMousePointInWindow	= [theEvent locationInWindow];

    
    /* check if the point is farther than min dist from previous */
    CGFloat dx = currentPoint.x - self.lastPoint.x;
    CGFloat dy = currentPoint.y - self.lastPoint.y;
    
    if (dx * dx + dy * dy < kPointMinDistanceSquared) {
        return;
    }
    
    //call touch moved after the above check - image will be restored
    [super inputMoved:theEvent locationInView:currentPoint];
    
    [self drawCurveEndingAtTouch:theEvent locationInView:currentPoint];
    
    if (self.pathDistance > 100) {
        //commit changes and recreate path, faster
        self.drawingSnapshot = self.drawingImageView.image;
        [self createPath];
    }
    
    self.lastPoint = currentPoint;
    
}

- (void)inputEnded:(NSEvent *)theEvent locationInView:(CGPoint)currentPoint{
        

    
    //first reset the image, we're still adjusting/drawing the curve
    //self.drawingImageView.image = self.drawingSnapshot;
    
    //finish the curve along to the final touch
    [self drawCurveEndingAtTouch:theEvent locationInView:currentPoint];
    
    [self releasePath];
    
    [super inputEnded:theEvent locationInView:currentPoint];
    
}

// drawing curves using quadratic beziers based on https://github.com/levinunnink/Smooth-Line-View
- (void)drawCurveEndingAtTouch:(NSEvent *)theEvent locationInView:(CGPoint)currentPoint{
    
    [self addTouchToPath:theEvent locationInView:currentPoint];
    
    [self drawCurveForPath];
    
}


- (void)addTouchToPath:(NSEvent *)theEvent  locationInView:(CGPoint)currentPoint{
    

    self.previousPoint2 = self.previousPoint1;
    self.previousPoint1 = currentPoint;
    
    CGPoint mid1 = midPoint(self.previousPoint1, self.previousPoint2);
    CGPoint mid2 = midPoint(currentPoint, self.previousPoint1);
    CGMutablePathRef subpath = CGPathCreateMutable();

    CGPathMoveToPoint(subpath, NULL, mid1.x, mid1.y);
    CGPathAddQuadCurveToPoint(subpath, NULL, self.previousPoint1.x, self.previousPoint1.y, mid2.x, mid2.y);
    
    CGPathAddPath(self.path, NULL, subpath);
    
    CGFloat dx = currentPoint.x - self.lastPoint.x;
    CGFloat dy = currentPoint.y - self.lastPoint.y;
    float lastDistance = sqrt(dx * dx + dy * dy);
    self.pathDistance += lastDistance;
    
    CGPathRelease(subpath);
    
}

- (void)drawCurveForPath {
    
    //[self setupImageContextForDrawing];
    //NSGraphicsContext* theContext = [NSGraphicsContext currentContext];
    //CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextRef context = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];

    CGContextAddPath(context, self.path);
    CGContextStrokePath(context);
    //self.drawingImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    
    
    CGContextFlush(context);

    
}

CGPoint midPoint(CGPoint p1, CGPoint p2) {
    return CGPointMake((p1.x + p2.x) * 0.5, (p1.y + p2.y) * 0.5);
}

- (void)releasePath {
    
    if (_path != nil) {
        CGPathRelease(_path);
        _path = nil;
    }
    self.pathDistance = 0.0;
    
}

- (void)createPath {
    
    [self releasePath];
    
    //analyzer will report this leaks - this is released in the above method
    self.path = CGPathCreateMutable();
    self.pathDistance = 0.0;
    
}



@end
