//
//  ControlsLayer.m
//  LeapPuzz
//
//  Created by cj on 4/9/13.
//
//

#import "ControlsLayer.h"

@implementation ControlsLayer
@synthesize slider;
@synthesize opacitySlider;
@synthesize opacitydisplayValueLabel;
@synthesize opacitySwitchControl;
@synthesize delegate;

@synthesize displayValueLabel;
@synthesize switchControl;
@synthesize brushSelection;
- (id)init
{
	if ((self = [super init]))
	{
		// Get window size
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        gameSettings = [GameSettings sharedInstance];
        
        //LayerBackground
        
        
        [self sliderinit];
        //[self buttoninit];
        //[self initEraserButton];
        [self initEraserSwitch];
        [self colorpickerinit];
        
        [self initResetButton];
        
        //Open button
        
        //Close Button
        self.brushSelection = [BrushSelectionLayer node];
        self.brushSelection.position = ccp(-screenSize.width,0);
        
        self.brushSelection.delegate = self;
        
        [self addChild:brushSelection z:10];
        [self initBrushSelectionButton];
        [self opacitySliderInit];
        [self initOpacitySwitch];
        //buttons
        
        // Color picker
        
        //
        

	}
	return self;
}


- (void)sliderinit{
    
    //Slideer
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    // Add the slider
    self.slider                     = [CCControlSlider sliderWithBackgroundFile:@"sliderTrack.png"
                                                                   progressFile:@"sliderProgress.png"
                                                                      thumbFile:@"sliderThumb.png"];
    self.slider.anchorPoint              = ccp(0.5f, 1.0f);
    self.slider.minimumValue             = 0.0f; // Sets the min value of range
    self.slider.maximumValue             = 5.0f; // Sets the max value of range
    self.slider.position                 = ccp(screenSize.width / 2.0f, 100);
    
    
    CCLabelTTF *titleButton = [CCLabelTTF labelWithString:@"Size" fontName:@"Marker Felt" fontSize:30];
    titleButton.position =ccp(screenSize.width / 2.0f , 125);
    
    // Add the black background
    CCScale9Sprite *background = [CCScale9Sprite spriteWithFile:@"buttonBackground.png"];
    [background setContentSize:CGSizeMake(350,100)];
    [background setPosition:ccp(screenSize.width / 2.0f, 100)];
    [self addChild:background];

    [self addChild:titleButton];
    // When the value of the slider will change, the given selector will be call
    [self.slider addTarget:self action:@selector(valueChanged:) forControlEvents:CCControlEventValueChanged];
    
    [self addChild:self.slider z:0 tag:1];
}

- (void)valueChanged:(CCControlSlider *)sender
{
	// Change value of label.
	//NSLog(@"slider value %@", [NSString stringWithFormat:@"Slider value = %.02f", sender.value]);
    [self.delegate changeThicknessControl:sender.value];
}


- (void)opacitySliderInit{
    
    //Slideer
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CCNode *layer                       = [CCNode node];
    layer.position                      =ccp(screenSize.width / 2.0f + 200, 100);
    [self addChild:layer z:3];
    
    double layer_width = 0;

    
    // Add the black background
    CCScale9Sprite *background = [CCScale9Sprite spriteWithFile:@"buttonBackground.png"];
    [background setContentSize:CGSizeMake(350,100)];
    [background setPosition:ccp(background.contentSize.width / 2.0f, 0)];
    [layer addChild:background];
    layer_width += background.contentSize.width;

    CCLabelTTF *titleButton = [CCLabelTTF labelWithString:@"Opacity" fontName:@"Marker Felt" fontSize:30];
    titleButton.position =ccp(layer_width / 2.0f , 25);
    
    
    [layer addChild:titleButton];
    // When the value of the slider will change, the given selector will be call
    
    // Add the slider
    self.opacitySlider                     = [CCControlSlider sliderWithBackgroundFile:@"sliderTrack.png"
                                                                          progressFile:@"sliderProgress.png"
                                                                             thumbFile:@"sliderThumb.png"];
    self.opacitySlider.anchorPoint              = ccp(0.5f, 1.0f);
    self.opacitySlider.minimumValue             = 0.0f; // Sets the min value of range
    self.opacitySlider.maximumValue             = 100.0f; // Sets the max value of range
    self.opacitySlider.position                 = ccp(layer_width  / 2.0f, 0);
    
    [self.opacitySlider addTarget:self action:@selector(opacitySliderChanged:) forControlEvents:CCControlEventValueChanged];
    
    [layer addChild:self.opacitySlider z:0 tag:2];
}

