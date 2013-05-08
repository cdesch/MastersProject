//
//  AppDelegate.h
//  LeapPaint
//
//  Created by cj on 5/7/13.
//  Copyright (c) 2013 cjdesch. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "cocos2d.h"

/** Application Delegate 
 Creates app instance and binds libraries to interface builder xibs
 
 Serves as an application wide callback object for events that affects the whole application, such as low-memory, etc.
 */
@interface AppDelegate : NSObject <NSApplicationDelegate>
{

    NSWindow	*window_;  /**< window is the main window to be displayed */
    CCGLView	*glView_;  /**< glView is the embedded view in which cocos2d will run inside the window */
}
@property (strong) IBOutlet NSWindow *window;
@property (strong) IBOutlet CCGLView *glView;

/** RunGameSceen sets up the Cocos2d environment and runs it in the application.
 */
- (void)runGameScene;

/** Toggles from a window to full screen view point
 @param sender is the action sending the command
 @return IBAction binding to interface builder
 */
- (IBAction)toggleFullScreen:(id)sender;

@end
