   
function OutImg = GaussianPyramid(image,level)

pyramid = cell(level,1);
pyramid{1} = image;

for level=2:level
    im = gausmooth(pyramid{level-1});
    s=ceil(size(pyramid{level-1})/2.0);
	pyramid{level} = imresize(im,s);
  % figure,imshow(pyramid{level});
end
OutImg = pyramid{level};

function im = gausmooth(im)

[m,n] = size(im);
GaussianDieOff = .0001;  
pw = 1:30; 
ssq = 2;
width = find(exp(-(pw.*pw)/(2*ssq))>GaussianDieOff,1,'last');
if isempty(width)
    width = 1;  % the user entered a really small sigma
end
t = (-width:width);
gau = exp(-(t.*t)/(2*ssq))/sum(exp(-(t.*t)/(2*ssq)));     

im = imfilter(im, gau,'conv','replicate');   % run the filter accross rows
im = imfilter(im, gau','conv','replicate'); % and then accross columns