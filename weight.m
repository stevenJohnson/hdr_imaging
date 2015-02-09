function w = weight(x)

zmax = 255;
zmin = 0;

% mu = 128;
% s = 60;
% 
% p1 = -.5 * ((x - mu)/s) .^ 2;
% p2 = (s * sqrt(2*pi));
% w = 10*exp(p1) ./ p2;

if x > (zmax+zmin)/2
    w = zmax - x;
else
    w = x - zmin;
end
end