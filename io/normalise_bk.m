function n = normalise(datacube)
if ~isa(datacube,'double')
    datacube = double(datacube); 
end

minnum = min(datacube(:));
maxnum = max(datacube(:));
b = size(datacube,3);
for i = 1:b
    slice = squeeze(datacube(:,:,i));    
    outslice = (slice - minnum) / (maxnum-minnum);
    outslice = GaussianPyramid(outslice,2);
    n(:,:,i) = outslice;
end