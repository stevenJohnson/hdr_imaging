function [ dispic ] = getHDRimg(g, images, t )
%GETHDRIMG Create HDR image
%   Create HDR image from camera response curves and exposures
%   images, t is ordered array of expsures and exposure times
%   g are camera response curves

dispic = getRadiance(g, t, images);

index = find(isnan(dispic) | isinf(dispic));
dispic(index) = 0;

end

