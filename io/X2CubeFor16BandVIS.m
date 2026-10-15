function DataCube=X2CubeFor16BandVIS(I)
%Input Ximea 1088*2048 image
%Output 256*512*14 datacube
block=4;
I=double(I);
black=double(imread('blackvis.tif'));
%%%%dark calibration
I=I-black;
I=I(33:32+1024,1:2048);
DataCube = im2colstep(I',[block block],[block,block]);
DataCube=DataCube';
%spectral calibration
CorrectionMatrix=load('cormat_9_2_3_7.mat');
CorrectionMatrix=CorrectionMatrix.cormat;
DataCube=CorrectionMatrix*DataCube';

[x,y]=size(I);
DataCube=max(DataCube,eps);
%sz=[512 256];
sz=[y x];
DataCube=reshape(DataCube',[sz(1:2),size(CorrectionMatrix,1)]);
DataCube=permute(DataCube,[2,1,3]);
end
