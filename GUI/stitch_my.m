function varargout = stitch_my(varargin)
% STITCH_MY MATLAB code for stitch_my.fig
%      STITCH_MY, by itself, creates a new STITCH_MY or raises the existing
%      singleton*.
%
%      H = STITCH_MY returns the handle to a new STITCH_MY or the handle to
%      the existing singleton*.
%
%      STITCH_MY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STITCH_MY.M with the given input arguments.
%
%      STITCH_MY('Property','Value',...) creates a new STITCH_MY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before stitch_my_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to stitch_my_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help stitch_my

% Last Modified by GUIDE v2.5 21-May-2015 14:14:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @stitch_my_OpeningFcn, ...
                   'gui_OutputFcn',  @stitch_my_OutputFcn, ...
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


% --- Executes just before stitch_my is made visible.
function stitch_my_OpeningFcn(hObject, eventdata, handles, varargin)
global I;
chang=length(I);
if(chang>=5)
figure
for i=1:chang
    subplot(1,chang,i)
    imshow(imread(I{i}));
end
else
axes(handles.axes1)
imshow(imread(I{1}));
axes(handles.axes2);
imshow(imread(I{2}));
if(chang>=3)
    axes(handles.axes3);
    imshow(imread(I{3}));
end
if(chang==4)
    axes(handles.axes4);
    imshow(imread(I{4}));
end
addpath('../imageStitch');
run('../vlfeat-0.9.20/toolbox/vl_setup');
end
    
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to stitch_my (see VARARGIN)

% Choose default command line output for stitch_my
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes stitch_my wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = stitch_my_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)


global I;
% stitch(I);
imgFiles=I;
  images = cell(length(imgFiles), 1);    

  maxDim = 800;
    
    for i=1:length(imgFiles)
         imgFile=imgFiles{i};
        img = imread(imgFile);
        val = max(size(img));
        if maxDim > 0 && val > maxDim
            img = imresize(img, maxDim / val);
        end
        images{i} = img;
    end

    [sifts, siftLocations] = getSift(images);
    
    [H, imagePairs, matchPairs, InlierPairs ]= getH(sifts, siftLocations, images);
    global imageP matchP InlierP;
    imageP=imagePairs;
    matchP=matchPairs;
    InlierP=InlierPairs;
    Imws=warp(H, images);
    putTogether(Imws);
    set(handles.pushbutton4,'Visible','on');
    set(handles.pushbutton5,'Visible','on');
    

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global yejiao model;
yejiao=1;
model=1;
printMatch(handles);



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1
function printMatch(handles)
global yejiao imageP matchP;
axes(handles.axes5)
imshow(imageP{yejiao});
hold on;
plot(matchP{yejiao}(:,1),matchP{yejiao}(:,2),'wo');
hold off;
axes(handles.axes6)
imshow(imageP{yejiao+1});
hold on;
plot(matchP{yejiao+1}(:,1),matchP{yejiao+1}(:,2),'wo');
hold off;

function printInliers(handles)
global yejiao imageP matchP InlierP;
axes(handles.axes5)
imshow(imageP{yejiao});
hold on;
plot(matchP{yejiao}(InlierP{yejiao},1),matchP{yejiao}(InlierP{yejiao},2),'go');
axes(handles.axes6)
imshow(imageP{yejiao+1});
hold on;
plot(matchP{yejiao+1}(InlierP{yejiao+1},1),matchP{yejiao+1}(InlierP{yejiao+1},2),'go');


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
global yejiao matchP model;
if(yejiao<length(matchP)-1)
    yejiao=yejiao+2;
    if(model==0)
        printInliers(handles);
    else
        printMatch(handles);
    end
end
    
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global yejiao matchP model;
if(yejiao>2)
    yejiao=yejiao-2;
    if(model==0)
        printInliers(handles);
    else
        printMatch(handles);
    end
end

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
global yejiao model;
yejiao=1;
model=0;
printInliers(handles);
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes3
