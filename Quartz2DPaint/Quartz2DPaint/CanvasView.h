//
//  CanvasView.h
//  Paint
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