- (void)opacitySliderChanged:(CCControlSlider *)sender
{
    
	// Change value of label.
	//NSLog(@"slider value %@", [NSString stringWithFormat:@"Slider value = %.02f", sender.value]);
    [self.delegate changeOpacityControl:sender.value];
}

- (void)updateOpacitySlider:(float)value{
    
    
    //ensure the value is within its bounds
    if(value > self.opacitySlider.maximumValue){
        //Max Value
        self.opacitySlider.value = self.opacitySlider.maximumValue;
    }else if(value < self.opacitySlider.minimumValue){
        //Min Value
        self.opacitySlider.value = self.opacitySlider.minimumValue;
    }else{
        self.opacitySlider.value = value;
    }
}


- (void)initOpacitySwitch{
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCNode *layer               = [CCNode node];
    //layer.position              = ccp (screenSize.width / 2, screenSize.height / 2);
    layer.position = ccp(screenSize.width / 2.0f + 400, 125);
    [self addChild:layer z:5];
    
    double layer_width = 0;
    
    // Add the black background for the text
    CCScale9Sprite *background  = [CCScale9Sprite spriteWithFile:@"buttonBackground.png"];
    background.contentSize      = CGSizeMake(80, 50);
    background.position         = ccp(layer_width + background.contentSize.width / 2.0f, 0);
    //[layer addChild:background];
    
    layer_width += background.contentSize.width;
    
#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
    self.displayValueLabel      = [CCLabelTTF labelWithString:@"on" fontName:@"HelveticaNeue-Bold" fontSize:30];
#elif __MAC_OS_X_VERSION_MAX_ALLOWED
    self.opacitydisplayValueLabel      = [CCLabelTTF labelWithString:@"Auto" fontName:@"Marker Felt" fontSize:30];
#endif
    self.opacitydisplayValueLabel.position  = background.position;
    //[layer addChild:self.opacitydisplayValueLabel];
    
    // Create the switch
    self.opacitySwitchControl          = [self makeControlSwitch];
    self.opacitySwitchControl.position      = ccp (layer_width + 10 + self.opacitySwitchControl.contentSize.width / 2, 0);
    self.opacitySwitchControl.on            = NO;
    [layer addChild:self.opacitySwitchControl];
    
    [self.opacitySwitchControl addTarget:self action:@selector(opacitySwitchValueChanged:) forControlEvents:CCControlEventValueChanged];
    
    // Set the layer size
    layer.contentSize           = CGSizeMake(layer_width, 0);
    layer.anchorPoint           = ccp (0.5f, 0.5f);
    
    
}




- (void)opacitySwitchValueChanged:(CCControlSwitch *)sender
{
    if ([sender isOn])
    {
        //displayValueLabel.string    = @"Eraser";
        
        gameSettings.depthOpacityMode  = true;
    } else
    {
        //displayValueLabel.string    = @"Eraser";
        gameSettings.depthOpacityMode  = false;
    }
}



#pragma mark - button

- (void)buttoninit{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    // Add the button
    CCScale9Sprite *backgroundButton = [CCScale9Sprite spriteWithFile:@"button.png"];
    CCScale9Sprite *backgroundHighlightedButton = [CCScale9Sprite spriteWithFile:@"buttonHighlighted.png"];
    
#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
    CCLabelTTF *titleButton = [CCLabelTTF labelWithString:@"Touch Me!" fontName:@"HelveticaNeue-Bold" fontSize:30];
#elif __MAC_OS_X_VERSION_MAX_ALLOWED
    CCLabelTTF *titleButton = [CCLabelTTF labelWithString:@"Touch Me!" fontName:@"Marker Felt" fontSize:30];
#endif
    [titleButton setColor:ccc3(159, 168, 176)];
    
    CCControlButton *controlButton = [CCControlButton buttonWithLabel:titleButton
                                                     backgroundSprite:backgroundButton];
    [controlButton setBackgroundSprite:backgroundHighlightedButton forState:CCControlStateHighlighted];
    [controlButton setTitleColor:ccWHITE forState:CCControlStateHighlighted];
    
    controlButton.anchorPoint = ccp(0.5f, 1);
    controlButton.position = ccp(screenSize.width / 2.0f, screenSize.height / 2.0f);
    [self addChild:controlButton z:1];
    
    // Add the black background
    CCScale9Sprite *background = [CCScale9Sprite spriteWithFile:@"buttonBackground.png"];
    [background setContentSize:CGSizeMake(300, 170)];
    [background setPosition:ccp(screenSize.width / 2.0f, screenSize.height / 2.0f)];
    [self addChild:background];
    
    // Sets up event handlers
    [controlButton addTarget:self action:@selector(touchDownAction:) forControlEvents:CCControlEventTouchDown];
}





