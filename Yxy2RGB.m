function [ rgb_float ] = Yxy2RGB( yxy_image )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here

eps = 0.000001;

Yxy2RGB = [ 2.5651, -1.1665, -0.3986; ...
		   -1.0217, 1.9777, 0.0439; ...
		    0.0753, -0.2543, 1.1892 ];

rgb_float = zeros(size(yxy_image,1),size(yxy_image,2), 3);
        
for y=1:size(yxy_image,1)
    for x=1:size(yxy_image,2)
        Y = yxy_image(y,x,1);
        if ((Y > eps) && (yxy_image(y,x,2) > eps) && (yxy_image(y,x,3) > eps))
            X = (yxy_image(y,x,2)*Y) / yxy_image(y,x,3);
            Z = (X/yxy_image(y,x,2)) - X - Y;
        else
            X = eps;
            Z = eps;
        end

        for c=1:3
            rgb_float(y,x,c) = Yxy2RGB(c,1)*X ...
                             + Yxy2RGB(c,2)*Y ...
                             + Yxy2RGB(c,3)*Z;
        end
    end
end
              
end

