function varargout = crop_hypercube(varargin)
% CROP_HYPERCUBE MATLAB code for crop_hypercube.fig
%      CROP_HYPERCUBE, by itself, creates a new CROP_HYPERCUBE or raises the existing
%      singleton*.
%
%      H = CROP_HYPERCUBE returns the handle to a new CROP_HYPERCUBE or the handle to
%      the existing singleton*.
%
%      CROP_HYPERCUBE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CROP_HYPERCUBE.M with the given input arguments.
%
%      CROP_HYPERCUBE('Property','Value',...) creates a new CROP_HYPERCUBE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before crop_hypercube_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to crop_hypercube_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help crop_hypercube

% Last Modified by GUIDE v2.5 29-Oct-2014 14:55:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @crop_hypercube_OpeningFcn, ...
                   'gui_OutputFcn',  @crop_hypercube_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before crop_hypercube is made visible.
function crop_hypercube_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to crop_hypercube (see VARARGIN)

% Choose default command line output for crop_hypercube
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes crop_hypercube wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = crop_hypercube_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnbrowse.
function btnbrowse_Callback(hObject, eventdata, handles)
% hObject    handle to btnbrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

currentpath=cd();
[filename, pathname] = uigetfile({'*.hdr;*.dat;*.mat','Hyper Files (*.hdr,*.dat,*.mat)'},'Load Hyperspectral File');
if (filename==0) % cancel pressed
    return;
end
cd (pathname);
if strcmp(filename(end-3:end), '.mat')
    datacube=importdata(filename);
    if isstruct(datacube)
        datacube=datacube.ref;
        
        if size(datacube,3) == 31
            bandname = 420:10:720;
        end 
    else 
        switch size(datacube,3)
            case 31
                bandname = 410:10:710;
        %else size(datacube,3) == 56 need to be fixed, because I don't know
        %the first bandname
            case 33
                bandname = 400:10:720;
            case 41
                bandname = 600:10:1000;
            case 51
                bandname = 500:10:1000;
            case 61 
                bandname = 400:10:1000;
            case 65
                bandname = 450:10:1090;
            case 148
                bandname = linspace(415,950,148);
            otherwise
                bandname = 1:1:size(datacube,3);
        end
    end

%     if max(datacube(:)) ~= 1 && size(datacube,3) ~= 255
%         %datacube = normalise(datacube,'percent', 0.999);
%     else
%         %datacube = normalise(datacube,'percent', 1);
%     end
%     description = 'online database';
else
    [datacube, bandname, description] = Load_Spec(filename);
%      darkFrame = importdata('darkFrame.mat');
%      slice = mean(darkFrame, 3);
%      for mm = 1:size(darkFrame,3);
%          darkFrame(:,:,mm) = slice;
%      end
%      datacube = datacube - darkFrame;
%    %when the images become clear, let's have a try without no resize.
%     datacube = normalise(datacube,'percent', 1);
    
    %if handles.version == 2
     %   datacube = datacube(:,:,end-40:end);
     %   bandname = bandname(end-40:end);
    %end
  %  handles.datacube = d;
end

cd (currentpath);
handles.datacube = datacube;
handles.bandname = bandname;
numofBand = length(bandname);
midBand = round(numofBand/2);

handles.filepath=filename;
handles.currentindex=midBand;

interval = bandname(2) - bandname(1);
slidermin = bandname(1);
slidermax = bandname(end);
sliderstep = [interval interval] / (slidermax - slidermin);
%set (handles.TextInfo, 'String', [filename ' ' description]);
set (handles.slider1,'Min',slidermin);
set (handles.slider1,'Max',slidermax);
set (handles.slider1,'SliderStep',sliderstep);
set (handles.slider1,'Value',bandname(midBand));
set (handles.txtbnum, 'String', bandname(midBand));

slice = squeeze(datacube(:,:,midBand));

axes(handles.axes1); cla; imshow(slice);

guidata(hObject, handles);

% --- Executes on button press in btncrop.
function btncrop_Callback(hObject, eventdata, handles)
% hObject    handle to btncrop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

h = imrect;
position = wait(h);

X1 = round(position(1));
Y1 = round(position(2));
X2 = round(X1 + position(3));
Y2 = round(Y1 + position(4));

datacube=handles.datacube;
index=handles.currentindex;

sz=size(datacube);

for i=1:sz(3)
 
    img=datacube(:,:,index);
    
    
    crimg=img(Y1:Y2,X1:X2);%crop(img,position);
    
    %figure,imshow(crimg);
    
    datacubecr(:,:,i)=crimg;
    
end

handles.datacube=datacubecr;

axes(handles.axes1); cla; imshow(datacubecr(:,:,index));

guidata(hObject, handles);

save('crop.mat','datacubecr');
% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
band = get(hObject, 'Value');
set(handles.txtbnum, 'String', num2str(band));
step = handles.bandname(2) - handles.bandname(1);
index=floor((band-handles.bandname(1))/step+1);
handles.currentindex=index;

slice = squeeze(handles.datacube(:,:,index));

axes(handles.axes1); cla; imshow(slice);


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
