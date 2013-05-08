//
//  GameManager.m
//  LeapPuzz
//
//  Created by cj on 4/2/13.
//
//

#import "GameManager.h"

@implementation GameManager

@synthesize hudLayer;
@synthesize textureScene;
@synthesize backgroundLayer;
@synthesize controlsLayer;
@synthesize controller;
@synthesize leapScreen;


// On "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
                
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Leap Paint" fontName:@"Marker Felt" fontSize:64];
        
		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        NSLog(@"Window size (pixels)-- Width: %0.0f Height: %0.0f",size.width, size.height);
        
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height - 25 );
       		// add the label as a child to this Layer
        
		[self addChild: label];
        [self run];
        
        inputMode = kPressKeyMode;
        painting = false;
        
        gameSettings = [GameSettings sharedInstance];
        
        lastTag = -1;
        lastPoint = [[SimplePoint alloc] initWithX:0.0f withY:0.0f withZ:0.0f];
        framesSinceLastFound = 0;
         
	}
	return self;
}

#pragma mark - SampleDelegate Callbacks

/**
 LeapMotion SDK Delegate Callback
 Init's a LeapMotion instance to initiate connection and tracking with the LeapMotion and assigns the delegate or listener for the controller
 */
- (void)run
{
    controller = [[LeapController alloc] init];
    [controller addListener:self];
    
}
/**
 LeapMotion SDK Delegate Callback
 Initialize
 Verifies the LeapMotion has been initialized and any additional steps for setup can continue. 
 */

- (void)onInit:(NSNotification *)notification{
    NSLog(@"Leap: Initialized");
}
/**
 LeapMotion SDK Delegate Callback
 Connect
 Verifies the LeapMotion is connected and additional steps for setup can continue.
 Sets up the screens to be track intersecting vectors from pointables.
 */
- (void)onConnect:(NSNotification *)notification{
    NSLog(@"Leap: Connected");
    NSArray* screens = controller.locatedScreens;
    if ([screens count] > 0){
        leapScreen = [screens objectAtIndex:0];
        NSLog(@"Screens: %0.0ld", (unsigned long)[screens count]);
    }else{
        NSLog(@"No Screens");
    }
}
/**
 LeapMotion SDK Delegate Callback 
 Disconnect
 Notifies the application that the LeapMotion has been disconnected and hold or release any processes in regard to the LeapMotion
 */
- (void)onDisconnect:(NSNotification *)notification{
    NSLog(@"Leap: Disconnected");
}

/**
 LeapMotion SDK Delegate Callback
 Exits
 Releases memory and sets object instances to nil (null)
 */
- (void)onExit:(NSNotification *)notification{
    NSLog(@"Leap: Exited");
}
/**
 LeapMotion SDK Delegate Callback
 OnFrame Event notifies the application that an incoming frame has been processed and the data can be used to control the application
 */
