function [ output_args ] = Saliency( image )
%CORNERDETECTION Summary of this function goes here
%   Detailed explanation goes here

%im = im2double(rgb2gray(image));
im=im2double(image);

dx = [-1 0 1;-1 0 1; -1 0 1];
dy = [-1 -1 -1; 0 0 0; 1 1 1];
Ix = conv2(im,dx,'same');
Iy = conv2(im,dy,'same');
gaussian = Gaussian(16,16,3);
IxSquare = conv2(Ix.^2,gaussian,'same');
IySquare = conv2(Iy.^2,gaussian,'same');
IxIy = conv2(Ix.*Iy,gaussian,'same');

k = 0.05;
R = (IxSquare.*IySquare - IxIy.^2) - k*(IxSquare + IySquare).^2;
%s = size(R);

%binary
%level=graythresh(R);
%BW=im2bw(R,level);

%output_args = BW;
output_args = R;