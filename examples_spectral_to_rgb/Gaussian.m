function [ output_args ] = Gaussian( xSize,ySize,sigma )
%GAUSSIAN Summary of this function goes here
%   Detailed explanation goes here
test = zeros(xSize);
gap = xSize / 2;
for x = 1:xSize
    for y = 1:ySize
        test(x,y) = exp(-( (x-gap)*(x-gap) + (y-gap)*(y-gap) ) / (2*sigma*sigma) );
    end
end
output_args = test;