//
//  LPBrushTool.m
//  LeapPaint
//
//  Created by cj on 3/19/13.
//  Copyright (c) 2013 cjdesch. All rights reserved.
//

#import "LPBrushTool.h"

@implementation LPBrushTool

- (void)inputBegan:(NSEvent *)theEvent  withSettings:(ToolSettings *)settings{
    self.settings = settings;
    templateImage = [NSImage imageNamed:templateImageName];
    CGSize size = CGSizeMake(self.lineWidth, self.lineWidth);
    templateImage = [self imageResize:templateImage newSize:NSSizeFromCGSize(size)];
    //templateImage = self adjustImage:templateImage withHue:<#(float)#>

}

- (void)inputMoved:(NSEvent *)theEvent {
    
}

- (void)inputEnded:(NSEvent *)theEvent {
    
}


- (void)toolDidLoad{
    
    //NSLog(@"Tool Did Load Subclass");
   // templateImage = [NSImage imageNamed:templateImageName];
//     self.template = [[NSImage imageNamed:templateImageName withTint:self.primaryColor] resizedImage:CGSizeMake(self.lineWidth), self.lineWidth) interpolationQuality:kCGInterpolationDefault];
}

- (NSImage *)imageResize:(NSImage*)anImage
                 newSize:(NSSize)newSize
{
    NSImage *sourceImage = anImage;
    [sourceImage setScalesWhenResized:YES];
    
    // Report an error if the source isn't a valid image
    if (![sourceImage isValid])
    {
        NSLog(@"Invalid Image");
    } else
    {
        NSImage *smallImage = [[NSImage alloc] initWithSize: newSize] ;
        [smallImage lockFocus];
        [sourceImage setSize: newSize];
        [[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
        [sourceImage compositeToPoint:NSZeroPoint operation:NSCompositeCopy];
        [smallImage unlockFocus];
        return smallImage;
    }
    return nil;
}

- (NSImage*) adjustImage:(NSImage*)img withHue:(float)hue {
    
    CIImage *inputImage = [[CIImage alloc] initWithData:[img TIFFRepresentation]];
    
    CIFilter *hueAdjust = [CIFilter filterWithName:@"CIHueAdjust"];
    [hueAdjust setValue: inputImage forKey: @"inputImage"];
    [hueAdjust setValue: [NSNumber numberWithFloat: hue]
                 forKey: @"inputAngle"];
    CIImage *outputImage = [hueAdjust valueForKey: @"outputImage"];
    
    NSImage *resultImage = [[NSImage alloc] initWithSize:[outputImage extent].size];
    NSCIImageRep *rep = [NSCIImageRep imageRepWithCIImage:outputImage];
    [resultImage addRepresentation:rep];
    
    return resultImage;
    
}

@end
