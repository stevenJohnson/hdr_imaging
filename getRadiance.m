function [ e ] = getRadiance( g, t, zs )
%GETRADIANCE get the radiance of a all channels of all pixels
%   g is the camera response function for all channels
%   t is the array of shutter speeds
%   zs is the array of intensities for all pixels

w = weight(zs);

num = sum((w.*(g(zs+1)-t(:,ones(size(zs,2),1),ones(size(zs,3),1),ones(size(zs,4),1)))));
denom = sum(w);

e = squeeze(exp(double(num) ./ denom));

end