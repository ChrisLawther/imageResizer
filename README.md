# imageResizer

OSX already has a quick image resizing utility, `sips`, but it writes back to
the original file, which often is not what is required. This tool addresses
that, employing Matt Gemmell's 'ImageCrop'.

Usage:

    imageResizer [target_size] < inputFile > outputFile

Where:

target_size - a single dimension. The image will be scaled, preserving
              aspect ratio, such that it's largest dimension matches target_size (defaults to 640)

## Building

A simple `make`, which fetches Matt's NSImage category.


