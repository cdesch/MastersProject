//
//  HelloWorldLayer.h
//  LeapPuzz
//
//  Created by cj on 2/3/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "LeapObjectiveC.h"
#import "RedDot.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <LeapDelegate>
{
    
    LeapController *controller;
    
	CCTexture2D *spriteTexture_;	// weak ref
	b2World* world;					// strong ref
	GLESDebugDraw *m_debugDraw;		// strong ref
    
    CCSprite* targetSprite;
    b2MouseJoint *_mouseJoint;
    b2World* _world;
    b2Body *_groundBody;
    
       
    NSMutableDictionary* trackableList;
    
}
@end

