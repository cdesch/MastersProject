//
//  ControlsLayer.h
//  LeapPuzz
//
//  Created by cj on 4/9/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCControlExtension.h"
#import "BrushSelectionLayer.h"
#import "GameSettings.h"
/**
 Controls Layer Delegate
Provides a delegate interface for the layer to notify of actions
 */
@protocol ControlsLayerDelegate <NSObject>
/**
 Callback with a change in color of the brush
 @param color is the new selected color value
 */
- (void)changeColorControl:(ccColor3B)color;
/**
 Callback with a change in thickness of the brush
 @param value is the new selected color value
 */
- (void)changeThicknessControl:(float)value;
/**
 Callback with a change in brush texture
 @param brushname is the new selected brush value
 */
- (void)changeBrushControl:(NSString*)brushname;
/**
 Callback with a change in opacity
 @param value is the new selected opacity value
 */
- (void)changeOpacityControl:(float)value;
/**
 Callback to notify to clear the drawing
 */
- (void)clearDrawing;
/**
 Callback with a change in color
 @param mode is the  toggled eraser mode
 TODO: Turn off eraser mode when new color is selected
 */
- (void)eraserMode:(bool)mode;
@end

/** Controls Layer
    User inferface controls for operating buttons, switches, sliders
 */

@interface ControlsLayer : CCLayer <BrushSelectionLayerDelegate>{
    CCLabelTTF *colorLabel;         /**< colorLabel displays name of color in hash value */
    CCLabelTTF *displayValueLabel;  /**< displayValueLabel displays coordinate */
    GameSettings* gameSettings;     /**< gameSettings global reference to shared settings instance */
}
@property (nonatomic, strong) CCControlSlider   *slider;                    /**< slider is the thickness control of the brush */
@property (nonatomic, strong) CCControlSlider   *opacitySlider;             /**< opacitySlider is the opacity contro of the brush*/
@property (nonatomic, strong) CCControlSwitch   *opacitySwitchControl;      /**< opacitySwitchControl is the control for setting automatic or manual opacity control */
@property (nonatomic, strong) CCLabelTTF        *opacitydisplayValueLabel;  /**<  opacitydisplayValueLabel shows the state of the opacitySwitchControl*/
@property (nonatomic, weak) id <ControlsLayerDelegate> delegate;            /**< delegate is the instance reference for triggering delegate call back functions */
@property (nonatomic,strong) BrushSelectionLayer *brushSelection;           /**< brushSelection layer expands as a drawer to allow for brush selection */
@property (nonatomic, strong) CCLabelTTF        *displayValueLabel;         /**< displayValueLabel displays eraser toggle state */
@property (nonatomic, strong) CCControlSwitch   *switchControl;             /**< switchControl is the eraser toggle */

/**
 Recieves brushSizeControl delegate callbacks and updates values in the interface
 @param sender is the object performing the callback
 */
- (void)valueChanged:(CCControlSlider *)sender;

/**
 Recieves opacitySliderControl delegate callbacks and updates values in the interface
 @param sender is the object performing the callback
 */
- (void)opacitySliderChanged:(CCControlSlider *)sender;

/** Expands brushes panel*/
- (void)expandPanel;
/** Collapses Brushes Panel */
- (void)collapsePanel;

/** Creates and returns a new CCControlSwitch. 
 @return a generate ControlSwitch
 */
- (CCControlSwitch *)makeControlSwitch;
/** Callback for the change value. 
  @param sender is the object performing the callback*/
- (void)switchValueChanged:(CCControlSwitch *)sender;
/** Callback for opacity changing with the slider 
  @param sender is the object performing the callback
 */
- (void)updateOpacitySlider:(float)value;

@end
