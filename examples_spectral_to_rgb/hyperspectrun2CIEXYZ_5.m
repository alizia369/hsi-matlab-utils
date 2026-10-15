
%Load the illuminant spectrum illum_6500 and obtain reflected radiances radiances_6500. 

load illum_6500.mat;
radiances_6500 = zeros(size(reflectances)); % initialize array
for i = 1:33,
  radiances_6500(:,:,i) = reflectances(:,:,i)*illum_6500(i);
end


%Record the size of the array radiances_6500, and then reshape it as a matrix of w columns for matrix multiplication with the colour-matching functions. 


[r c w] = size(radiances_6500);
radiances_6500 = reshape(radiances_6500, r*c, w);

%Load the CIE 1931 colour matching functions xyzbar and take the matrix product of xyzbar with radiances to get the tristimulus values XYZ at each pixel. For simplicity XYZ is not normalized. 
load xyzbar.mat;
XYZ = (xyzbar'*radiances_6500')';

%Correct the shape of XYZ so that it represents the original 2-dimensional image with three planes (rather than a matrix of 3 columns), and ensure that the values of XYZ range within 0-1. 

XYZ = reshape(XYZ, r, c, 3);
XYZ = max(XYZ, 0);
XYZ = XYZ/max(XYZ(:));
