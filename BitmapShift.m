function [ output_bmp ] = BitmapShift( input_img, y_shift, x_shift )
%BitmapShift Shift input by x_shift,y_shift
%   Exposed borders are zero'd.

height = size(input_img,1);
width = size(input_img,2);

output_bmp = ones(height, width);

for y=1:height
    new_y = y - y_shift;
    if (new_y < 1 || new_y > height)
        continue;
    end
    
    for x=1:size(output_bmp,2)
        new_x = x - x_shift;
        if (new_x < 1 || new_x > width)
            continue;
        else
            output_bmp(y,x) = input_img(new_y, new_x);
        end
    end
end

