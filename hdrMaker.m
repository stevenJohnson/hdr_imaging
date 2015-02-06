% below is hdr code. works 100% of the time all the time

% read in the input file (TODO::: pass in the file name)
filename = 'inputs/imageInfo.txt';
[imagefiles, fstops] = textread(filename, '%s %s');

%would be nice to auto get this, but too much work right now
img_width = 1024;
img_height = 768;

numimgs = size(imagefiles);

images = zeros(numimgs);

%%OVERFLOWS MEMORY, NOT SURE WHY
%%maybe because using some weird data type, we only need/want uint8 (8
%%bits)
for i = 1:numimgs    
    
    i
    %prealloc image space
    images(i) = zeros(img_width*img_height);
    
    %append file directory loc
    imageloc = strcat('inputs/',imagefiles(i));
    
    %read in this image
    imgmatrix = imread(char(imageloc));
    
    %store in big images matrix
    images(i) = imgmatrix;
end