- (void)touchDownAction:(CCControlButton *)sender
{
    NSLog(@"button value %@", [NSString stringWithFormat:@"Touch Down"]);
}

- (void)initEraserButton{
    

    // Add the button
    CCScale9Sprite *backgroundButton = [CCScale9Sprite spriteWithFile:@"button.png"];
    CCScale9Sprite *backgroundHighlightedButton = [CCScale9Sprite spriteWithFile:@"buttonHighlighted.png"];
    
#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
    CCLabelTTF *titleButton = [CCLabelTTF labelWithString:@"Touch Me!" fontName:@"HelveticaNeue-Bold" fontSize:30];
#elif __MAC_OS_X_VERSION_MAX_ALLOWED
    CCLabelTTF *titleButton = [CCLabelTTF labelWithString:@"Eraser" fontName:@"Marker Felt" fontSize:30];
#endif
    [titleButton setColor:ccc3(159, 168, 176)];
    
    CCControlButton *controlButton = [CCControlButton buttonWithLabel:titleButton
                                                     backgroundSprite:backgroundButton];
    [controlButton setBackgroundSprite:backgroundHighlightedButton forState:CCControlStateHighlighted];
    [controlButton setTitleColor:ccWHITE forState:CCControlStateHighlighted];
    
    controlButton.anchorPoint = ccp(0.5f, 1);
    controlButton.position = ccp(100, 100);
    [self addChild:controlButton z:1];
    
    // Add the black background
    CCScale9Sprite *background = [CCScale9Sprite spriteWithFile:@"buttonBackground.png"];
    background.anchorPoint =  ccp(0, 0);
    [background setContentSize:CGSizeMake(100, 75)];
    [background setPosition: ccp(50, 50)];
    [self addChild:background];
    
    // Sets up event handlers
    [controlButton addTarget:self action:@selector(eraserAction:) forControlEvents:CCControlEventTouchDown];
}

- (void)eraserAction:(CCControlButton *)sender
{
    [self.delegate changeColorControl:ccWHITE];

}
- (void)initResetButton{
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    // Add the button
    CCScale9Sprite *backgroundButton = [CCScale9Sprite spriteWithFile:@"button.png"];
    CCScale9Sprite *backgroundHighlightedButton = [CCScale9Sprite spriteWithFile:@"buttonHighlighted.png"];
    
#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
    CCLabelTTF *titleButton = [CCLabelTTF labelWithString:@"Touch Me!" fontName:@"HelveticaNeue-Bold" fontSize:30];
#elif __MAC_OS_X_VERSION_MAX_ALLOWED
    CCLabelTTF *titleButton = [CCLabelTTF labelWithString:@"Reset" fontName:@"Marker Felt" fontSize:30];
#endif
    [titleButton setColor:ccc3(159, 168, 176)];
    
    CCControlButton *controlButton = [CCControlButton buttonWithLabel:titleButton
                                                     backgroundSprite:backgroundButton];
    [controlButton setBackgroundSprite:backgroundHighlightedButton forState:CCControlStateHighlighted];
    [controlButton setTitleColor:ccWHITE forState:CCControlStateHighlighted];
    
    controlButton.anchorPoint = ccp(0.5f, 1);
    controlButton.position = ccp(100, screenSize.height -100);
    [self addChild:controlButton z:1];
    
    // Add the black background
    CCScale9Sprite *background = [CCScale9Sprite spriteWithFile:@"buttonBackground.png"];
    [background setContentSize:CGSizeMake(100, 75)];
    [background setPosition:ccp(100, screenSize.height -125)];
    [self addChild:background];
    
    // Sets up event handlers
    [controlButton addTarget:self action:@selector(resetAction:) forControlEvents:CCControlEventTouchDown];
}


