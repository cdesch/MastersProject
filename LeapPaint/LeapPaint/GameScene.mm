//
//  GameScene.m
//  LeapPuzz
//
//  Created by cj on 4/1/13.
//
//

#import "GameScene.h"

@implementation GameScene

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
    GameManager*scene = [GameManager node];
    
	HUDLayer* hudLayer = [HUDLayer node];
    BackgroundLayer* backgroundLayer = [BackgroundLayer node];
    ControlsLayer* controlsLayer = [ControlsLayer node];
    
    //setup delegates
    hudLayer.delegate = scene;
    controlsLayer.delegate = scene;
    

    SketchRenderTextureScene* textureScene = [SketchRenderTextureScene node];
    [scene addChild:backgroundLayer z:0];
    [scene addChild:controlsLayer z:3];
	// add layer as a child to scene
	[scene addChild:hudLayer z:5];


    [scene addChild:textureScene z:2];
    

    scene.hudLayer = hudLayer;
    scene.backgroundLayer = backgroundLayer;
    scene.controlsLayer = controlsLayer;

    scene.textureScene = textureScene;
    
	// return the scene
	return scene;
}
@end
