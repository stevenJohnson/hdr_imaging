function [ grayed ] = grayscale( input_img )
%grayscale Return a 2D grayscale image from the RGB input image
%   Self explanatory...

grayed = zeros(size(input_img,1), size(input_img,2));

%approximate grayscale as dist over sRGB
grayed(:,:) = double((54*double(input_img(:,:,1)) + ...
                 183*double(input_img(:,:,2)) + ...
                  19*double(input_img(:,:,3)) )) / double(256);

end