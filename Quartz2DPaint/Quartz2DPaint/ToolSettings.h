//
//  ToolSettings.h
//  LeapPaint
//
//  Created by cj on 3/18/13.
//  Copyright (c) 2013 cjdesch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolSettings : NSObject


@property (copy) NSString *drawingTool;
@property (assign) int lineWidth;
@property (assign) int transparency;
@property (assign) int fontSize;
@property (strong) NSColor *primaryColor;
@property (strong) NSColor *secondaryColor;

- (void)loadFromUserDefaults;
- (void)saveToUserDefaults;

@end
