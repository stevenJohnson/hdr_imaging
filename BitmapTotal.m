function [ accum ] = BitmapTotal( xord_bitmap )
%BitmapTotal Accumulates all differences in xord_bitmap
%   Add's all the 1's...

accum = sum(xord_bitmap(:));

end

