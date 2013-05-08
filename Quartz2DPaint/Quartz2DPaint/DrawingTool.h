//
//  DrawingTool.h
//  LeapPaint
//
//  Created by cj on 3/17/13.
//  Copyright (c) 2013 cjdesch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ToolSettings.h"

@interface DrawingTool : NSObject


@property (strong) NSImage *drawingSnapshot;
@property (strong) NSImageView *drawingImageView;
@property (weak) ToolSettings *settings;
@property (assign) CGPoint firstPoint;
@property (copy) NSString *imageName;
@property (copy) NSString *toolName;

- (void)inputBegan:(NSEvent *)theEvent locationInView:(CGPoint)currentPoint  withSettings:(ToolSettings *)settings;
- (void)inputMoved:(NSEvent *)theEvent locationInView:(CGPoint)currentPoint;
- (void)inputEnded:(NSEvent *)theEvent locationInView:(CGPoint)currentPoint;


@property (copy) dispatch_block_t completion;

- (DrawingTool*)initWithCompletion:(dispatch_block_t)completion;

@end
