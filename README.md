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

hdrMaker can then be run, and camera response curves and a final image will be output.

## Debevec's Method
hdrMaker uses Debevec's method to create the radiance map of the underlying scene.

## Reinhard Tonemapping

## Image alignment
## Alternative Tonemapping: Drago
