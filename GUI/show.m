function varargout = show(varargin)
% SHOW MATLAB code for show.fig
%      SHOW, by itself, creates a new SHOW or raises the existing
%      singleton*.
%
%      H = SHOW returns the handle to a new SHOW or the handle to
%      the existing singleton*.
%
%      SHOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHOW.M with the given input arguments.
%
%      SHOW('Property','Value',...) creates a new SHOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before show_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to show_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help show

% Last Modified by GUIDE v2.5 20-May-2015 21:30:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @show_OpeningFcn, ...
                   'gui_OutputFcn',  @show_OutputFcn, ...
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


% --- Executes just before show is made visible.
function show_OpeningFcn(hObject, eventdata, handles, varargin)
global inpainting;
global original;
imshow(inpainting);
global R;
R=6;
global iter;
iter=1000;
set(handles.text3,'String',R);
global wholeMask;
[height width ~]=size(inpainting);
wholeMask=zeros(height,width);
original = inpainting;
%         I_mask(round(ai*(xi(j)+i)+bi),xi(j)+i)=1;
    
   



% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to show (see VARARGIN)

% Choose default command line output for show
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes show wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = show_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
function WindowButtonMotionFcn()
figure


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global marks;
global inpainting;
global wholeMask;
global inpainting;
inpainting=im2double(inpainting);
marks=1;

while(marks)

[x y]=ginput(2);
if(numel(x)==0)
    marks=0;
else
x=round(x);
y=round(y);
a=(y(2)-y(1))/(x(2)-x(1));
b=(y(1)*x(2)-y(2)*x(1))/(x(2)-x(1));
xi=[min(x):max(x)];
yi=round(a*xi+b);
[height width ~]=size(inpainting)
% I_mask=zeros(height, width);
mask=ones(height,width);
ai=-1/a;
bi=yi-xi*ai;
index=1;
global R;
    for i=1:length(yi)
        for m=xi(i)-R:xi(i)+R
            for n=yi(i)-R:yi(i)+R
                if(m<1) m=1; end
                if(n<1) n=1; end
                if(m>width) m=width; end
                if(n>height) n=height; end
                if((m-xi(i))^2+(n-yi(i))^2<R^2) 
%                     inpainting(n,m,:)=NaN;
                    mask(n,m)=0;
                    sets(index,1)=n;sets(index,2)=m;
                    index=index+1; 
                end 
            end
        end
    end
    nmin=min(sets(:,1));
    nmax=max(sets(:,1));
    mmin=min(sets(:,2));
    mmax=max(sets(:,2));
    points=[nmin,nmax;mmin,mmax];
    wholeMask(mask==0)=1;
    global iter;
    inpainting=heat_equation(mask,points,inpainting,iter);
%     axes(axes1);
    imshow(inpainting);
    clear x y mask points mmax mmin nmin nmax;
%     Ik=inpainting(nmin:nmax,mmin:mmax,:);
%     a = 0.073235;
%     b = 0.176765;
%     c = 0.125;
%     for i=1:20
%         inpainting(sets(:,1),sets(:,2),:)=inpainting(sets(:,1)-1,sets(:,2),:)*b+inpainting(sets(:,1)+1,sets(:,2),:)*b+...
%             inpainting(sets(:,1)-1,sets(:,2)-1,:)*a+inpainting(sets(:,1)-1,sets(:,2)+1,:)*a+...
%             inpainting(sets(:,1)+1,sets(:,2)-1,:)*a+inpainting(sets(:,1)+1,sets(:,2)+1,:)*a+...
%             inpainting(sets(:,1),sets(:,2)-1,:)*b+inpainting(sets(:,1),sets(:,2)+1,:)*b;
%     end
%     B_a=[a b a;b 0 b;a b a];
%     B_b=c*ones(3,3);
%     B_b(2,2)=0;
%     B2=Ik;
%     figure
%     imshow(B2);
    % B2=I(160:290,160:370);
    % B2=1-B2;
%     imshow(B2)
    % B2(300:end,400:end)=NaN;
    
%     for i=1:100
%     B2(:,:,1)=filter2(B_a,B2(:,:,1),'same');
% %     B2(:,:,1)=filter2(B_b,B2(:,:,1),'same');
%     
%     B2(:,:,2)=filter2(B_a,B2(:,:,2),'same');
% %     B2(:,:,2)=filter2(B_b,B2(:,:,2),'same');
%     
%     B2(:,:,3)=filter2(B_a,B2(:,:,3),'same');
% %     B2(:,:,3)=filter2(B_b,B2(:,:,3),'same');
%     end
%     figure
%     imshow(B2)
%    inpainting(nmin:nmax,mmin:mmax,:)=B2;
%    figure
%         imshow(inpainting);
        end
    end
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
run('compare');





% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
global R;
R=R-1;
set(handles.text3,'String',R);
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
global R;
R=R+1;
set(handles.text3,'String',R);
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global iter;
num=get(handles.editIter,'string');
iter=str2num(num);
% set(handles.editIter,'string',iter);

% --- Executes on key press with focus on edit2 and none of its controls.






% --- Executes during object creation, after setting all properties.
function editIter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editIter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String','1000');



function editIter_Callback(hObject, eventdata, handles)
% hObject    handle to editIter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editIter as text
%        str2double(get(hObject,'String')) returns contents of editIter as a double


% --- Executes on key press with focus on pushbutton1 and none of its controls.


% --- Executes on key press with focus on pushbutton3 and none of its controls.
function pushbutton3_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
