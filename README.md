# CS 766 High-Dynamic Range Implementation

## Setup
Create a directory in the "inputs" with all exposures.
Create a text file in "inputs" that contains information about the exposures, as follows:

    Line 1: The directory above, followed by a 0
    Line 2: The image width and height
    Line X: Image name and exposure time in seconds (decimal)
  
Below is an example of such a file:

    second_floor  0
    1024  768
    IMG_01.JPG  4
    IMG_02.JPG  0.5
    IMG_03.JPG  0.001

Finally, in hdrMaker.m, add the filename of the above text file in the relevant code location as below:

    filename = 'inputs/second_floorInfo.txt';

hdrMaker can then be run, and camera response curves and a final image will be displayed.

## Debevec's Method: Recovering High Dynamic Range Radiance Maps from Photographs
    http://vsingh-www.cs.wisc.edu/cs766-12/lec/debevec-siggraph97.pdf

hdrMaker uses Debevec's method to create the radiance map of the underlying scene. Multiple photographs of the scene are taken with different amounts of exposure, and the algorithm uses these differently exposed photographs to recover the response function of the camera. With the known camera response function, the algorithm can fuse the multiple photographs into a single, high dynamic range radiance map whose pixel values are proportional to the true radiance values in the scene. 

## Reinhard Tonemapping: Photographic Tone Reproduction for Digital Images
    http://www.cmap.polytechnique.fr/~peyre/cours/x2005signal/hdr_photographic.pdf
The algorithm leverages the techniques of photographic practice to develop a new tone reproduction mapping. In particular, it extends the techniques developed by Ansel Adams to deal with digital images. The algorithm is simple and produces good results for a wide variety of images.

## Image alignment: Fast, robust image registration for compositing high dynamic range photographs from hand-held exposures
    http://pages.cs.wisc.edu/~lizhang/courses/cs766-2008f/projects/hdr/jgtpap2.pdf

This algorithm is an automatic method for translational alignment of photographs. The algorithm uses percentile threshold bitmaps to avoid problems with varying exposures used in HDR images. Image pyramids are used from grayscale exposures, and these pyramids are converted to bitmaps. The bitmaps are aligned vertically and horizontally using fast shift and difference operations.


## Alternative Tonemapping: Adaptive Logarithmic Mapping For Displaying High Contrast Scenes
    http://pages.cs.wisc.edu/~lizhang/courses/cs766-2012f/projects/hdr/Drago2003ALM.pdf

This algorithm is a fast, high quality tone mapping technique to display high contrast images on devices with limited dynamic range of luminance values. The method is based on logarithmic compression of luminance values, imitating the human response to light. A bias power function is used to adaptively vary logarithmic bases, resulting in good preservation of details and contrast. To improve contrast in dark areas, changes to the gamma correction procedure are used.
