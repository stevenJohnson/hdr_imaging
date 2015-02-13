function [ output ] = drago ( hdr )
%drago Drago tonemapping algorithm

%ldmax is a scale factor (100 is commonly used)
ldmax = 100;

% b is a bias parameter (usually .5 to 1.0 range)
b = 0.656;

% gaussian smoothing 
gamma = 1;

% optional exposure factor
oef = 1;

output = zeros(size(hdr,1),size(hdr,2),size(hdr,3));

N = size(hdr,1)*size(hdr,2);
delta = .0001;

% convert rgb to xyz (y is luminance apparently)
xyz = rgb2Yxy(hdr);

% world adaptation luminance
L_wa = exp((1/N)*(sum(sum(log(xyz(:,:,1) + delta)))));
L_wa = L_wa / ((1+b-.85) ^ 5);

L_wmax = max(max(xyz(:,:,1)));
L_wmax = oef * L_wmax / L_wa; % scale the max by the adaptation luminance


% calculate display luminances
for y = 1:size(output,1)
    for x = 1:size(output,2)
        L_w = oef * (xyz(y,x,1)^gamma) / L_wa;
        
        leftN = ldmax * .01;
        leftD = log10(L_wmax + 1);
        left = double(leftN) / double(leftD);
        
        rightN = log(L_w + 1);
        rightexp = log(b) / log(.5);
        rightIn = L_w / L_wmax;
        rightD = log(2 + (( rightIn ^ rightexp ) * 8));
        right = double(rightN) / double(rightD);
        
        lD = left * right;
        
        %disp('_')
        lD;
        L_w;
        
        xyz(y,x,1) = lD;
    end
end

output = Yxy2RGB(xyz);

end