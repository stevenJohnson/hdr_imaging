% gsolve.m ? Solve for imaging system response function
%
% Given a set of pixel values observed for several pixels in several
% images with different exposure times, this function returns the
% imaging system?s response function g as well as the log film irradiance
% values for the observed pixels.
%
% Assumes:
%
% Zmin = 0
% Zmax = 255
%
% Arguments:
%
% Z(i,j) is the pixel values of pixel location number i in image j
% B(j) is the log delta t, or log shutter speed, for image j
% l is lamdba, the constant that determines the amount of smoothness
% w(z) is the weighting function value for pixel value z
%
% Returns:
%
% g(z) is the log exposure corresponding to pixel value z
% lE(i) is the log film irradiance at pixel location i

function [g,lE]=gsolve(Z,B,l)

n = 256;
A = zeros(size(Z,1) * size(Z,2)+n+1, n+size(Z,1));
b = zeros(size(A,1), 1);
k = 1;

%% Include the data-fitting equations
for i = 1:size(Z,1)
    for j=1:size(Z,2)
        wij = weight(Z(i,j)+1);
        A(k,Z(i,j)+1) = wij; A(k,n+i) = -wij; b(k,1) = wij * B(i,j);
        k=k+1;
    end
end
A(k,129) = 1;

%% Fix the curve by setting its middle value to 0
k=k+1;
for i=1:n-2  %% Include the smoothness equations
    A(k,i)=l*weight(i+1); A(k,i+1)=-2*l*weight(i+1); A(k,i+2)=l*weight(i+1);
    k=k+1;
end
x = A\b;

%% Solve the system using SVD
g = x(1:n);
lE = x(n+1:size(x,1));