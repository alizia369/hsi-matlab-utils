%function [ output_args ] = loadReflectanceData_1( input_args )
%LOADREFLECTANCEDATA Summary of this function goes here
%   Detailed explanation goes here


load ref4_scene4.mat;
size(reflectances) 

% getting one image slice

slice = reflectances(:,:,17);
%imshow(slice);
%figure; imagesc(slice); colormap('gray'); brighten(0.5);

%setappdata(0,'reflectances',reflectances);

% Increasing image intensity - Normalizing Image

z = max(slice(100, 39));
slice_clip = min(slice, z)/z;
figure; imagesc(slice_clip.^0.4); colormap('gray'); 


%end

