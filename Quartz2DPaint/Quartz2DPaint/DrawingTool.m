//
//  DrawingTool.m
//  LeapPaint
//
//  Created by cj on 3/17/13.
//  Copyright (c) 2013 cjdesch. All rights reserved.
//

#import "DrawingTool.h"

@implementation DrawingTool


- (DrawingTool*)initWithCompletion:(dispatch_block_t)completion {
    
    if (self = [super init])
    {
        self.completion = completion;
    }
    return self;
    
}

//override to disable double-buffered drawing (e.g. for eraser)
- (BOOL)doubleBufferDrawing
{
    return YES;
}


- (void)inputBegan:(NSEvent *)theEvent locationInView:(CGPoint)currentPoint withSettings:(ToolSettings *)settings{
    self.settings = settings;
    self.firstPoint = currentPoint;
}

- (void)inputMoved:(NSEvent *)theEvent locationInView:(CGPoint)currentPoint{
    
}

- (void)inputEnded:(NSEvent *)theEvent locationInView:(CGPoint)currentPoint{
    
    if (self.completion) {
        self.completion();
    }
}


@end
