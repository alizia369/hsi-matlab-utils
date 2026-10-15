function n = normalise_smooth(datacube)
%if ~isa(datacube,'double')
%    datacube = double(datacube); 
%end
datacube = im2double(datacube);
[m, n, b] = size(datacube);
n = zeros(m/2,n/2,b);
for i = 1:b
    slice = squeeze(datacube(:,:,i));    
    outslice = GaussianPyramid(slice,2);
    n(:,:,i) = outslice;
end