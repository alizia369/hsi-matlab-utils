function [normat, bandName,savefilename] = saveCube_bilFile(filenamepath,dpath,imageflag,savepath)
%SAVECUBE_BILFILE Summary of this function goes here
%   Detailed explanation goes here
if(filenamepath(:,end)=='\')
   
        kind = strfind(filenamepath, '\');
        fname=filenamepath((kind(end-1)+1):end-5);
        opath=filenamepath(1:(kind(end-1)-1));

    else
        kind = strfind(filenamepath, '\');
        fname=filenamepath((kind(end)+1):end-4);
        opath=filenamepath(1:(kind(end)-1));
end

if (nargin > 3)
    
    savefilename=[savepath '\' fname '.mat'];
    if(imageflag)
    imgdir=[savepath '\' fname '_hyperimages\'];
    end
elseif (nargin > 2)
    

    savefilename=[opath '\' fname '.mat'];
    if(imageflag)
    imgdir=[opath '\' fname '_hyperimages\'];
    end

else
    
    
    savefilename=[opath '\' fname '.mat'];
    imageflag=false;
    dpath='';
    
end

if(imageflag)
    if (exist(imgdir,'dir')==7)
        
    else
        mkdir(imgdir);
    end
end
    


%fname
%savefilename


len = length(filenamepath);
if filenamepath(len-3) =='.'
   prefix = filenamepath(1:len-4);
end
headername = strcat(prefix,'.hdr');
dataname = strcat(prefix,'');%bil is already there

 info = read_envihdr(headername);
 header_offset=0;
 dataC = multibandread(dataname, info.size, [info.format '=>double'], header_offset, info.interleave, info.machine);
 disp(['processing ',dataname])
 




dataCube=dataC;
bandName=info.wavelength;


%%% Normalization

%%%Dark normalization
if(~isempty(dpath))
    
    %dark_cube=    %not done
    
end

%mat = normalise(datacube, 'percent', 0.999);
norflag=true;
if(norflag)

  %dataCube = normalise(dataCube, 'percent', 0.999);
  minval=min(dataCube(:));
  %maxVal=mean(maxk(dataCube(:),50));
  maxVal=max(dataCube(:));
  dataCube = (dataCube- minval) / (maxVal-minval);
%   [numRows,numCols,numSpectra] = size(dataCube);
%   scfact = mean(reshape(sqrt(sum(dataCube.^2,3)),numRows*numCols,1));
%   dataCube = dataCube./scfact;
 
end


%bandName(2)
if(iscell(bandName))
bandName=cell2mat(bandName);
end    
num = length(bandName);

if(imageflag)
    normat=zeros(size(dataCube));
     for b = 1:num
        slice = dataCube(:,:,b);
        %slice = imadjust(slice);   
        %normat(:,:,b)=slice;


        wl = bandName(b);
        imgname=[fname '_'  num2str(wl) '.png'];
        imgname
        imwrite(slice,[imgdir  '\' imgname]);    
        disp(b);

     end
 
end
 
%%%%%% Reducing Bands
%  finalMat=dataCube(:,:,3:4:end-4);
%  bandName= bandName(3:4:end-4);

%figure('Name','Original without rotation or crop','NumberTitle','off'),imshow(dataCube(:,:,12));

normat=dataCube;
end

