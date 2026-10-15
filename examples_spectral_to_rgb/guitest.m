function varargout = guitest(varargin)
% GUITEST MATLAB code for guitest.fig
%      GUITEST, by itself, creates a new GUITEST or raises the existing
%      singleton*.
%
%      H = GUITEST returns the handle to a new GUITEST or the handle to
%      the existing singleton*.
%
%      GUITEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUITEST.M with the given input arguments.
%
%      GUITEST('Property','Value',...) creates a new GUITEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guitest_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guitest_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guitest

% Last Modified by GUIDE v2.5 26-Sep-2013 13:19:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guitest_OpeningFcn, ...
                   'gui_OutputFcn',  @guitest_OutputFcn, ...
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


% --- Executes just before guitest is made visible.
function guitest_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guitest (see VARARGIN)


%my data

%set(handles.axes1, 'Visible', 'off');
%set(handles.axes2, 'Visible', 'off');

%test
% fh = figure('Position',[250 250 350 350],...
%             'MenuBar','none','NumberTitle','off',...
%             'Name','Sharing Data with UserData');
% sh = uicontrol(fh,'Style','slider',...
%                'Max',100,'Min',0,'Value',25,...
%                'SliderStep',[0.05 0.2],...
%                'Position',[300 25 20 300],...
%                'Callback',@slider_callback);
% eth = uicontrol(fh,'Style','edit',...
%                'String',num2str(get(sh,'Value')),...
%                'Position',[30 175 240 20],...
%                'Callback',@edittext_callback);
% sth = uicontrol(fh,'Style','text','String',...
%                'Enter a value or click the slider.',...
%                'Position',[30 215 240 20]);
%end test
%nextval.i=1;
%handles.nextval=1;
%hObject.nextval=1;
%set(hObject,'UserData',nextval);
global nextval;
nextval=1;

img=imread('testrgbimg.jpg');

reflectances= getappdata(0,'reflectances');
%size(reflectances)


%guidata(nv,nextval);

rf= reflectances(:,:,nextval);

%rf=rf.^0.4;%intensity increase

axes(handles.axes1);
imshow(rf);

%axes(handles.axes2);
%imshow(img);


sal=Saliency(rf);
axes(handles.axes2);
imshow(sal);


%slider
sliderMin = 1;
sliderMax = 33; % this is variable
sliderStep = [1, 1]/ (sliderMax - sliderMin); % major and minor steps of 1

set(handles.slider1, 'Min', sliderMin);
set(handles.slider1, 'Max', sliderMax);
set(handles.slider1, 'SliderStep', sliderStep);
set(handles.slider1, 'Value', sliderMin);
%image(img);

% Choose default command line output for guitest
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guitest wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guitest_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global nextval;

%preval=nextval;
%nextval

nextval=get(hObject,'Value');
%if()
%nextval=nextval+1;
reflectances= getappdata(0,'reflectances');
rf= reflectances(:,:,nextval);

%rf=rf.^0.4; %intensity increase

axes(handles.axes1);
imshow(rf);

%Saliency
sal=Saliency(rf);
axes(handles.axes2);
imshow(sal);
%nextval=get(hObject,'nextval');
%obj=get(hObject,'UserData');
%obj.nextval.i=obj.nextval.i+1;
%obj.nextval
%size(reflectances)


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
