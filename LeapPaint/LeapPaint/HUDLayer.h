//
//  HUDLayer.h
//  LeapPuzz
//
//  Created by cj on 4/1/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "LPTool.h"
#import "LeapObjectiveC.h"
#import "SimplePoint.h"
#import "GameSettings.h"


/** HUD Delegate Protocol
 User inferface controls for operating buttons, switches, sliders
 */
@protocol HUDDelegate <NSObject>
/**
 Calls back to notify a new input mode has been selected by the keyboard interface
 @param mode is the state of the input mode
 */
- (void)changeMode:(InputMode)mode;
/**
 Calls back to notify a new change in painting state
 @param paintingState 
 */
- (void)painting:(BOOL)paintingState;

@end

/** HUD Layer
 Tracks the position of the LeapCursor on the screen
 */
@interface HUDLayer : CCLayer  {
    NSString* primaryToolID;    /**< primaryToolID stores the id tag to the pointable in reference*/
    LPTool* primaryTool;        /**< primaryTool points to the current pointable  object*/
    
    InputMode inputMode;        /**< inputMode is the current mode of input*/
    
    ccColor3B lastColor;        /**< lastColor is the lastColor to be selected */
    ccColor3B previousColor;    /**< previousColor is the color before the lastcolor to be selected */
    NSString* lastBrush;        /**< lastBrush is last brush to be selected */
    float lastScale;            /**< lastScale is last scale to be selected */

    
    
    CCSprite* paintingIndicator; /**< paintingIndicator shows the state at which the object is currently paintg */
    BOOL eraseMode;             /**< eraseMode determines weather the pointable is painting or erasing */
                            
    
    GameSettings* gameSettings; /**< gameSettings singleton to global seetings*/


}

@property (nonatomic, weak) id <HUDDelegate> delegate; /**< colorLabel displays name of color in hash value */
@property (nonatomic, strong) CCLabelTTF* xyzcoords; /**< xyzcoords is the X,Y,Z coordinates in string form for displaying on the HUD in real-time for debugging */


/**
 ToolMoved updates the last known tracked position of the tool.
 @param point is the coordinate location on the screen in which pointable interesects
 @param toolid is LeapSDK provided tool id of the tool moving
 */
- (void)toolMoved:(CGPoint)point toolID:(NSString*)toolid;
/**
 StartTrackingTool begins the process of tracking a tool starting with a new path
 @param point is the coordinate location on the screen in which pointable interesects
 @param toolid is LeapSDK provided tool id of the tool moving
 */
- (void)startTrackingTool:(CGPoint)point toolID:(NSString*)toolid;
/**
 MoveTrackingTool updates the position and path of a tool.
 @param point is the coordinate location on the screen in which pointable interesects
 @param toolid is LeapSDK provided tool id of the tool moving
 */
- (void)moveTrackingTool:(CGPoint)point toolID:(NSString*)toolid;
/**
 EndTracking tool singles the end of the tool being tracked. 
 The tool may be lost or no longer drawing
 */
- (void)endTrackingTool;


- (void)changeColor:(ccColor3B)color;
- (void)changeBrush:(NSString*)brushname;
- (void)changeScale:(float)size;
- (void)erasingMode:(BOOL)mode;

@end
