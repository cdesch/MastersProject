//
//  LPCCControlButtonVariableSize.h
//  LeapPuzz
//
//  Created by cj on 4/9/13.
//
//
#import "cocos2d.h"
#import "CCControlExtension.h"

@interface LPCCControlButtonVariableSize : CCLayer
/** Creates and return a button with a default background and title color. */
- (CCControlButton *)standardButtonWithTitle:(NSString *)title;
@end
