//
//  BrushSelectionLayer.h
//  LeapPuzz
//
//  Created by cj on 4/9/13.
//
//


#import "cocos2d.h"
#import "CCControlExtension.h"


/** BrushSelectionLayer Delegate
 Provides a delegate interface for the layer to notify of actions
 */
@protocol BrushSelectionLayerDelegate <NSObject>
/**
 Calls back to notify that the layer can be hidden
 */
- (void)hidePanel;
/**
 Calls back to notify a new brushname has been selected
 @param brushname is the name of the brush that has been selected.
 */
- (void)brushSelected:(NSString*)brushname;
@end

/** BrushSelectionLayer 
 This user interface layer provides a collection view of all the available brushes that can be selected. 
 */
@interface BrushSelectionLayer : CCLayer{
    
    NSMutableDictionary* imageNamesDictionary; /**< imageNamesDictionary is the list of brush names available for selection */

}

@property (nonatomic, weak) id <BrushSelectionLayerDelegate> delegate;/**< delegate is the instance reference for triggering delegate call back functions */
@property (nonatomic, readwrite) bool layerHidden;/**< layerHidded tracks the visibility state of the layer */


@end
