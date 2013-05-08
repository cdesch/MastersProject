//
//  Brush.h
//  Paint
//
//  Created by Andy Finnell on 8/15/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//



@class Canvas;

@interface Brush : NSObject {
	// Information about the brush that's always used
	float				mRadius;
	CGMutablePathRef	mShape;
	CGColorRef			mColor;
	float				mSoftness; // 0.0 - 1.0, 0.0 being hard, 1.0 be all soft
	BOOL				mHard; // should have a hard edge?
	
	// Cached information that's only used when actually tracking/drawing
	CGImageRef			mMask;
	NSPoint				mLastPoint;
	float				mLeftOverDistance;
}

- (void) mouseDown:(NSEvent *)theEvent inView:(NSView *)view onCanvas:(Canvas *)canvas;
- (void) mouseDragged:(NSEvent *)theEvent inView:(NSView *)view onCanvas:(Canvas *)canvas;
- (void) mouseUp:(NSEvent *)theEvent inView:(NSView *)view onCanvas:(Canvas *)canvas;

@end
