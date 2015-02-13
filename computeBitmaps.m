function [ thresh_map, excl_map ] = computeBitmaps( input_img, tolerance )
%computeBitmaps Compute the threshold bitmap and exclusion bitmap
%   Compute the threshold bitmap and exclusion bitmap

height = size(input_img, 1);
width = size(input_img, 2);

thresh_map = zeros(height, width);
excl_map = zeros(height, width);

threshold = median(median(input_img));

for y=1:height;
    for x =1:width;
        thresh_map(y,x) = 1*(input_img(y,x)>threshold);
        if abs(input_img(y,x)-threshold)>tolerance;
            excl_map(y,x) = 0;
        else
            excl_map(y,x) = thresh_map(y,x);
        end
    end
end

end

