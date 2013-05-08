//
//  MyPoint.h
//  010-NSView
//
// wrapper for NSPoint
#import <Cocoa/Cocoa.h>

@interface MyPoint : NSObject {
	NSPoint myNSPoint;
}
- (id) initWithNSPoint:(NSPoint)pNSPoint;
- (NSPoint) myNSPoint;
- (float)x;
- (float)y;

@end
