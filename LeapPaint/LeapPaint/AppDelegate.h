//
//  AppDelegate.h
//  LeapPaint
//
//  Created by Christopher Desch on 5/7/13.
//  Copyright Christopher Desch 2013. All rights reserved. Refer to license file. 
//

#import "cocos2d.h"

@interface LeapPaintAppDelegate : NSObject <NSApplicationDelegate>
{
	NSWindow	*window_;
	CCGLView	*glView_;
}

@property (assign) IBOutlet NSWindow	*window;
@property (assign) IBOutlet CCGLView	*glView;

- (IBAction)toggleFullScreen:(id)sender;

@end
