//
//  HUDLayer.m
//  LeapPuzz
//
//  Created by cj on 4/1/13.
//
//

#import "HUDLayer.h"

@implementation HUDLayer
@synthesize delegate;
@synthesize xyzcoords;
- (id)init
{
	if ((self = [super init]))
	{
		// Get window size
		CGSize size = [[CCDirector sharedDirector] winSize];
		
		// Add a button which takes us back to HelloWorldScene
		
		// Create a label with the text we want on the button
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Tap Here" fontName:@"Helvetica" fontSize:32.0];
		
		// Create a button out of the label, and tell it to run the "switchScene" method
		CCMenuItem *button = [CCMenuItemLabel itemWithLabel:label target:self selector:@selector(testing:)];
		
		// Add the button to a menu - "nil" terminates the list of items to add
		CCMenu *menu = [CCMenu menuWithItems:button, nil];
		
		// Place the menu in center of screen
		[menu setPosition:ccp(size.width / 2, size.height / 2)];
        
        lastColor = ccWHITE;
        lastBrush = @"roundbrush.png";
        lastScale = 1.0;
        
        eraseMode = false;
		
		// Finally add the menu to the layer
		//[self addChild:menu];
#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
		self.isTouchEnabled = YES;
		self.isAccelerometerEnabled = YES;
#elif defined(__MAC_OS_X_VERSION_MAX_ALLOWED)
		self.isMouseEnabled = YES;
        self.isKeyboardEnabled= YES;
#endif
        inputMode = kDepthMode;
        
        /*
        self.xyzcoords = [CCLabelTTF labelWithString:@"Coords" fontName:@"Helvetica" fontSize:16.0];
        self.xyzcoords.position = ccp(size.width / 2, 50);
        [self addChild:self.xyzcoords];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleHUDCoordUpdate:)
                                                     name:@"CoordHUDUpdate"
                                                   object:nil];
         
         */
        
	}
	return self;
}


//Add the sprite hud
- (LPTool*)addLPTool:(CGPoint)p objectID:(NSString*)objectID withBrushName:(NSString*)brushname{
    
	LPTool *sprite = [LPTool spriteWithFile:brushname];
    
    [self addChild:sprite];
    
    sprite.updated = TRUE;
    sprite.toolID = objectID;
    [sprite setScale:lastScale];
    sprite.position = ccp( p.x, p.y);
    sprite.color = lastColor;
    
    return sprite;
}

/* Tool Moved */
- (void)toolMoved:(CGPoint)point toolID:(NSString*)toolid{
    
    if (primaryTool == nil){
        [self startTrackingTool:point toolID:toolid];
    }else{
        [self moveTrackingTool:point toolID:toolid];
    }
}

/* Start Tracking Tool */
- (void)startTrackingTool:(CGPoint)point toolID:(NSString*)toolid{
    if (primaryTool == nil){
        primaryTool = [self addLPTool:point objectID:toolid withBrushName:lastBrush];
    }
}

/* Move Tracking Tool*/
- (void)moveTrackingTool:(CGPoint)point toolID:(NSString*)toolid{
    
    //Create tool if it does not exist
    if (primaryTool == nil){
        primaryTool = [self addLPTool:point objectID:toolid withBrushName:lastBrush];
    }else{
        //Update since it does exist
        primaryTool.position =  point;
        if ([toolid isNotEqualTo:primaryTool.toolID]){
            primaryTool.toolID = toolid;
        }
    }
}

/* End Trackingn Tool */
- (void)endTrackingTool{
    if (primaryTool != nil){
        [self removeChild:primaryTool cleanup:YES];
        primaryTool = nil;
    }
}


//Key up event
-(BOOL) ccKeyUp:(NSEvent*)event{

    unichar ch = [event keyCode];

    if (inputMode == kPressKeyMode){
        if ( ch == 49){
            [self.delegate painting:FALSE];
        }
    }
    
    if ( ch == 18){
        //change to space bar press mode
        inputMode = kPressKeyMode;
        [self.delegate changeMode:inputMode];
    }else if(ch == 19){
        //Change to depth mode
        inputMode = kDepthMode;
        [self.delegate changeMode:inputMode];
    }
    
    return YES;
}
//Key down event
-(BOOL) ccKeyDown:(NSEvent*)event{
    unichar ch = [event keyCode];
    
    if (inputMode == kPressKeyMode){
        if ( ch == 49){
            [self.delegate painting:TRUE];
        }
    }
    return YES;
}

- (void)changeColor:(ccColor3B)color{
    


    if(primaryTool != nil){
        
        [primaryTool setColor:color];

    }
    lastColor = color;
}

- (void)changeBrush:(NSString*)brushname{
    
    lastBrush = brushname;
    if (primaryTool != nil){
        //Save important data
        CGPoint lastlocation = primaryTool.position;
        NSString* toolid = [primaryTool.toolID copy];
        
        //Remove Tool
        [self removeChild:primaryTool cleanup:YES];
        
        //Add it back
        primaryTool = [self addLPTool:lastlocation objectID:toolid withBrushName:lastBrush];
    }
    
}


- (void)changeScale:(float)size{
    
    lastScale = size;
    if(primaryTool != nil){
        
        [primaryTool setScale:size];
    }
}


- (void)erasingMode:(BOOL)mode{
    
    eraseMode = mode;

    //turn Erasing Mode on
    if (mode){
        previousColor = lastColor;
        lastColor = ccRED;
        [primaryTool setColor:ccRED];
    }else{
        //Turn erasing mode off
        lastColor = previousColor;
        [primaryTool setColor:lastColor];
    }

}

- (void)updateCoordsHUDWithX:(float)x withY:(float)y withZ:(float)z{
    
    self.xyzcoords.string = [NSString stringWithFormat:@"Coords x: %0.0f, y %0.0f, z %0.0f",x,y,z];
    
}

- (void)handleHUDCoordUpdate:(id)sender{
    
    NSNotification* note = sender;
    //LEDColor* ledColor = note.object;
    
    SimplePoint* point = note.object;
    
    [self updateCoordsHUDWithX:point.x withY:point.y withZ:point.z];
    
    
}


@end
