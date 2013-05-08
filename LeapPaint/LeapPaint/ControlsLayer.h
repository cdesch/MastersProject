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
 */
 
@protocol ControlsLayerDelegate <NSObject>

- (void)changeColorControl:(ccColor3B)color;
- (void)changeThicknessControl:(float)value;
- (void)changeBrushControl:(NSString*)brushname;
- (void)changeOpacityControl:(float)value;
- (void)clearDrawing;
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
@property (nonatomic, strong) CCControlSlider   *slider;                    /**< colorLabel displays name of color in hash value */
@property (nonatomic, strong) CCControlSlider   *opacitySlider;             /**< colorLabel displays name of color in hash value */
@property (nonatomic, strong) CCControlSwitch   *opacitySwitchControl;      /**< colorLabel displays name of color in hash value */
@property (nonatomic, strong) CCLabelTTF        *opacitydisplayValueLabel;  /**< colorLabel displays name of color in hash value */
@property (nonatomic, weak) id <ControlsLayerDelegate> delegate;            /**< colorLabel displays name of color in hash value */
@property (nonatomic,strong) BrushSelectionLayer *brushSelection;           /**< colorLabel displays name of color in hash value */
@property (nonatomic, strong) CCLabelTTF        *displayValueLabel;         /**< colorLabel displays name of color in hash value */
@property (nonatomic, strong) CCControlSwitch   *switchControl;             /**< colorLabel displays name of color in hash value */

/**
 Does something
 @param slider  changes
 */
- (void)valueChanged:(CCControlSlider *)sender;

/**
 Does something
 @param slider  changes
 */
- (void)opacitySliderChanged:(CCControlSlider *)sender;

/** Expands brushes panel*/
- (void)expandPanel;
/** Collapses Brushes Panel */
- (void)collapsePanel;

/** Creates and returns a new CCControlSwitch. */
- (CCControlSwitch *)makeControlSwitch;
/** Callback for the change value. */
- (void)switchValueChanged:(CCControlSwitch *)sender;
/** Callback for opacity changing with the slider */
- (void)updateOpacitySlider:(float)value;

@end
