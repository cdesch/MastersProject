//
//  PaintCanvasView.h
//  LeapPaint
//
//  Created by cj on 3/17/13.
//  Copyright (c) 2013 cjdesch. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MyPoint.h"
#import "DrawingTool.h"
#import "ToolSettings.h"
#import "PenTool.h"
#import "LPDrawingTool.h"
#import "LeapObjectiveC.h"
#import "TrackedFinger.h"
#import "SimplePoint.h"

@interface PaintCanvasView : NSView <LeapListener>{

    LeapController *controller;
    
    NSMutableArray  * myDrawingObjects;
    NSMutableArray	* myMutaryOfBrushStrokes;
	NSMutableArray	* myMutaryOfPoints;
    LPDrawingTool* drawingTool;
    
    

    NSString* selectedTool;
    
    NSColor* currentColor;
    float currentLineWidth;
    NSString* brushType;
    NSMutableDictionary* trackableList;
    
    
    
}

@property (nonatomic, strong)     NSMutableArray* tools;

- (void)clearScreen;
- (void)setColor:(NSColor*)color;
- (void)setLineWidth:(float)w;
- (void)setTool:(NSString*)tool;

@end