- (void)onFrame:(NSNotification *)notification{
    LeapController *aController = (LeapController *)[notification object];
    // Get the most recent frame and report some basic information
    LeapFrame *frame = [aController frame:0];
    
    //Try and find the same one as last time.
    if ([[frame pointables] count] != 0) {
        NSArray* leapPointables = [frame pointables];
        
        LeapPointable* tool;
        if (lastTag != -1){
            for (LeapPointable* pointable in leapPointables){
                if (lastTag == pointable.id){
                    tool = pointable;
                    lastTag = pointable.id;
                    break;
                }
            }
            
            //Find a new point able
            if (tool == nil){
                tool = [self pointableClosestToScreen:leapPointables];
                lastTag = tool.id;
            }
        }else{
            //Find a new pointable
            tool = [self pointableClosestToScreen:leapPointables];
            lastTag = tool.id;
        }
        
        //Get the screen
        LeapVector* normalized = [leapScreen intersect:tool normalize:YES clampRatio:2.0];
        
        if ([leapScreen isValid]){
            double x = normalized.x * [leapScreen widthPixels];
            double y = normalized.y * [leapScreen heightPixels];
            
            CGPoint pointer = CGPointMake(x, y);
            
            //Convert to Local coordinates from Screen Coordinates
            CCDirector* director = [CCDirector sharedDirector];
            NSPoint var = [director.view.window convertScreenToBase:pointer];
            
            //Logging
            //NSLog(@"x %0.0f y %0.0f z %0.0f Pointer: x %0.0f y %0.0f ", x, y,tool.tipPosition.z, var.x, var.y);
            //SimplePoint* simplePoint = [[SimplePoint alloc] initWithPosition:var withZ:tool.tipPosition.z];
            //[[NSNotificationCenter defaultCenter] postNotificationName:@"CoordHUDUpdate" object:simplePoint];

            if (gameSettings.depthOpacityMode){
                float opacity = [self opacityPercentage:tool.tipPosition.z];
                //Update the controls
                [controlsLayer updateOpacitySlider:opacity];
            }
                    
            if (inputMode == kDepthMode){
                
                if (tool.tipPosition.z > 0){
                    painting = FALSE;
                }else{
                    painting = TRUE;
                }
            }
            
            //Update the HUD View
            [self.hudLayer toolMoved:var toolID:[NSString stringWithFormat:@"%0.0d",tool.id]];
            if (painting){
                [self movedToolTexture:var tool:tool];
            }else{
               // NSLog(@"Not Painting");
            }
            
        }else{
            NSLog(@"Leap Screen is invalid");
        }
    }else{
        NSLog(@"No frame");
        //Remove the marker from the HUD view
        if (currentPointable != nil) {

            [self endLineDrawingTexture:currentPoint tool:currentPointable];
            [self.hudLayer endTrackingTool];
        }
        
        lastTag = -1;
        
        framesSinceLastFound ++;
        if (framesSinceLastFound > kMaxFrames){
            
            framesSinceLastFound = 0;
        }
    }
}

#pragma mark - TextureScene

/** Moves the tool on the screen when painting */
- (void)movedToolTexture:(CGPoint)point tool:(LeapPointable*)pointable{
    
    if (currentPointable != nil){
        
        [self moveLineDrawingTexture:point tool:pointable];
        currentPointable = pointable;
    }else{
        [self beginLineDrawingTexture:point tool:pointable];
        currentPointable = pointable;
    }
}

/** Begin drawing to the canvas 
 @param point is the current coordinate the LeapPointable is interescting with the screen
 @param pointable is a reference to the pointable currently drawing
 */
- (void)beginLineDrawingTexture:(CGPoint)point tool:(LeapPointable*)pointable{
    
    [self.textureScene beginDraw:point withZ:pointable.tipPosition.z];
    currentPoint = point;
}
/** Update drawing with a moved image on the canvas 
  @param point is the current coordinate the LeapPointable is interescting with the screen
  @param pointable is a reference to the pointable currently drawing
 */
- (void)moveLineDrawingTexture:(CGPoint)point tool:(LeapPointable*)pointable{
    
    [self.textureScene updateDraw:point withZ:pointable.tipPosition.z];
    currentPoint = point;
}
/** End the drawing 
  @param point is the current coordinate the LeapPointable is interescting with the screen
  @param pointable is a reference to the pointable currently drawing
 */
- (void)endLineDrawingTexture:(CGPoint)point tool:(LeapPointable*)pointable{
    [self.textureScene endDraw:point];
    currentPointable = nil;
}

#pragma mark - Keyboard Events

/** Change Input Mode */
- (void)changeMode:(InputMode)mode{
    //NSLog(@"Changemode");
    inputMode = mode;
    gameSettings.inputMode = mode;
}
/** Change Paiting state
 @param paintState changes the painting sate
 */
- (void)painting:(BOOL)paintingState{
    painting = paintingState;
    gameSettings.painting = paintingState;
}
#pragma mark - ControlsDelegate

/** Change the color of the brush
 Updates the HUD Layer and the Texture Layer
  @param color is the color to be changed
 */

