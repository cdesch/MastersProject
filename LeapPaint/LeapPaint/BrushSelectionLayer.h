//
//  BrushSelectionLayer.h
//  LeapPuzz
//
//  Created by cj on 4/9/13.
//
//


#import "cocos2d.h"
#import "CCControlExtension.h"
@protocol BrushSelectionLayerDelegate <NSObject>

- (void)hidePanel;
- (void)brushSelected:(NSString*)brushname;
@end

@interface BrushSelectionLayer : CCLayer{
    
    NSMutableDictionary* imageNamesDictionary;

}


@property (nonatomic, weak) id <BrushSelectionLayerDelegate> delegate;
@property (nonatomic, readwrite) bool layerHidden;

@end
