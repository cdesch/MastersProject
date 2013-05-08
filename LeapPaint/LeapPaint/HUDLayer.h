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

- (void)changeMode:(InputMode)mode;
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
@property (nonatomic, strong) CCLabelTTF* xyzcoords;



- (void)toolMoved:(CGPoint)point toolID:(NSString*)toolid;
- (void)startTrackingTool:(CGPoint)point toolID:(NSString*)toolid;
- (void)moveTrackingTool:(CGPoint)point toolID:(NSString*)toolid;
- (void)endTrackingTool;
- (void)changeColor:(ccColor3B)color;
- (void)changeBrush:(NSString*)brushname;
- (void)changeScale:(float)size;

- (void)erasingMode:(BOOL)mode;

@end