- (void)resetAction:(CCControlButton*)sender{
    [self.delegate clearDrawing];
}


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


#pragma mark - ColorPicker

- (void)colorpickerinit{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CCNode *layer                       = [CCNode node];
    layer.position                      = ccp (screenSize.width -300 , screenSize.height / 2);
    [self addChild:layer z:1];
    
    double layer_width = 0;
    
    // Add the black background for the text
    CCScale9Sprite *background = [CCScale9Sprite spriteWithFile:@"buttonBackground.png"];
    [background setContentSize:CGSizeMake(150, 50)];
    [background setPosition:ccp(layer_width + background.contentSize.width / 2.0f, 0)];
    //[layer addChild:background];
    
    layer_width += background.contentSize.width;
    
#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
    colorLabel = [CCLabelTTF labelWithString:@"#color" fontName:@"HelveticaNeue-Bold" fontSize:30];
#elif __MAC_OS_X_VERSION_MAX_ALLOWED
    colorLabel = [CCLabelTTF labelWithString:@"#color" fontName:@"Marker Felt" fontSize:30];
#endif
    colorLabel.position = background.position;
    //[layer addChild:colorLabel];
    
    // Create the colour picker
    CCControlColourPicker *colourPicker = [CCControlColourPicker colourPickerWithHueFile:@"hueBackground.png"
                                                                      tintBackgroundFile:@"tintBackground.png"
                                                                         tintOverlayFile:@"tintOverlay.png"
                                                                              pickerFile:@"picker.png"
                                                                               arrowFile:@"arrow.png"];
    colourPicker.color                  = ccc3(37, 46, 252);
    colourPicker.position               = ccp (layer_width + colourPicker.contentSize.width / 2, 0);
    colourPicker.arrowDirection         = CCControlColourPickerArrowDirectionLeft;
    
    // Add it to the layer
    [layer addChild:colourPicker];
    
#if NS_BLOCKS_AVAILABLE
    // Add block for value changed event
    [colourPicker setBlock:^(id sender, CCControlEvent event)
     {
         [self colourValueChanged:sender];
     }
          forControlEvents:CCControlEventValueChanged];
#else
    // Add the target-action pair
    [colourPicker addTarget:self action:@selector(colourValueChanged:) forControlEvents:CCControlEventValueChanged];
#endif
    
    layer_width += colourPicker.contentSize.width;
    
    // Set the layer size
    layer.contentSize                   = CGSizeMake(layer_width, 0);
    layer.anchorPoint                   = ccp (0.5f, 0.5f);
    
    // Update the color text
    [self colourValueChanged:colourPicker];
}

- (void)colourValueChanged:(CCControlColourPicker *)sender
{
    colorLabel.string   = [NSString stringWithFormat:@"#%02X%02X%02X",sender.color.r, sender.color.g, sender.color.b];
    
    [self.delegate changeColorControl:sender.color];
}


#pragma mark - Window Controls

- (void)expandPanel{
    
    
}

- (void)collapsePanel{
    
}

- (void)initEraserSwitch{
    

    
    CCNode *layer               = [CCNode node];
    //layer.position              = ccp (screenSize.width / 2, screenSize.height / 2);
    layer.position = ccp(100, 100);
    [self addChild:layer z:1];
    
    double layer_width = 0;
    
    // Add the black background for the text
    CCScale9Sprite *background  = [CCScale9Sprite spriteWithFile:@"buttonBackground.png"];
    background.contentSize      = CGSizeMake(80, 50);
    background.position         = ccp(layer_width + background.contentSize.width / 2.0f, 0);
    [layer addChild:background];
    
    layer_width += background.contentSize.width;
    
#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
    self.displayValueLabel      = [CCLabelTTF labelWithString:@"on" fontName:@"HelveticaNeue-Bold" fontSize:30];
#elif __MAC_OS_X_VERSION_MAX_ALLOWED
    self.displayValueLabel      = [CCLabelTTF labelWithString:@"Eraser" fontName:@"Marker Felt" fontSize:30];
#endif
    displayValueLabel.position  = background.position;
    [layer addChild:displayValueLabel];
    
    // Create the switch
    self.switchControl          = [self makeControlSwitch];
    switchControl.position      = ccp (layer_width + 10 + switchControl.contentSize.width / 2, 0);
    switchControl.on            = NO;
    [layer addChild:switchControl];
    
    [switchControl addTarget:self action:@selector(switchValueChanged:) forControlEvents:CCControlEventValueChanged];
    
    // Set the layer size
    layer.contentSize           = CGSizeMake(layer_width, 0);
    layer.anchorPoint           = ccp (0.5f, 0.5f);

    
}


