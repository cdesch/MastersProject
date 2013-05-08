//
//  CanvasView.m
//  Paint
//
//  Created by Andy Finnell on 8/15/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import "CanvasView.h"
#import "Canvas.h"
#import "Brush.h"

@implementation CanvasView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Create both the canvas and the brush. Create the canvas
		//	the same size as our initial size. Note that the canvas will not
		//	resize along with us.
		canvas = [[Canvas alloc] initWithSize:frame.size];
		brush = [[Brush alloc] init];
    }
    return self;
}



- (void)drawRect:(NSRect)rect {
    NSLog(@"Canvas DrawRect");
	// Simply ask the canvas to draw into the current context, given the
	//	rectangle specified. A more sophisticated view might draw a border
	//	around the canvas, or a pasteboard in the case that the view was
	//	bigger than the canvas.
	NSGraphicsContext* context = [NSGraphicsContext currentContext];
	
	[canvas drawRect:rect inContext:context];	
}

- (void)mouseDown:(NSEvent *)theEvent
{
    NSLog(@"Canvas Mouse Down");
	// Simply pass the mouse event to the brush. Also give it the canvas to
	//	work on, and a reference to ourselves, so it can translate the mouse
	//	locations.
	[brush mouseDown:theEvent inView:self onCanvas:canvas];
    
    [self setNeedsDisplay:YES];
    
    
}

- (void)mouseDragged:(NSEvent *)theEvent
{
    NSLog(@"Canvas Mouse Dragged");
	// Simply pass the mouse event to the brush. Also give it the canvas to
	//	work on, and a reference to ourselves, so it can translate the mouse
	//	locations.	
	[brush mouseDragged:theEvent inView:self onCanvas:canvas];
}

- (void)mouseUp:(NSEvent *)theEvent
{
	// Simply pass the mouse event to the brush. Also give it the canvas to
	//	work on, and a reference to ourselves, so it can translate the mouse
	//	locations.	
	[brush mouseUp:theEvent inView:self onCanvas:canvas];
    
    
}

@end
