//
//  PaintCanvasView.m
//  LeapPaint
//
//  Created by cj on 3/17/13.
//  Copyright (c) 2013 cjdesch. All rights reserved.
//

#import "PaintCanvasView.h"


@interface PaintCanvasView()

@property (nonatomic, strong) ToolSettings *toolSettings;
@property (nonatomic, strong) NSMutableArray *drawingTools;

#pragma mark - Undo stack

@property (assign) int undoStackLocation;
@property (assign) int undoStackCount;

@end

@implementation PaintCanvasView

@synthesize drawingTools;
@synthesize toolSettings;

@synthesize tools;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        
        NSLog(@"Init");
        
        myMutaryOfBrushStrokes	= [[NSMutableArray alloc] init];
        myDrawingObjects = [[NSMutableArray alloc] init];
        
        drawingTools = [[NSMutableArray alloc] init];
        

        
        self.toolSettings = [[ToolSettings alloc] init];
         [self.toolSettings loadFromUserDefaults];
        [self initializeTools];
        
        //NSColorPanel* colorPanel = [NSColorPanel sharedColorPanel];
        
        currentColor = [NSColor blueColor];
        currentLineWidth = 1.0;
        
        trackableList = [[NSMutableDictionary alloc] init];
        
        [self run];
        
        self.tools = [[NSMutableArray alloc] initWithObjects:@"Pen",@"Brush", nil];
        selectedTool = @"Pen";
        

        // initialise random numebr generator used in drawRect for creating colours etc.
        srand(time(NULL));
    }
    
    return self;
}

#pragma mark - SampleDelegate Callbacks
- (void)run
{
    controller = [[LeapController alloc] init];
    [controller addListener:self];
    NSLog(@"running");
}

- (void)onInit:(NSNotification *)notification{
    NSLog(@"Leap: Initialized");
}

- (void)onConnect:(NSNotification *)notification;
{
    NSLog(@"Leap: Connected");
    LeapController *aController = (LeapController *)[notification object];
    //[aController enableGesture:LEAP_GESTURE_TYPE_CIRCLE enable:YES];
    //[aController enableGesture:LEAP_GESTURE_TYPE_KEY_TAP enable:YES];
    //[aController enableGesture:LEAP_GESTURE_TYPE_SCREEN_TAP enable:YES];
    //[aController enableGesture:LEAP_GESTURE_TYPE_SWIPE enable:YES];
}

- (void)onDisconnect:(NSNotification *)notification{
    NSLog(@"Leap: Disconnected");
}

- (void)onExit:(NSNotification *)notification{
    NSLog(@"Leap: Exited");
}


- (void)onFrame:(NSNotification *)notification{
    
    //NSLog(@"OnFrame");
    LeapController *aController = (LeapController *)[notification object];
    // Get the most recent frame and report some basic information
    LeapFrame *frame = [aController frame:0];
    

    if ([[frame hands] count] != 0) {
        // Get the first hand
        LeapHand *hand = [[frame hands] objectAtIndex:0];
        
        // Check if the hand has any fingers
        NSArray *fingers = [hand fingers];
        
        if ([fingers count] != 0) {
            
            // Calculate the hand's average finger tip position
            LeapVector *avgPos = [[LeapVector alloc] init];
            for (int i = 0; i < [fingers count]; i++) {
                LeapFinger *finger = [fingers objectAtIndex:i];
                avgPos = [avgPos plus:[finger tipPosition]];
                
                if (avgPos.z < 0){
                    NSString* fingerID = [NSString stringWithFormat:@"%d", finger.id];
                    
                    //Check if the Finger ID exists in the list already
                    if ([trackableList objectForKey:fingerID]) {
                        
                        //If it does exist update the position on the screen
                        TrackedFinger* sprite = [trackableList objectForKey:fingerID];
                        sprite.position = [self covertLeapCoordinates:CGPointMake(finger.tipPosition.x, finger.tipPosition.y)];
                        sprite.updated = TRUE;
                        
                        [self updateFingerDraw:sprite];
                        
                        //SimplePoint* simplePoint = [[SimplePoint alloc] initWithPosition:sprite.position];

                        
                    }else{
                        
                        //NSLog(@"x %0.0f y %0.0f z %0.0f", finger.tipPosition.x, finger.tipPosition.y, finger.tipPosition.z);
                        // CGPoint point = [[CCDirector sharedDirector] convertEventToGL:event];
                        //CGPoint mouseLocation = [self convertToNodeSpace:point];
                        
                        //Add it to the dictionary
                        //TrackedFinger* redDot = [self addRedDot:[self covertLeapCoordinates:CGPointMake(finger.tipPosition.x, finger.tipPosition.y)] finger:fingerID];
                        TrackedFinger* redDot = [[TrackedFinger alloc] initWithID:fingerID withPosition:[self covertLeapCoordinates:CGPointMake(finger.tipPosition.x, finger.tipPosition.y)]];
                        [trackableList setObject:redDot forKey:fingerID];
                        
                        [self beginFingerDraw:redDot];
                        
                    }
                }
                
            }
            
            avgPos = [avgPos divide:[fingers count]];
            
            //NSLog(@"Hand has %ld fingers, average finger tip position %@", [fingers count], avgPos);
            for (LeapFinger* finger in fingers){
                
                //NSLog(@"Finger ID %d %ld", finger.id, (unsigned long)[finger hash]);
            }
            
        }
        
        //
        [self checkFingerExists];
    }
    
}


