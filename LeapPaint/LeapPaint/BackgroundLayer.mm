//
//  BackgroundLayer.m
//  LeapPuzz
//
//  Created by cj on 4/9/13.
//
//

#import "BackgroundLayer.h"

@implementation BackgroundLayer

/** init */
- (id)init
{
	if ((self = [super init]))
	{
		// Get window size
		CGSize size = [[CCDirector sharedDirector] winSize];
		
		// Add a button which takes us back to HelloWorldScene
		
        // Add the generated background
        CCSprite *background = [CCSprite spriteWithFile:@"background-fullscreen.png"];
        [background setPosition:ccp(size.width / 2, size.height / 2)];

        [self addChild:background];

	}
	return self;
}

@end