- (void)changeColorControl:(ccColor3B)color{
    [self.hudLayer changeColor:color];
    [self.textureScene changeColor:color];
    
}
/** Change the thickness of the brush
 Updates the HUD Layer and the Texture Layer
 @param value is the thinkness(width) value 
 */
- (void)changeThicknessControl:(float)value{
    [self.hudLayer changeScale:value];
    [self.textureScene changeScale:value];
}
/** Change the brush type
 Updates the HUD Layer and the Texture Layer
 @param brushname is the name of the brush to be changed
 */
- (void)changeBrushControl:(NSString *)brushname{
    
    [self.hudLayer changeBrush:brushname];
    [self.textureScene changeBrush:brushname];
}
/** Change the opacity of the brush
 Updates the HUD Layer and the Texture Layer
 @param value is the opacity value
 */
- (void)changeOpacityControl:(float)value{
    [self.textureScene changeOpacity:value];
}

/** Clears the drawing */
- (void)clearDrawing{
    [self.textureScene clearDrawing];
    //**Turns off eraser mode if it is on
    if (gameSettings.eraserMode){
        gameSettings.eraserMode = false;
        
        //Update texture mode and update Controls layer
    }
}
/** Update the eraser mode
 Updates the HUD Layer and the Texture Layer
 @param mode is the current state of the eraser
 */
- (void)eraserMode:(bool)mode{
    
    [self.hudLayer erasingMode:mode];
    [self.textureScene erasingMode:mode];
    
}

/** Return the Opacity value based on Z position */
- (float)opacityPercentage:(float)value{
    //NSLog(@"value %0.0f", value);
    if (value < kOpMinRange){
        return kOpMax;
    }else if(value > kOpMaxRange){
        return kOpMin;
    }else {   
        float percentage = [self findPecentageDifference:kOpMaxRange withMin:kOpMinRange withValue:value];
        percentage = 100 - percentage;
        return percentage;
    }
}
/** Find the percentage between two numbers */
- (float)findPecentageDifference:(float)max withMin:(float)min withValue:(float)value{
    return (value - min)/(max - min)*100;
}
/**
 Using all the pointables, gets the closest one to the screen
 @param pointables is an array of pointables currently observered by the LeapMotion
 @return pointable that is closest by the screen
 */
- (LeapPointable*)pointableClosestToScreen:(NSArray*)pointables{
    LeapPointable* closestPointable;
    for (LeapPointable*pointable in pointables){
        
        //Check for the first iteration that the closest is not equal to nil
        if (closestPointable != nil){
            if (closestPointable.tipPosition.z > pointable.tipPosition.z){
                closestPointable = pointable;
            }
        }else{
            closestPointable = pointable;
        }
    }
    return closestPointable;
}

/** 
 Find the closest LeapPointable to the current last vector
 @param leapVector is the position of the last pointbale
 @param pointables is an array of pointables currently observered by the LeapMotion
 @return LeapPointable closest to a leapVector
 */
- (LeapPointable*)pointableClosestToVector:(LeapVector*)leapVector withPointables:(NSArray*)pointables{
    LeapPointable* closestPointable;
    //Check to make sure there is atleast one object in the array
    
    //if the array is empty, throw an exception
    if ([pointables count] == 0){
        NSLog(@"Cannot pass item 0 array");
        return nil;
    }
    //If there is only one object in the array, return it
    else if ([pointables count] == 1){
        return [pointables objectAtIndex:0];
    }else{
        //Get the distance for the first point
        float minDistance = 0;
        closestPointable = [pointables objectAtIndex:0];
        minDistance = [leapVector distanceTo:closestPointable.tipPosition];
   
        for (int i = 1; i < [pointables count]; i++){
            
            LeapPointable* point = [pointables objectAtIndex:i];
            float distance = [leapVector distanceTo:point.tipPosition];
            if ( distance < minDistance){
                minDistance = distance;
                closestPointable = point;
            }
        }
    }
    return closestPointable;
}
@end
