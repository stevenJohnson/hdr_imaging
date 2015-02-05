% below is hdr code. works 100% of the time all the time

% read in the input file (TODO::: pass in the file name)
file = fopen('inputs/imageInfo.txt', 'r');
a = textscan(file, '%s', 'Delimiter', '\n');
fclose(file);
