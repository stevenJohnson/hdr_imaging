function [ out_shifts ] = getShift( image1, image2, shift_bits )
%getShift Summary of this function goes here
%   Detailed explanation goes here

% Noise tolerance for within median
tolerance = 4;

height = size(image1, 1);
width = size(image1, 2);

%TODO
if shift_bits > 0
    smaller1 = imgShrink2(image1);
    smaller2 = imgShrink2(image2);
    cur_shifts = getShift(smaller1, smaller2, shift_bits-1);
    cur_shifts = cur_shifts*2;
else
    cur_shifts = [0; 0];
end

[tb1, eb1] = computeBitmaps(image1, tolerance);
[tb2, eb2] = computeBitmaps(image2, tolerance);

min_err = width*height;

for y=-1:1
    for x=-1:1
        ys = cur_shifts(1) + y;
        xs = cur_shifts(2) + x;

        shifted_tb2 = BitmapShift(tb2, xs, ys);
        shifted_eb2 = BitmapShift(eb2, xs, ys);

        diff = BitmapXOR(tb1, shifted_tb2);
        diff = and(diff, eb1);
        diff = and(diff, shifted_eb2);
        err = BitmapTotal(diff);
        if (err < min_err)
            out_shifts(1) = ys;
            out_shifts(2) = xs;
            min_err = err;
        end     
    end
end

end

