function [ e ] = getRadiance( g, t, zs )
%GETRADIANCE get the radiance of a single channel of a single pixel
%   g is the camera response function for that channel (r,g,or b)
%   t is the array of shutter speeds
%   zs is the array of intensities for that pixel location

num = 0;
denom = 0;
for i = 1:size(t,1)
    num = num + weight(zs(i)) * (g(zs(i)+1) - t(i));
    denom = denom + weight(zs(i));
    
end

e = exp(num / denom);



end

