% below is hdr code. works 100% of the time all the time

% read in the input file
filename = 'inputs/imageInfo.txt';

%textread is depcrecated, but textscan returns a cell array and I don't
%understand them well enough to make it work
[imagefiles, shutters] = textread(filename, '%s %f');

numimgs = size(imagefiles,1);

imageX = 1024;
imageY = 768;

scalefactor = .5;

images = zeros(numimgs(1), imageY, imageX, 3);

simageX = ceil(imageX*scalefactor);
simageY = ceil(imageY*scalefactor);

imagessmall = zeros(numimgs(1), simageY, simageX, 3);

for i = 1:numimgs
    
    %append file directory loc
    imageloc = strcat('inputs/',imagefiles(i));
    
    %read in this image
    imgmatrix = uint8(imread(char(imageloc)));
    
    %store in big images matrix
    images(i,:,:,:) = uint8(imgmatrix);
    
    % also store in scaled images matrix
    tmp = (imresize(imgmatrix, scalefactor));
    imagessmall(i,:,:,:) = tmp;
end

disp('set up images.');

%images is now a cell array with each cell containing the entire
%3xwidthxheight image

%%%%%% here is scaling sampling method

% take m pixels in y direction and n pixels in x direction in a grid
m = 30;
n = 30;

xs = floor(linspace(1, simageX, n));
ys = floor(linspace(1, simageY, m));

numpixels = m*n;
coords = zeros(numpixels, 2);
% construct coordinates grid
for j = 1:m
    for i = 1:n
        coords((j-1)*n + i, 1) = xs(i);
        coords((j-1)*n + i, 2) = ys(j);
    end
end

% set up Z and % get log of exposure time
Z = zeros(numpixels, numimgs, 3);
B = zeros(numpixels, numimgs);

for j = 1:numimgs
    for i = 1:numpixels
        % get the location
        locX = coords(i,1); locY = coords(i,2);
        
        % get the rgb in the location from the picture
        r = imagessmall(j,locY,locX,1);
        g = imagessmall(j,locY,locX,2);
        b = imagessmall(j,locY,locX,3);
        
        Z(i,j,1) = r;
        Z(i,j,2) = g;
        Z(i,j,3) = b;
        
        % put in the log exposure time
        B(i,j) = log(shutters(j));
    end
end

disp('sampled.');

%%%%%% here is end of scaling sampling method




% 
% 
% % read in selected pixels
% sfilename = 'inputs/selectedPixels.txt';
% 
% [x, y, desc] = textread(sfilename, '%u %u %s');
% 
% numpixels = size(x,1);
% 
% % set up Z(i,j) *** P = pictures, j indexs pictures; N = pixel points, i
% % indexs pixel points
% 
% 
% % set up Z and % get log of exposure time
% Z = zeros(numpixels, numimgs, 3);
% B = zeros(numpixels, numimgs);
% 
% for j = 1:numimgs
%     for i = 1:numpixels
%         % get the location
%         locX = x(i); locY = y(i);
%         
%         % get the rgb in the location from the picture
%         r = images(j,locY,locX,1);
%         g = images(j,locY,locX,2);
%         b = images(j,locY,locX,3);
%         
%         Z(i,j,1) = r;
%         Z(i,j,2) = g;
%         Z(i,j,3) = b;
%         
%         % put in the log exposure time
%         B(i,j) = log(shutters(j));
%     end
% end

% pick your favourite lambda
l = 4;

[gR, leR] = gsolve(Z(:,:,1),B,l);
[gG, leG] = gsolve(Z(:,:,2),B,l);
[gB, leB] = gsolve(Z(:,:,3),B,l);

disp('starting solver.');
output = getHDRimg(gR,gG,gB,images,B(1,:));

% tonemapped = zeros(imageY,imageX,3);
% 
% % tonemap hack
% for j = 1:imageY
%     for i = 1:imageX
%         Rval = output(j,i,1);
%         Gval = output(j,i,2);
%         Bval = output(j,i,3);
%         
%         Rtmp = abs(gR - Rval);
%         Gtmp = abs(gG - Gval);
%         Btmp = abs(gB - Bval);
%         
%         [~, Ridx] = min(Rtmp);
%         [~, Gidx] = min(Gtmp);
%         [~, Bidx] = min(Btmp);
%         
%         tonemapped(j,i,1) = Ridx;
%         tonemapped(j,i,2) = Gidx;
%         tonemapped(j,i,3) = Bidx;
%     end
% end
% 
% %image_rgb = tonemap(output);
% figure;
% image(uint8(tonemapped));
figure;
hold on;
plot(gR); plot(gG); plot(gB);

figure;
image(tonemap(output));
