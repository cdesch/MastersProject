//
//  GameManager.h
//  LeapPuzz
//
//  Created by cj on 4/2/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "LeapObjectiveC.h"
#import "HUDLayer.h"


#import "SketchRenderTextureScene.h"
#import "BackgroundLayer.h"
#import "ControlsLayer.h"
#import "GameSettings.h"
#import "SimplePoint.h"

/**
 Core Application Management
 Provides interfaces and controls the various inputs, controls and outputs
 
 */
@interface GameManager : CCScene <LeapListener, HUDDelegate, ControlsLayerDelegate>
{
    InputMode inputMode;    /**< colorLabel displays name of color in hash value */
    LeapPointable* currentPointable; /**< colorLabel displays name of color in hash value */
    CGPoint currentPoint;   /**< colorLabel displays name of color in hash value */
    //Settings
    BOOL painting;      /**< painting indicates wether or not the application is painting at that moment*/
    
    GameSettings* gameSettings; /**< gameSettings singleton to global seetings*/
    
    
    int lastTag;                /**< lastTag is the last tag value tracked of a LeapPointable */
    SimplePoint* lastPoint;     /**< lastPoint is the last known point on the screen of the LeapPointable */
    int framesSinceLastFound;   /**< framesSinceLastFound number of frames since last finding a LeapPointable */

    
}

@property (nonatomic,strong) HUDLayer* hudLayer;                    /**< hudLayer displays the icons for tracking where a leapPointable is pointing */
@property (nonatomic,strong) SketchRenderTextureScene* textureScene;/**< textureScene is the drawing layer */
@property (nonatomic,strong) BackgroundLayer* backgroundLayer;      /**< backgroundLayer is the layer for setting up the background */
@property (nonatomic,strong) ControlsLayer* controlsLayer;          /**< controlsLayer is the layer for managing interface controls */

@property (nonatomic,strong) LeapController* controller;            /**< controller is the leapController */
@property (nonatomic,strong) LeapScreen* leapScreen;                /**< leapScreen references the screen being used on the system */

/**
 Finds the percentage of a number between two values
 If the number is greater or less than the range, that boundry of the range will be returned.
 @param max is the top range value
 @param min is the bottom range value
 @param value is the number we are seeking the percentage from
 @return the a percentage between 0 and 100%
 */
- (float)findPecentageDifference:(float)max withMin:(float)min withValue:(float)value;

/**
 Determines the opacity based upon the Z axis coordinate
 @param value is the Z axis coordinate
 @return the opacity value to set the brush at. 
 */
- (float)opacityPercentage:(float)value;

@end
