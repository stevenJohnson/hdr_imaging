function [ xor_result ] = BitmapXOR( bitmap1, bitmap2 )
%BitmapXOR XOR's two bitmap images
%   Self explanatory

height = size(bitmap1, 1);
width = size(bitmap1, 2);

xor_result = zeros(height, width);

for y=1:height
    for x=1:width
        xor_result(y,x) = xor(bitmap1(y,x),bitmap2(y,x));
    end
end

end

%% TO TEST
%white = ones(768,1024);
%black = zeros(768,1024);

%BitmapXOR(white, black) %should return all 1's
%BitmapXOR(white, white) %should return all 0's
%BitmapXOR(black, black) %should return all 0's