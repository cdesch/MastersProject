//
//  SketchRenderTextureScene.h
//  Cocos2D-CCRenderTexture-Demo
//
//  Copyright (c) 2011 Steffen Itterheim.
//	Distributed under MIT License.
//

#import "cocos2d.h"
#import "SimplePoint.h"
#import "GameSettings.h"
@interface SketchRenderTextureScene : CCLayer
{
	CCSprite* brush;
	NSMutableArray* touches;

    
    ccColor3B lastColor;
    ccColor3B previousColor;
    NSString* lastBrush;
    float lastScale;
    bool eraseMode;
    

    
}

@property (nonatomic,readwrite) float opacity;

- (void)beginDraw:(CGPoint)point withZ:(float)z;
- (void)updateDraw:(CGPoint)point withZ:(float)z;
- (void)endDraw:(CGPoint)point;

- (void)changeColor:(ccColor3B)color;
- (void)changeBrush:(NSString*)brushname;
- (void)changeScale:(float)size;
- (void)changeOpacity:(float)o;
- (void)erasingMode:(BOOL)mode;

- (void)clearDrawing;
@end
