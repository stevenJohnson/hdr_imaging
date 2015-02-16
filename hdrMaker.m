%HDRMAKER Takes a set of exposures and creates a visually appealling HDR
%image.
%   Below is hdr code. works 100% of the time all the time

%% TIMER
tic; %start stopwatch
%% Set Parameters
alpha = 0.18;
lambda = 10;

scalefactor = .03;
sizeX = 15; sizeY = 20;

%% File Setup
disp('Beginning HDR image construction from exposures and images in ./');

%filename = 'inputs/testInfo.txt';
%filename = 'inputs/second_floorInfo.txt';
%filename = 'inputs/SteenbocksInfo.txt';
filename = 'inputs/WhitesMoveInfo.txt';
%filename = 'inputs/StevensNightInfo.txt';
disp(filename);

% read in the input file
%textread is depcrecated, but textscan returns a cell array and I don't
%understand them well enough to make it work
[imagefiles, shutters] = textread(filename, '%s %f');
dir = imagefiles(1);
width = str2num(cell2mat(imagefiles(2)));
height = shutters(2);

imagefiles(1) = []; shutters(1) = [];
imagefiles(1) = []; shutters(1) = [];

disp('Image filenames and shutter times acquired.');

%Number of exposures
N = size(imagefiles,1);

%% Read in images to MATLAB memory, set up sampling of scaled calibration points

%Initialize memory needed for all images
images = zeros(N(1), height, width, 3);

scaled_width = ceil(width*scalefactor);
scaled_height = ceil(height*scalefactor);

scaled_images = zeros(N(1), scaled_height, scaled_width, 3);

disp('Reading images into matrix memory...');
for i = 1:N
    
    %append file directory location
    imageloc = strcat('inputs/',dir,'/',imagefiles(i));
    
    %read in this image
    imgmatrix = uint8(imread(char(imageloc)));
    
    %store in big images matrix
    images(i,:,:,:) = uint8(imgmatrix);
    
    % also store in scaled images matrix
    tmp = (imresize(imgmatrix, scalefactor, 'bilinear'));
    scaled_images(i,:,:,:) = tmp;

    imageloc %display most recently read-in image
end

toc %time reading in and scaling
disp('All full and scaled images read into memory.');

%% Scaling Sampling Method

disp('Beginning Scaled Sampling.');

% take m pixels in y direction and n pixels in x direction in a grid
m = sizeY;
n = sizeX;

xs = floor(linspace(1, scaled_width, n));
ys = floor(linspace(1, scaled_height, m));

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
Z = zeros(numpixels, N, 3);
B = zeros(numpixels, N);

for j = 1:N
    for i = 1:numpixels
        % get the location
        locX = coords(i,1); locY = coords(i,2);
        
        % get the rgb in the location from the picture
        r = scaled_images(j,locY,locX,1);
        g = scaled_images(j,locY,locX,2);
        b = scaled_images(j,locY,locX,3);
        
        Z(i,j,1) = r;
        Z(i,j,2) = g;
        Z(i,j,3) = b;
        
        % put in the log exposure time
        B(i,j) = log(shutters(j));
    end
end

toc %time subsampling
disp('Sampling for all images completed.');

%% Linear System Solving
disp('Starting solver.');
[gR, leR] = gsolve(Z(:,:,1),B,lambda);
[gG, leG] = gsolve(Z(:,:,2),B,lambda);
[gB, leB] = gsolve(Z(:,:,3),B,lambda);

toc %time System Solving
disp('System solved.');

%% Plotting Camera Response Curve
figure;
hold on;
plot(gR,'color','red'); plot(gG,'color','green'); plot(gB,'color','blue');
xlim([0 255]);
xlabel('RGB Intensity');
ylabel('ln(E) + ln(t)');
plot_title = sprintf('RGB Camera Response Curves with lambda = %d', lambda);
legend('Red channel','Green channel','Blue channel','Location', 'SouthEast');
title(plot_title);

%% DO HDR!!!
disp('Beginning HDR image construction.');
output = getHDRimg(gR,gG,gB,images,B(1,:));
disp('HDR image construction complete.');
final_image = reinhard(output, alpha);

%% Displaying final image using MATLAB tonemap
figure;
image(final_image);
%figure;image((reinhard(output,0.18)+drago(output))/2); title('the best method');
toc %time for entire program execution
