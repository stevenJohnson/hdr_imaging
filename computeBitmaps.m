function [ thresh_map, excl_map ] = computeBitmaps( input_img, tolerance )
%computeBitmaps Compute the threshold bitmap and exclusion bitmap
%   Compute the threshold bitmap and exclusion bitmap

height = size(input_img, 1);
width = size(input_img, 2);

thresh_map = zeros(height, width);
excl_map = zeros(height, width);

threshold = median(median(input_img));

thresh_map(:,:) = 1*(input_img(:,:)>threshold);
excl_map(:,:) = 1*(abs(input_img(:,:)-threshold)>=tolerance);

end

