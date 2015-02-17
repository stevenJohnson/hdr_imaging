function [ w ] = weight(z)
%WEIGHT Returns the weight of a certain pixel based on it's intensity.
%   The distance of the pixel's intensity from center (128) determines it's
%   weight. Extremes are weighted less than those around mid-range.

zmax = 255;
zmin = 0;

w = min(z - zmin, zmax - z);

end

