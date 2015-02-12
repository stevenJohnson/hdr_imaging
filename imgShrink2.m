function [ output ] = imgShrink2( input )
%imgShrink2 Shrink image by factor of 2
%   Self-explanatory

output = imresize(input, 0.5, 'bilinear');

end

