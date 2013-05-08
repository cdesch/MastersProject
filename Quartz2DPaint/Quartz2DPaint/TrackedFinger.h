//
//  TrackedFinger.h
//  LeapPuzz
//
//  Created by cj on 2/8/13.
//
//

#import <Foundation/Foundation.h>
#import "LPDrawingTool.h"
@interface TrackedFinger : NSObject

@property (nonatomic, strong) NSString* fingerID;
@property (nonatomic, readwrite) BOOL updated;
@property (nonatomic, readwrite) CGPoint position;
@property (weak) LPDrawingTool* tool;

- (id)initWithID:(NSString*)finger withPosition:(CGPoint)p;
@end