/*
- (void)drawRect:(NSRect)dirtyRect
{
    NSLog(@"drawRect");
    // Drawing code here.
    // colour the background white
    
	[[NSColor whiteColor] set];		// this is Cocoa
	NSRectFill( dirtyRect );
	
	if ([myMutaryOfBrushStrokes count] == 0) {
		return;
	} // end if
	
	// This is Quartz
	NSGraphicsContext	*	tvarNSGraphicsContext	= [NSGraphicsContext currentContext];
	CGContextRef			tvarCGContextRef		= (CGContextRef) [tvarNSGraphicsContext graphicsPort];
	
	NSUInteger tvarIntNumberOfStrokes	= [myMutaryOfBrushStrokes count];
	
	NSUInteger i;
	for (i = 0; i < tvarIntNumberOfStrokes; i++) {
    
		CGContextSetRGBStrokeColor(tvarCGContextRef,[self randVar],[self randVar],[self randVar],[self randVar]);
		CGContextSetLineWidth(tvarCGContextRef, (1.0 + ([self randVar] * 10.0)) );
        
		myMutaryOfPoints	= [myMutaryOfBrushStrokes objectAtIndex:i];
		
		NSUInteger tvarIntNumberOfPoints	= [myMutaryOfPoints count];				// always >= 2
		MyPoint * tvarLastPointObj			= [myMutaryOfPoints objectAtIndex:0];
		CGContextBeginPath(tvarCGContextRef);
		CGContextMoveToPoint(tvarCGContextRef,[tvarLastPointObj x],[tvarLastPointObj y]);
		
		NSUInteger j;
		for (j = 1; j < tvarIntNumberOfPoints; j++) {  // note the index starts at 1
			MyPoint * tvarCurPointObj			= [myMutaryOfPoints objectAtIndex:j];
			CGContextAddLineToPoint(tvarCGContextRef,[tvarCurPointObj x],[tvarCurPointObj y]);
		} // end for
		
		CGContextDrawPath(tvarCGContextRef,kCGPathStroke);
		
	} // end for
    
    
}
 
 */

- (void)drawRect:(NSRect)dirtyRect
{
    //NSLog(@"drawRect");
    // Drawing code here.
    // colour the background white
    
	[[NSColor whiteColor] set];		// this is Cocoa
	NSRectFill( dirtyRect );
	
	if ([myMutaryOfBrushStrokes count] == 0) {
		return;
	} // end if
	
	// This is Quartz
	NSGraphicsContext	*	tvarNSGraphicsContext	= [NSGraphicsContext currentContext];
	CGContextRef			tvarCGContextRef		= (CGContextRef) [tvarNSGraphicsContext graphicsPort];
	
	NSUInteger tvarIntNumberOfStrokes	= [myMutaryOfBrushStrokes count];
	
	NSUInteger i;
	for (i = 0; i < tvarIntNumberOfStrokes; i++) {
        
        
		drawingTool	= [myMutaryOfBrushStrokes objectAtIndex:i];
        CGFloat red, green, blue, a;
        [drawingTool.primaryColor getRed:&red green:&green blue:&blue alpha:&a];
        
		CGContextSetRGBStrokeColor(tvarCGContextRef, red,green,blue,a);
		CGContextSetLineWidth(tvarCGContextRef, drawingTool.lineWidth );
        
				
		NSUInteger tvarIntNumberOfPoints	= [drawingTool.points count];//[myMutaryOfPoints count];				// always >= 2
		MyPoint * tvarLastPointObj			= [drawingTool.points objectAtIndex:0];
		CGContextBeginPath(tvarCGContextRef);
		CGContextMoveToPoint(tvarCGContextRef,[tvarLastPointObj x],[tvarLastPointObj y]);
		
		NSUInteger j;
		for (j = 1; j < tvarIntNumberOfPoints; j++) {  // note the index starts at 1
			MyPoint * tvarCurPointObj			= [drawingTool.points objectAtIndex:j];
			CGContextAddLineToPoint(tvarCGContextRef,[tvarCurPointObj x],[tvarCurPointObj y]);
		} // end for
		
		CGContextDrawPath(tvarCGContextRef,kCGPathStroke);
		
	} // end for
    
    
}

