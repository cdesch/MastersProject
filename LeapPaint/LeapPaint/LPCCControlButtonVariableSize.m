//
//  LPCCControlButtonVariableSize.m
//  LeapPuzz
//
//  Created by cj on 4/9/13.
//
//

#import "LPCCControlButtonVariableSize.h"

@implementation LPCCControlButtonVariableSize
- (id)init
{
    if ((self = [super init]))
    {
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        // Defines an array of title to create buttons dynamically
        NSArray *stringArray = [NSArray arrayWithObjects:@"Hello",@"Variable",@"Size",@"!", nil];
        
        CCNode *layer = [CCNode node];
        [self addChild:layer z:1];
        
        double total_width = 0, height = 0;
        
        // For each title in the array
        for (NSString *title in stringArray)
        {
            // Creates a button with this string as title
            CCControlButton *button = [self standardButtonWithTitle:title];
            [button setPosition:ccp (total_width + button.contentSize.width / 2, button.contentSize.height / 2)];
            [layer addChild:button];
            
            // Compute the size of the layer
            height = button.contentSize.height;
            total_width += button.contentSize.width;
        }
        
        [layer setAnchorPoint:ccp (0.5, 0.5)];
        [layer setContentSize:CGSizeMake(total_width, height)];
        [layer setPosition:ccp(screenSize.width / 2.0f, screenSize.height / 2.0f)];
        
        // Add the black background
        CCScale9Sprite *background = [CCScale9Sprite spriteWithFile:@"buttonBackground.png"];
        [background setContentSize:CGSizeMake(total_width + 14, height + 14)];
        [background setPosition:ccp(screenSize.width / 2.0f, screenSize.height / 2.0f)];
        [self addChild:background];
    }
    return self;
}

#pragma mark -
#pragma CCControlButtonTest_HelloVariableSize Public Methods

#pragma CCControlButtonTest_HelloVariableSize Private Methods

- (CCControlButton *)standardButtonWithTitle:(NSString *)title
{
    /** Creates and return a button with a default background and title color. */
    CCScale9Sprite *backgroundButton = [CCScale9Sprite spriteWithFile:@"button.png"];
    CCScale9Sprite *backgroundHighlightedButton = [CCScale9Sprite spriteWithFile:@"buttonHighlighted.png"];
    
#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
    CCLabelTTF *titleButton = [CCLabelTTF labelWithString:title fontName:@"HelveticaNeue-Bold" fontSize:30];
#elif __MAC_OS_X_VERSION_MAX_ALLOWED
    CCLabelTTF *titleButton = [CCLabelTTF labelWithString:title fontName:@"Marker Felt" fontSize:30];
#endif
    [titleButton setColor:ccc3(159, 168, 176)];
    
    CCControlButton *button = [CCControlButton buttonWithLabel:titleButton backgroundSprite:backgroundButton];
    [button setBackgroundSprite:backgroundHighlightedButton forState:CCControlStateHighlighted];
    [button setTitleColor:ccWHITE forState:CCControlStateHighlighted];
    
    return button;
}


@end
