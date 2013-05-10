//
//  HelloWorldScene.h
//  Cocos2DBreakout2
//


#import "cocos2d.h"
#import "Box2D.h"
#import "MyContactListener.h"
#import "LeapObjectiveC.h"

@interface HelloWorld : CCLayer <LeapDelegate>{
    b2World *_world;
    b2Body *_groundBody;
    b2Body *_paddleBody;    
    b2Fixture *_paddleFixture;
    b2Fixture *_ballFixture;
    b2Fixture *_bottomFixture;
    b2MouseJoint *_mouseJoint;
    b2MouseJoint *_fingerJoint;
    MyContactListener *_contactListener;
    
    LeapController *controller;
    NSMutableDictionary* trackableList;
    BOOL fingerTracked;
}

+ (id) scene;

@end
