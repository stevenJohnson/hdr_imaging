function [ output ] = reinhard ( hdr, a ) 
%%
%Typical alphas range from 0.045 to 0.72
% we use 0.18

output = zeros(size(hdr,1),size(hdr,2),size(hdr,3));

N = size(hdr,1)*size(hdr,2);
delta = .0001;

for i=1:size(hdr,3)
    
    Lwhite = max(max(hdr(:,:,i)));

    L_w = exp((1/N)*(sum(sum(log(hdr(:,:,i) + delta)))));
    
    output(:,:,i) = a*hdr(:,:,i)/L_w;

    for y=1:size(output,1)
        for x=1:size(output,2)
            num = output(y,x,i)*(1+(output(y,x,i)/(Lwhite*Lwhite)));
            denom = 1+output(y,x,i);
            output(y,x,i) = num / denom;
            
        end
    end 
    

end

end