/*
-(void)mouseDown:(NSEvent *)pTheEvent {
    
    //Selected Tool
    //NSLog(@"Mouse Down");
    
    DrawingTool *drawingTool = [self activeTool];
    if (drawingTool) {

        NSPoint tvarMousePointInWindow	= [pTheEvent locationInWindow];
        NSPoint tvarMousePointInView	= [self convertPoint:tvarMousePointInWindow fromView:self];
        [drawingTool inputBegan:pTheEvent locationInView:tvarMousePointInView withSettings:self.toolSettings];
    }

    

	
} // end mouseDown

-(void)mouseDragged:(NSEvent *)pTheEvent {
    
    //NSLog(@"Mouse Dragg");
    
    DrawingTool *drawingTool = [self activeTool];
    if (drawingTool) {

        NSPoint tvarMousePointInWindow	= [pTheEvent locationInWindow];
        NSPoint tvarMousePointInView	= [self convertPoint:tvarMousePointInWindow fromView:self];
        [drawingTool inputMoved:pTheEvent locationInView:tvarMousePointInView];

    }

	
} // end mouseDragged

-(void)mouseUp:(NSEvent *)pTheEvent {
    
    //NSLog(@"Mouse up");

    DrawingTool *drawingTool = [self activeTool];
    if (drawingTool) {
 
        
        NSPoint tvarMousePointInWindow	= [pTheEvent locationInWindow];
        NSPoint tvarMousePointInView	= [self convertPoint:tvarMousePointInWindow fromView:self];
        [drawingTool inputEnded:pTheEvent locationInView:tvarMousePointInView];
        
    }

    
} // end mouseUp
 
 */

 

/*
-(void)mouseDown:(NSEvent *)pTheEvent {
    
	myMutaryOfPoints	= [[NSMutableArray alloc]init];
	[myMutaryOfBrushStrokes addObject:myMutaryOfPoints];
	
	NSPoint tvarMousePointInWindow	= [pTheEvent locationInWindow];
	NSPoint tvarMousePointInView	= [self convertPoint:tvarMousePointInWindow fromView:nil];
	MyPoint * tvarMyPointObj		= [[MyPoint alloc]initWithNSPoint:tvarMousePointInView];
	
	[myMutaryOfPoints addObject:tvarMyPointObj];
	
} // end mouseDown

-(void)mouseDragged:(NSEvent *)pTheEvent {
    
	NSPoint tvarMousePointInWindow	= [pTheEvent locationInWindow];
	NSPoint tvarMousePointInView	= [self convertPoint:tvarMousePointInWindow fromView:nil];
	MyPoint * tvarMyPointObj		= [[MyPoint alloc]initWithNSPoint:tvarMousePointInView];
	
	[myMutaryOfPoints addObject:tvarMyPointObj];
    
	[self setNeedsDisplay:YES];
	
} // end mouseDragged

-(void)mouseUp:(NSEvent *)pTheEvent {
    
	NSPoint tvarMousePointInWindow	= [pTheEvent locationInWindow];
	NSPoint tvarMousePointInView	= [self convertPoint:tvarMousePointInWindow fromView:nil];
	MyPoint * tvarMyPointObj		= [[MyPoint alloc]initWithNSPoint:tvarMousePointInView];
	
	[myMutaryOfPoints addObject:tvarMyPointObj];
    
	[self setNeedsDisplay:YES];
    	
} // end mouseUp

*/


- (void)beginFingerDraw:(id)sender{
    
    TrackedFinger* trackedFinger = (TrackedFinger*)sender;
    [self beginDraw:trackedFinger.position withFinger:trackedFinger];
    
}

- (void)updateFingerDraw:(id)sender{
    TrackedFinger* trackedFinger = (TrackedFinger*)sender;
    [self updateDraw:trackedFinger.position withFinger:trackedFinger];
    
}

- (void)endFingerDraw:(id)sender{
    TrackedFinger* trackedFinger = (TrackedFinger*)sender;
    [self endDraw:trackedFinger.position withFinger:trackedFinger];
}


//The further negative, the thicker the line.
- (void)beginDraw:(CGPoint)point withFinger:(TrackedFinger*)finger{
    
    //if there is no finger, we are drawing with the mouse
    if(finger == nil){
        drawingTool	= [[LPDrawingTool alloc] initWithWidth:currentLineWidth withTransparency:1 withPrimaryColor:currentColor withSecondaryColor:[NSColor redColor]];
        
        [myMutaryOfBrushStrokes addObject:drawingTool];
        MyPoint * tvarMyPointObj		= [[MyPoint alloc]initWithNSPoint:point];
        [drawingTool.points addObject:tvarMyPointObj];
    }else{
        drawingTool	= [[LPDrawingTool alloc] initWithWidth:currentLineWidth withTransparency:1 withPrimaryColor:currentColor withSecondaryColor:[NSColor redColor]];
        finger.tool = drawingTool;
        [myMutaryOfBrushStrokes addObject:drawingTool];
        MyPoint * tvarMyPointObj		= [[MyPoint alloc]initWithNSPoint:point];
        [drawingTool.points addObject:tvarMyPointObj];
    }
    
}

