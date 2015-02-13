function [ output_img ] = BitmapShift( input_img, x_shift, y_shift )
%BitmapShift Shift input by x_shift,y_shift
%   Exposed borders are zero'd.

height = size(input_img,1);
width = size(input_img,2);

output_img = ones(height, width);

for y=1:height
    new_y = y - y_shift;
    if (new_y < 1 || new_y > height)
        continue;
    end
    
    for x=1:size(output_img,2)
        new_x = x - x_shift;
        if (new_x < 1 || new_x > width)
            continue;
        else
            output_img(y,x) = input_img(y+y_shift, x+x_shift);
        end
    end
end

