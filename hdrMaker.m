% below is hdr code. works 100% of the time all the time

% read in the input file
filename = 'inputs/imageInfo.txt';

%textread is depcrecated, but textscan returns a cell array and I don't
%understand them well enough to make it work
[imagefiles, shutters] = textread(filename, '%s %s');

numimgs = size(imagefiles);

images = cell(numimgs);

for i = 1:numimgs    
    
    %append file directory loc
    imageloc = strcat('inputs/',imagefiles(i));
    
    %read in this image
    imgmatrix = uint8(imread(char(imageloc)));
    
    %store in big images matrix
    images{i} = uint8(imgmatrix);
end

%images is now a cell array with each cell containing the entire
%3xwidthxheight image