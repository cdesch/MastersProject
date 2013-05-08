//
//  LPDrawingTool.m
//  LeapPaint
//
//  Created by cj on 3/18/13.
//  Copyright (c) 2013 cjdesch. All rights reserved.
//

#import "LPDrawingTool.h"

@implementation LPDrawingTool
@synthesize lineWidth;
@synthesize transparency;

@synthesize primaryColor;
@synthesize secondaryColor;
@synthesize points;
@synthesize drawingTool;


- (id)initWithWidth:(int)w withTransparency:(int)t withPrimaryColor:(NSColor*)p withSecondaryColor:(NSColor*)s{
    if (self = [super init]){
        
        self.points = [[NSMutableArray alloc] init];
        self.primaryColor = p;
        self.secondaryColor = s;
        
        self.lineWidth = w;
        self.transparency = t;
        
        [self toolDidLoad];
        
    }
    
    return self;
}

- (void)inputBegan:(NSEvent *)theEvent  withSettings:(ToolSettings *)settings{
    self.settings = settings;

}

- (void)inputMoved:(NSEvent *)theEvent {
    
}

- (void)inputEnded:(NSEvent *)theEvent {
    
}



- (void)toolDidLoad{
    //NSLog(@"ToolDidLoad");
    
}

@end
