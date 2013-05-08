//
//  LPBrushTool.h
//  LeapPaint
//
//  Created by cj on 3/19/13.
//  Copyright (c) 2013 cjdesch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "LPDrawingTool.h"

@interface LPBrushTool : LPDrawingTool {
    
    NSString* templateImageName;
    NSImage* templateImage;
}



@end