- (void)updateDraw:(CGPoint)point withFinger:(TrackedFinger*)finger{
    
    if(finger == nil){
        MyPoint * tvarMyPointObj		= [[MyPoint alloc]initWithNSPoint:point];
        [drawingTool.points addObject:tvarMyPointObj];
        [self setNeedsDisplay:YES];
    }else{
        MyPoint * tvarMyPointObj		= [[MyPoint alloc]initWithNSPoint:point];
        drawingTool	= finger.tool;
        [drawingTool.points addObject:tvarMyPointObj];
        [self setNeedsDisplay:YES];
    }
}

- (void)endDraw:(CGPoint)point withFinger:(TrackedFinger*)finger {
    
   if(finger == nil){
       MyPoint * tvarMyPointObj		= [[MyPoint alloc]initWithNSPoint:point];
       [drawingTool.points addObject:tvarMyPointObj];
       [self setNeedsDisplay:YES];
       
   }else{
       MyPoint * tvarMyPointObj		= [[MyPoint alloc]initWithNSPoint:point];
       drawingTool	= finger.tool;
       [drawingTool.points addObject:tvarMyPointObj];
       [self setNeedsDisplay:YES];
   }
    
}


-(void)mouseDown:(NSEvent *)pTheEvent {
    NSPoint tvarMousePointInWindow	= [pTheEvent locationInWindow];
	NSPoint tvarMousePointInView	= [self convertPoint:tvarMousePointInWindow fromView:nil];
    
    [self beginDraw:tvarMousePointInView withFinger:nil];
	
} // end mouseDown

-(void)mouseDragged:(NSEvent *)pTheEvent {
    
	NSPoint tvarMousePointInWindow	= [pTheEvent locationInWindow];
	NSPoint tvarMousePointInView	= [self convertPoint:tvarMousePointInWindow fromView:nil];
    
    [self updateDraw:tvarMousePointInView withFinger:nil];

	
} // end mouseDragged

-(void)mouseUp:(NSEvent *)pTheEvent {
    
	NSPoint tvarMousePointInWindow	= [pTheEvent locationInWindow];
	NSPoint tvarMousePointInView	= [self convertPoint:tvarMousePointInWindow fromView:nil];
    
    [self endDraw:tvarMousePointInView withFinger:nil];

    
} // end mouseUp


- (float)randVar;
{
	return ( (float)(rand() % 10000 ) / 10000.0);
} // end randVar


- (DrawingTool*)activeTool {
    
    for (DrawingTool *tool in self.drawingTools) {
        if ([tool.toolName isEqualToString:self.toolSettings.drawingTool]) {
            return tool;
        }
    }
    return nil;
}


- (LPDrawingTool*)getActiveTool{
    
    if (selectedTool )


    return nil;
}

- (void)initializeTools {
    
    self.drawingTools = [[NSMutableArray alloc] init];
    
    //pen tool
    DrawingTool *tool = [[PenTool alloc] initWithCompletion:^{
        
        //[self addDrawingToUndoStack];
        NSLog(@"Tool Completion");
        
    }];
    tool.toolName = @"Pen";
    tool.imageName = @"pen-ink-mini.png";
    [self.drawingTools addObject:tool];
    
    
    
    
}


- (void)clearScreen{
    
    [myMutaryOfBrushStrokes removeAllObjects];
    [self setNeedsDisplay:YES];
}

- (void)setColor:(NSColor*)color{
    
    currentColor = color;
}

- (void)setLineWidth:(float)w{
    
    currentLineWidth = w;
    
}

- (void)setTool:(NSString*)tool{
    selectedTool =  tool;
}

- (CGPoint)covertLeapCoordinates:(CGPoint)p{
    
    CGRect rect = NSRectToCGRect([self bounds]);
    CGSize s = rect.size;
    float screenCenter = 0.0f;
    float xScale = 1.75f;
    float yScale = 1.25f;
    return CGPointMake((s.width/2)+ (( p.x - screenCenter) * xScale), p.y * yScale);
}

- (void)checkFingerExists{
    
    for (id key in [trackableList allKeys]) {
        TrackedFinger* sprite = [trackableList objectForKey:key];
        if (sprite.updated) {
            sprite.updated = FALSE;
            //return;
        }else{
            [self endFingerDraw:sprite];
            [trackableList removeObjectForKey:key];
            
        }
    }
}

@end
