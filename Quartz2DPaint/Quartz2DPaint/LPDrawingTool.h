//
//  LPDrawingTool.h
//  LeapPaint
//
//  Created by cj on 3/18/13.
//  Copyright (c) 2013 cjdesch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ToolSettings.h"


@interface LPDrawingTool : NSObject{
    
    
}


@property (copy) NSString *drawingTool;
@property (assign) int lineWidth;
@property (assign) int transparency;
@property (assign) int fontSize;
@property (strong) NSColor *primaryColor;
@property (strong) NSColor *secondaryColor;
@property (strong) NSMutableArray* points;
@property (strong) NSString* brushTextureName;
@property (weak) ToolSettings *settings;


- (id)initWithWidth:(int)w withTransparency:(int)t withPrimaryColor:(NSColor*)p withSecondaryColor:(NSColor*)s;

- (void)toolDidLoad;
@end
