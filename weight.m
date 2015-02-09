function [ w ] = weight(z)
%WEIGHT Returns the weight of a certain pixel based on it's intensity.
%   The distance of the pixel's intensity from center (128) determines it's
%   weight. Extremes are weighted less than those around mid-range.

% mu = 128;
% s = 60;
% 
% p1 = -.5 * ((x - mu)/s) .^ 2;
% p2 = (s * sqrt(2*pi));
% w = 10*exp(p1) ./ p2;


zmax = 255;
zmin = 0;

w = min( z-zmin, zmax-z);

%For pixels at the extreme, give them epsilon-small weight
if w == 0
    w = 1;
end

end

