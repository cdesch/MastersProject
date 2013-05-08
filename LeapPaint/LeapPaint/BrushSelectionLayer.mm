//
//  BrushSelectionLayer.m
//  LeapPuzz
//
//  Created by cj on 4/9/13.
//
//

#import "BrushSelectionLayer.h"

@implementation BrushSelectionLayer
@synthesize delegate;
@synthesize layerHidden;
- (id)init
{
	if ((self = [super init]))
	{
		// Get window size
		CGSize size = [[CCDirector sharedDirector] winSize];
		
		// Add a button which takes us back to HelloWorldScene
        CCLabelTTF *titleButton = [CCLabelTTF labelWithString:@"BrushSelectionLayer" fontName:@"Marker Felt" fontSize:30];
        titleButton.position =ccp(size.width / 2.0f , 125);
        
        
        [self addChild:titleButton];
        // Add the generated background
        CCSprite *background = [CCSprite spriteWithFile:@"background-fullscreen.png"];
        [background setPosition:ccp(size.width / 2, size.height / 2)];
        self.layerHidden = true;
        [self addChild:background];
        
        [self buttoninit];
        
        int brushCount = 30;
        //NSMutableArray* menuItems = [[NSMutableArray alloc] init];
        imageNamesDictionary = [[NSMutableDictionary alloc] init];
        CCMenu *starMenu = [CCMenu menuWithItems:nil];
        for (int i =0; i < brushCount; i++){
            NSString* imagename = [NSString stringWithFormat:@"brush_%d.png",i];
            CCMenuItem *starMenuItem = [CCMenuItemImage
                                        itemWithNormalImage:imagename selectedImage:imagename
                                        target:self selector:@selector(brushSelectedAction:)];
            //starMenuItem.position = ccp(size.width /2, size.height /2);
            starMenuItem.tag = i;
            [imageNamesDictionary setObject:imagename forKey:[NSString stringWithFormat:@"%d",i]];
            
            
            
            [starMenu addChild:starMenuItem];
        }
        
        //[starMenu alignItemsHorizontally];
        NSNumber* itemsPerRow = [NSNumber numberWithInt:5];
        [starMenu alignItemsInColumns:itemsPerRow,itemsPerRow,itemsPerRow,itemsPerRow,itemsPerRow,itemsPerRow, nil];

        
        
        
        
        starMenu.position = ccp(size.width / 2, size.height / 2);
        [self addChild:starMenu];
        
	}
	return self;
}



- (void)buttoninit{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    // Add the button
    CCScale9Sprite *backgroundButton = [CCScale9Sprite spriteWithFile:@"button.png"];
    CCScale9Sprite *backgroundHighlightedButton = [CCScale9Sprite spriteWithFile:@"buttonHighlighted.png"];
    
#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
    CCLabelTTF *titleButton = [CCLabelTTF labelWithString:@"Touch Me!" fontName:@"HelveticaNeue-Bold" fontSize:30];
#elif __MAC_OS_X_VERSION_MAX_ALLOWED
    CCLabelTTF *titleButton = [CCLabelTTF labelWithString:@"Hide" fontName:@"Marker Felt" fontSize:30];
#endif
    [titleButton setColor:ccc3(159, 168, 176)];
    
    CCControlButton *controlButton = [CCControlButton buttonWithLabel:titleButton
                                                     backgroundSprite:backgroundButton];
    [controlButton setBackgroundSprite:backgroundHighlightedButton forState:CCControlStateHighlighted];
    [controlButton setTitleColor:ccWHITE forState:CCControlStateHighlighted];
    
    controlButton.anchorPoint = ccp(0.5f, 1);
    controlButton.position = ccp(screenSize.width / 2.0f, screenSize.height -100);
    [self addChild:controlButton z:1];
    
    // Add the black background
    CCScale9Sprite *background = [CCScale9Sprite spriteWithFile:@"buttonBackground.png"];
    [background setContentSize:CGSizeMake(300, 170)];
    [background setPosition:ccp(screenSize.width / 2.0f, screenSize.height / 2.0f)];
    //[self addChild:background];
    
    // Sets up event handlers
    [controlButton addTarget:self action:@selector(touchDownAction:) forControlEvents:CCControlEventTouchDown];
}

- (void)touchDownAction:(CCControlButton *)sender
{


    [self.delegate hidePanel];
}


- (void)brushSelectedAction:(id)sender
{
    NSLog(@"Selected Brush");
    
    CCMenuItemImage* menuItem =     (CCMenuItemImage*)sender;
    int i = menuItem.tag;
    NSString* imageName = [imageNamesDictionary objectForKey:[NSString stringWithFormat:@"%d",i]];
    [self.delegate brushSelected:imageName];
    [self.delegate hidePanel];
    
}



@end
