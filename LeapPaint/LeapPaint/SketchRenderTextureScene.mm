//
//  SketchRenderTextureScene.m
//  Cocos2D-CCRenderTexture-Demo
//
//  Copyright (c) 2011 Steffen Itterheim.
//	Distributed under MIT License.
//

#import "SketchRenderTextureScene.h"


@implementation SketchRenderTextureScene
@synthesize opacity;

-(id) init
{
	if ((self = [super init])) 
	{
		// create a simple rendertexture node and clear it with the color white
        
        //target = [CCRenderTexture renderTextureWithWidth:s.width height: s.height pixelFormat:kCCTexture2DPixelFormat_RGBA8888];
		CGSize s = [CCDirector sharedDirector].winSize;

        CCDirector* sharedDirector =[CCDirector sharedDirector];
        CGSize frameSize = sharedDirector.view.frame.size;
        
        
        
        float topbottombar = 300;
        float sidebars = 300;

		
        
        
        //CCSprite* imageBackground = [CCSprite spriteWithFile:@"squarebrush.png"] ;
        //imageBackground set

        
        CCRenderTexture* rtx = [CCRenderTexture renderTextureWithWidth:frameSize.width-sidebars height: frameSize.height-topbottombar];
		[rtx clear:1.0f 
				 g:1.0f
				 b:1.0f
				 a:1.0f];
        
		rtx.position = CGPointMake(s.width/2, s.height/2);
		[self addChild:rtx z:0 tag:1];
        
        
        

		//CCLabelTTF* label = [CCLabelTTF labelWithString:@"Drawing onto CCRenderTexture without clear" fontName:@"Arial" fontSize:16];
		//label.position = CGPointMake(240, 15);
		//label.color = ccGRAY;
		//[self addChild:label];

		// create and retain the brush sprite, but don't add it as child
        
        lastColor = ccWHITE;
        lastBrush = @"roundbrush.png";
        lastScale = 1.0;
        
        eraseMode = false;
        self.opacity = 10;
        
        [self addBrush:lastBrush];
        
    
        
		//brush.scale = 0.5f;

		// create the array holding the touches
		touches = [[NSMutableArray alloc] init];
		
		//[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
		
		[self scheduleUpdate];

	}
	return self;
}

- (void)addBrush:(NSString*)brushName{
    
    brush = [CCSprite spriteWithFile:brushName] ;
    [brush setScale:lastScale];
    
    
    if(eraseMode){
        //[brush setBlendFunc:(ccBlendFunc) { GL_ZERO,GL_ONE_MINUS_SRC_ALPHA }];
        [brush setBlendFunc:(ccBlendFunc) { GL_ONE,GL_ONE }];
        
        

		[brush setOpacity:80];
    }else{
        brush.color = lastColor;
        brush.opacity = opacity;
    }
}

-(void) cleanup
{
	brush = nil;
	touches = nil;
	
	[super cleanup];
}

- (void)beginDraw:(CGPoint)point withZ:(float)z{
    //NSLog(@"Begin Draw");
    SimplePoint* simplePoint = [[SimplePoint alloc] initWithPosition:point withZ:z];
    [touches addObject:simplePoint];
    
}
- (void)updateDraw:(CGPoint)point withZ:(float)z{
    
      //  NSLog(@"update Draw");
    SimplePoint* simplePoint = [[SimplePoint alloc] initWithPosition:point withZ:z];
    [touches addObject:simplePoint];
    
}
- (void)endDraw:(CGPoint)point {
	[touches removeAllObjects];
}


/*
-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	// add new touches to the array as they come in
	[touches addObject:touch];
	return YES;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	// must remove the touches that have ended or where cancelled
	[touches removeObject:touch];
}

-(void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
	[self ccTouchEnded:touch withEvent:event];
}

*/
-(void) setBrushColor:(int)color
{
	switch (color)
	{
		default:
		case 0:
			brush.color = ccWHITE;
			break;
		case 1:
			brush.color = ccGREEN;
			break;
		case 2:
			brush.color = ccRED;
			break;
		case 3:
			brush.color = ccc3(0, 255, 255);
			break;
		case 4:
			brush.color = ccBLUE;
			break;
	}
}

-(void) update:(ccTime)delta
{

	CCRenderTexture* rtx = (CCRenderTexture*)[self getChildByTag:1];

	// explicitly don't clear the rendertexture
	[rtx begin];

	//int color = 0;

	// Since we store all current touches in an array, we can render a sprite at each touch location
	// even if the touch isn't moving. That way a continued press will increase the opacity of the sprite
	// simply because the sprite is drawn repeatedly with low opacity at the same location.
    NSArray* tempTouches = [[NSArray alloc] initWithArray:touches];
	for (SimplePoint* touch in tempTouches)
	{
		//CGPoint touchLocation = [director convertToGL:[touch locationInView:director.openGLView]];
        CGPoint touchLocation = [touch point];
		
		// the location must be converted to the rendertexture sprite's node space
		touchLocation = [rtx.sprite convertToNodeSpace:touchLocation];
		
		// because the rendertexture sprite is flipped along its Y axis the Y coordinate must be flipped:
		touchLocation.y = rtx.sprite.contentSize.height - touchLocation.y;
		
		//CCLOG(@"touch: %.0f, %.0f", touchLocation.x, touchLocation.y);
		
		// set the brush at that location and render it
		brush.position = touchLocation;
		//[self setBrushColor:color++];
		[brush visit];
	}
    
    
	
	[rtx end];
    
    [touches removeAllObjects];
}

- (void)changeColor:(ccColor3B)color{
    
       
    if(brush != nil){
        
        brush.color = color;
     
    }
    lastColor = color;
    
}
- (void)changeBrush:(NSString*)brushname{
    
    lastBrush = brushname;
    if (brush != nil){
        //Save important data
        CGPoint lastlocation = brush.position;
        [self addBrush:lastBrush];
        brush.position = lastlocation;
    }
    
}

- (void)changeScale:(float)size{
    
    lastScale = size;
    if(brush != nil){
        
        [brush setScale:size];
        
    }
}

- (void)changeOpacity:(float)o{
    
    self.opacity = o;
    if (brush != nil){
        
        brush.opacity = self.opacity;
    }
    
}

- (void)clearDrawing{
    
  	CCRenderTexture* rtx = (CCRenderTexture*)[self getChildByTag:1];
    
	// explicitly don't clear the rendertexture
//	[rtx begin];
//    glClearColor(r, g, b, a);
  //  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
        //get rid of the mask
        // glColorMask(TRUE, TRUE, TRUE, FALSE);
//    [rtx end];
    
    [rtx clear:1 g:1 b:1 a:0];
    
}



- (void)erasingMode:(BOOL)mode{
    
    eraseMode = mode;
    
    //turn Erasing Mode on
    if (mode){
        previousColor = lastColor;
        lastColor = ccRED;
        
        CGPoint lastlocation = brush.position;
        [self addBrush:lastBrush];
        brush.position = lastlocation;
        
    }else{
        //Turn erasing mode off
        lastColor = previousColor;
        CGPoint lastlocation = brush.position;
        [self addBrush:lastBrush];
        brush.position = lastlocation;
        
    }
    
}





@end
