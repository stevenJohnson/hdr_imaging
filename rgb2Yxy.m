function [ yxy_image ] = rgb2Yxy( rgb_float )
%rgb2Yxy Convert from RGB to Yxy...
%   Detailed explanation goes here

RGB2Yxy = [ 0.5141364, 0.3238786, 0.16036376; ...
            0.265068, 0.67023428, 0.06409157; ...
            0.0241188, 0.1228178, 0.84442666 ];

yxy_image = zeros(size(rgb_float,1),size(rgb_float,2), 3);
        
for y=1:size(rgb_float,1)
    for x=1:size(rgb_float,2)
        for c=1:3
            yxy_image(y,x,c) = RGB2Yxy(c,1)*rgb_float(y,x,1) ...
                             + RGB2Yxy(c,2)*rgb_float(y,x,2) ...
                             + RGB2Yxy(c,3)*rgb_float(y,x,3);
        end
        
        W = sum(yxy_image(y,x,:));
        if (W > 0)
            tmp1 =  yxy_image(y,x,1);
            tmp2 =  yxy_image(y,x,2);
            yxy_image(y,x,1) = yxy_image(y,x,2);
            yxy_image(y,x,2) = tmp1/double(W);
            yxy_image(y,x,3) = tmp2/double(W);
        else
            yxy_image(y,x,:) = 0;
        end
    end
end

end

