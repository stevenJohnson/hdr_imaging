function [ the_shift ] = alignerer( image1, image2, shift_bits )
%ALIGNERER Returns shift to align two images
%   Shift bits is log2(max_shift)


gimage1 = grayscale(image1);
gimage2 = grayscale(image2);

the_shift = getShift(gimage1, gimage2, shift_bits);

end