- (CCControlSwitch *)makeControlSwitch
{
    return [CCControlSwitch switchWithMaskSprite:[CCSprite spriteWithFile:@"switch-mask.png"]
                                        onSprite:[CCSprite spriteWithFile:@"switch-on.png"]
                                       offSprite:[CCSprite spriteWithFile:@"switch-off.png"]
                                     thumbSprite:[CCSprite spriteWithFile:@"switch-thumb.png"]
                                         onLabel:[CCLabelTTF labelWithString:@"On" fontName:@"Arial-BoldMT" fontSize:16]
                                        offLabel:[CCLabelTTF labelWithString:@"Off" fontName:@"Arial-BoldMT" fontSize:16]];
}


- (void)switchValueChanged:(CCControlSwitch *)sender
{
    if ([sender isOn])
    {
        displayValueLabel.string    = @"Eraser";
        
        [self.delegate eraserMode:true];
    } else
    {
        displayValueLabel.string    = @"Eraser";
        [self.delegate eraserMode:false];
    }
}


#pragma mark- Brush Selection Delegate

- (void)initBrushSelectionButton{
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    // Add the button
    CCScale9Sprite *backgroundButton = [CCScale9Sprite spriteWithFile:@"button.png"];
    CCScale9Sprite *backgroundHighlightedButton = [CCScale9Sprite spriteWithFile:@"buttonHighlighted.png"];
    
#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
    CCLabelTTF *titleButton = [CCLabelTTF labelWithString:@"Touch Me!" fontName:@"HelveticaNeue-Bold" fontSize:30];
#elif __MAC_OS_X_VERSION_MAX_ALLOWED
    CCLabelTTF *titleButton = [CCLabelTTF labelWithString:@"Brushes" fontName:@"Marker Felt" fontSize:30];
#endif
    [titleButton setColor:ccc3(159, 168, 176)];
    
    CCControlButton *controlButton = [CCControlButton buttonWithLabel:titleButton
                                                     backgroundSprite:backgroundButton];
    [controlButton setBackgroundSprite:backgroundHighlightedButton forState:CCControlStateHighlighted];
    [controlButton setTitleColor:ccWHITE forState:CCControlStateHighlighted];
    
    controlButton.anchorPoint = ccp(0.5f, 1);
    controlButton.position = ccp(screenSize.width -100, screenSize.height -100);
    [self addChild:controlButton z:1];
    
    // Add the black background
    CCScale9Sprite *background = [CCScale9Sprite spriteWithFile:@"buttonBackground.png"];
    [background setContentSize:CGSizeMake(100, 75)];
    [background setPosition:ccp(screenSize.width -100, screenSize.height -125)];
    [self addChild:background];
    
    // Sets up event handlers
    [controlButton addTarget:self action:@selector(brushButtonAction:) forControlEvents:CCControlEventTouchDown];
}


- (void)brushButtonAction:(CCControlButton*)sender{
    if (self.brushSelection.layerHidden) {
        [self showBrushSelectionPanel];
    }else{
        [self hideBrushSelectionPanel];
    }

}


- (void)showBrushSelectionPanel{
    
    self.brushSelection.layerHidden = false;
    //[sprite runAction: [CCMoveBy actionWithDuration:2 position:ccp(50,10)]];
    [self.brushSelection runAction:[CCMoveTo actionWithDuration:2 position:ccp(0,0)]];
}

- (void)hideBrushSelectionPanel{
    // Get window size
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    self.brushSelection.layerHidden = true;
    [self.brushSelection runAction:[CCMoveTo actionWithDuration:2 position:ccp(-screenSize.width,0)]];
    
}

- (void)hidePanel{

    [self hideBrushSelectionPanel];
}


- (void)brushSelected:(NSString *)brushname{
    [self.delegate changeBrushControl:brushname];
}


@end
