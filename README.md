# imageResizer

OSX already has a quick image resizing utility, `sips`, but it writes back to
the original file, which often is not what is required. This tool addresses
that, employing Matt Gemmell's 'ImageCrop'.

Usage:

    imageResizer [target_size] < inputFile > outputFile

Where:

target\_size (optional) - a single dimension. The image will be scaled, preserving
aspect ratio, such that it's largest dimension matches target\_size (defaults to 640)

# Building

A simple `make`, which fetches Matt's NSImage category.

# Performance

Performance is comparable to `sips`, but with the advantage of leaving the original
file intact, while adding the option of redirecting output to any file or process.
ImageMagick, while significantly more powerful and flexible, is approximately 15x slower.

The timings shown below are for resizing a 7000x5250 pixel image to 640x480 by various methods:

ImageMagick

    $ time convert input.jpg -resize 640x640 im.jpg
    2.88s user 0.14s system 99% cpu 3.029 total

imageResizer

    $ time ./imageResizer < input.jpg > imageresizer.jpg
    0.19s user 0.02s system 96% cpu 0.219 total

sips

    $ time sips -Z 640 input.jpg
    0.18s user 0.01s system 93% cpu 0.210 total
