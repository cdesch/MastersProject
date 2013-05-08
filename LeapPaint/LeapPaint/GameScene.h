//
//  GameScene.h
//  LeapPuzz
//
//  Created by cj on 4/1/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "HUDLayer.h"
#import "GameManager.h"
#import "LeapObjectiveC.h"
#import "SketchRenderTextureScene.h"
#import "BackgroundLayer.h"
#import "ControlsLayer.h"

/**
 GameScene 
 Initializes and assembles all of the layers and gameobjects into the GameManager
 */
@interface GameScene : CCScene
/**
 Scene initializes each object and assigns interlinking pointers and delegates to each class
 @return scene for CCDirector to begin running
 */
+(CCScene *) scene;
@end
