//
//  AppDelegate.m
//  LeapPaint
//
//  Created by cj on 5/7/13.
//  Copyright (c) 2013 cjdesch. All rights reserved.
//

#import "AppDelegate.h"
#import "GameScene.h"

@implementation AppDelegate

@synthesize window=window_, glView=glView_;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification{
    // Insert code here to initialize your application
    [self runGameScene];
}
- (void)runGameScene{
    
    CCDirectorMac *director = (CCDirectorMac*) [CCDirector sharedDirector];
    
    //NSRect screensFrame = [[NSScreen mainScreen] frame];
    NSRect screensFrame = [[NSScreen mainScreen] visibleFrame];
    [glView_ setFrameSize:NSMakeSize(screensFrame.size.width,screensFrame.size.height)];
	// enable FPS and SPF
	[director setDisplayStats:YES];
	// connect the OpenGL view with the director
	[director setView:glView_];
	// EXPERIMENTAL stuff.
	// 'Effects' don't work correctly when autoscale is turned on.
	// Use kCCDirectorResize_NoScale if you don't want auto-scaling.
	[director setResizeMode:kCCDirectorResize_AutoScale];
    
    //[glView_ setFrameSize:NSMakeSize(window_.frame.size.width,window_.frame.size.height-42)];
	// Enable "moving" mouse event. Default no.
	[window_ setAcceptsMouseMovedEvents:NO];
	
	// Center main window
	[window_ center];
    
    CCScene* scene  = [GameScene scene];
	[director runWithScene:scene];
}
#pragma mark AppDelegate - IBActions
- (IBAction)toggleFullScreen: (id)sender{
	CCDirectorMac *director = (CCDirectorMac*) [CCDirector sharedDirector];
	[director setFullScreen: ! [director isFullScreen] ];
}




@end
