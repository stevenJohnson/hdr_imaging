function [ dispic ] = getHDRimg( gR,gG,gB, images, t )
%GETHDRIMG Create HDR image
%   Create HDR image from camera response curves and exposures
%   images, t is ordered array of expsures and exposure times
%   gR,gG,gB are camera response curves

imageX = size(images, 3);
imageY = size(images, 2);

dispic = zeros(imageY,imageX,3);

for y = 1:imageY
    for x = 1:imageX
        
        rs = images(:, y, x, 1);
        gs = images(:, y, x, 2);
        bs = images(:, y, x, 3);
        
        % get radiance for colors
        dispic(y,x,1) = getRadiance(gR,t,rs);
        dispic(y,x,2) = getRadiance(gG,t,gs);
        dispic(y,x,3) = getRadiance(gB,t,bs);
    end
end

end

