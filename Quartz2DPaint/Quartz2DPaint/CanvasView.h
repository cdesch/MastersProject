//
//  CanvasView.h
//  Paint
//
//  Created by Andy Finnell on 8/15/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//



@class Canvas;
@class Brush;

@interface CanvasView : NSView {
	// The canvas we will render to the screen
	Canvas		*canvas;
	// The brush that we will pass events to
	Brush		*brush;
}

@end
