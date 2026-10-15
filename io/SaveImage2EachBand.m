clear
clc

list = struct2cell(dir('.\data\rgb 3d reconstruction imades\20181220_Tree_4x4_HSI\pics'));
if size(list, 2) < 3
    fprintf('Folder is empty.\n')
else
    for i = 3 : size(list, 2)
        fname = [list{2,i}, '\',list{1,i}];
        I = imread(fname);
        DataCube = X2CubeFor16BandVIS(I);
%                 DataCube = X2CubeFor25Band(I);
        for k = 1:16
%                imshow(uint8(DataCube(:,:,k)))
%                waitforbuttonpress
%                DataBand = 255*((DataCube(:,:,k) - min(DataCube(:,:,k))) ./ (max(DataCube(:,:,k)) - min(DataCube(:,:,k))));
            DataBand = uint8(255*mat2gray(DataCube(:,:,k)));
%                figure
%                imshow(uint8(DataBand))
%                waitforbuttonpress
            
            fname2 = ['.\data\rgb 3d reconstruction imades\20181220_Tree_4x4_HSI\EachBand\'...'
                    'Band',num2str(k),'\',num2str(k),'_',num2str(i-2),'.jpg'];
            imwrite(uint8(DataCube(:,:,k)),fname2,'jpg')
        end
        fprintf('Processing Picture %d / %d... \n',i-2,size(list ,2) - 2)
    end
    
end





