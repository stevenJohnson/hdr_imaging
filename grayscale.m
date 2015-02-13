function [ grayed ] = grayscale( input_img )
%grayscale Return a 2D grayscale image from the RGB input image
%   Detailed explanation goes here

%approximate grayscale as dist over sRGB
grayed(:,:) = (54*input_img(:,:,1) + ...
                 183*input_img(:,:,2) + ...
                  19*input_img(:,:,3) ) / 256;

end

