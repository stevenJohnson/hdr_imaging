function [ output ] = drago ( hdr )

%ldmax is a scale factor (100 is commonly used)
ldmax = 100;

% b is a bias parameter (usually .5 to 1.0 range)
b = .75;

output = zeros(size(hdr,1),size(hdr,2),size(hdr,3));

N = size(hdr,1)*size(hdr,2);
delta = .0001;

% convert rgb to xyz (y is luminance apparently)
xyz = rgb2xyz(hdr);

% world adaptation luminance
L_wa = exp((1/N)*(sum(sum(log(xyz(:,:,2) + delta)))))

L_wmax = max(max(xyz(:,:,2)));
L_wmax = L_wmax / L_wa % scale the max by the adaptation luminance


% calculate display luminances
for y = 1:size(output,1)
    for x = 1:size(output,2)
        L_w = xyz(y,x,2);
        
        leftN = ldmax * .01;
        leftD = log(10, L_wmax + 1);
        
    end
end


output = xyz;

end