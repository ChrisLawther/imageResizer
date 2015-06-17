//
//  main.m
//  imageResizer
//
//  Created by Chris on 12/04/2015.
//  Copyright (c) 2015 Chris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/Appkit.h>

#import "NSImage+MGCropExtensions.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        // TODO : Proper command line arguments for:
        //        - targetSize
        //        - JPEG quality

        CGFloat targetSize = 640.0f;

        if (argc == 2)
        {
            targetSize = atof(argv[1]);
        }

        // Read input from stdin
        NSFileHandle *input = [NSFileHandle fileHandleWithStandardInput];
        NSData *inputData = [NSData dataWithData:[input readDataToEndOfFile]];

        // Make an image out of it
        NSImage *original = [[NSImage alloc] initWithData:inputData];

        // Work out target dimensions
        NSSize size = [original size];


        if (size.width > size.height)
        {
            size.height = targetSize * size.height / size.width;
            size.width = targetSize;
        } else {
            size.width = targetSize * size.width / size.height;
            size.height = targetSize;
        }

        // Get a scaled version of our image
        NSImage *scaled = [original imageScaledToFitSize:size];

        // Getting a JPEG representation of that image is a multi-step process...

        // ...TIFF first
        NSData *imageData = [scaled TIFFRepresentation];

        // ...then bitmap
        NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];

        // ... and finally JPEG
        NSNumber *compressionFactor = [NSNumber numberWithFloat:0.9];
        NSDictionary *imageProps = @{NSImageCompressionFactor: compressionFactor};

        imageData = [imageRep representationUsingType:NSJPEGFileType properties:imageProps];

        // Write the JPEG data to sdout
        NSFileHandle *output = [NSFileHandle fileHandleWithStandardOutput];
        [output writeData:imageData];

    }
    return 0;
}
