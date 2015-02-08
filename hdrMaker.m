% below is hdr code. works 100% of the time all the time

% read in the input file
filename = 'inputs/imageInfo.txt';

%textread is depcrecated, but textscan returns a cell array and I don't
%understand them well enough to make it work
[imagefiles, shutters] = textread(filename, '%s %f');

numimgs = size(imagefiles,1);

imageX = 1024;
imageY = 768;

images = zeros(numimgs(1), imageY, imageX, 3);



for i = 1:numimgs
    
    %append file directory loc
    imageloc = strcat('inputs/',imagefiles(i));
    
    %read in this image
    imgmatrix = uint8(imread(char(imageloc)));
    
    %store in big images matrix
    images(i,:,:,:) = uint8(imgmatrix);
    
end

%images is now a cell array with each cell containing the entire
%3xwidthxheight image

% read in selected pixels
sfilename = 'inputs/selectedPixels.txt';

[x, y, desc] = textread(sfilename, '%u %u %s');

numpixels = size(x,1);

% set up Z(i,j) *** P = pictures, j indexs pictures; N = pixel points, i
% indexs pixel points


% set up Z and % get log of exposure time
Z = zeros(numpixels, numimgs, 3);
B = zeros(numpixels, numimgs);

for j = 1:numimgs
    for i = 1:numpixels
        % get the location
        locX = x(i); locY = y(i);
        
        % get the rgb in the location from the picture
        r = images(j,locY,locX,1);
        g = images(j,locY,locX,2);
        b = images(j,locY,locX,3);
        
        Z(i,j,1) = r;
        Z(i,j,2) = g;
        Z(i,j,3) = b;
        
        % put in the log exposure time
        B(i,j) = log(shutters(j));
    end
end

% pick your favourite lambda
l = 2;

[gR, leR] = gsolve(Z(:,:,1),B,l);
[gG, leG] = gsolve(Z(:,:,2),B,l);
[gB, leB] = gsolve(Z(:,:,3),B,l);

output = getHDRimg(gR,gG,gB,images,B(1,:));

image_rgb = tonemap(output);
figure;
image(image_rgb);
