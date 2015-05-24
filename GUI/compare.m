function varargout = compare(varargin)
% COMAPRE MATLAB code for comapre.fig
%      COMAPRE, by itself, creates a new COMAPRE or raises the existing
%      singleton*.
%
%      H = COMAPRE returns the handle to a new COMAPRE or the handle to
%      the existing singleton*.
%
%      COMAPRE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COMAPRE.M with the given input arguments.
%
%      COMAPRE('Property','Value',...) creates a new COMAPRE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before comapre_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to comapre_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help comapre

% Last Modified by GUIDE v2.5 20-May-2015 21:22:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @comapre_OpeningFcn, ...
                   'gui_OutputFcn',  @comapre_OutputFcn, ...
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


% --- Executes just before comapre is made visible.
function comapre_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to comapre (see VARARGIN)

% Choose default command line output for comapre
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
global inpainting original wholeMask;
axes(handles.axes1)
imshow(original);
axes(handles.axes2)
imshow(inpainting);
axes(handles.axes3)
imshow(wholeMask);
% UIWAIT makes comapre wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = comapre_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
