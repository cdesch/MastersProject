//
//  LPTool.h
//  LeapPuzz
//
//  Created by cj on 3/29/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

/**
 Extends CCSprite object with two properties for tracking sprites with pointable objects
 */
@interface LPTool : CCSprite
@property (nonatomic, strong) NSString* toolID; /**< toolID is the ID number assigned by the LeapMotion SDK */
@property (nonatomic, readwrite) BOOL updated; /**< updated is if the sprite has been updated in that frame.*/
@end
