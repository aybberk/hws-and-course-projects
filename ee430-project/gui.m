
function varargout = gui(varargin)

% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 25-Jan-2016 15:38:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

global gain1;
global gain2;
global gain3;
global gain4;
global gain5;
global gain6;
global gain7;
global gain8;
global gain9;
global gain10;
gain1=0;
gain2=0;
gain3=0;
gain4=0;
gain5=0;
gain6=0;
gain7=0;
gain8=0;
gain9=0;
gain10=0;
% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in gopushbutton.
function gopushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to gopushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ses;
global snyibol;
global L_window;
global Fs;
global filenameformat;
global factor;
global overlap;
global windoww;
set(handles.babalog,'String','PROCESSING..');
drawnow;
m=numel(ses) %y2 nin eleman sayisi%
sure=m/Fs;  %süre%
L_window = 2*round(((Fs*2/snyibol)*(factor))/2); %window uzunlugu (Fs*2/snyibolden fazla olamaz)
%%bi de ikiye bölüp ikiyle çapt?k ki altta ikiye bölünce de tam say? %%olsun%%


for n=1/snyibol  :  1/snyibol  :  sure-1/snyibol;
    
    a(round(snyibol*n),:)=ses((round(Fs*n)-L_window/2+1):round(Fs*n)+L_window/2);
    %a nin k. rowu k/snyibol_1. msdeki ses%   
end
%b'nin k. columnu k*Fs/windowlength%
% %ilk column Fs/windowlength
% ortadaki column Fs/2,
% son columnu Fs frekansina esit Hz cinsinden
%Fs/2 yani 22kHz den sonrasi çöp çünkü nyquist dayi öyle diyor%

switch windoww
    case {1}    
        wind=hamming(numel(a(1,:)))';
        windowww='Hamming';
    case {2}     
        wind=blackman(numel(a(1,:)))';
        windowww='Blackman';
    case {3}     
        wind=gausswin(numel(a(1,:)))';
        windowww='Gaussian';
    case {4}     
        wind=chebwin(numel(a(1,:)))';
        windowww='Chebyshev';
    case {5}     
        wind=kaiser(numel(a(1,:)))';
        windowww='Kaiser';
    case {6}     
        wind=bohmanwin(numel(a(1,:)))';
        windowww='Bohman';
    case {7}     
        wind=ones(1,numel(a(1,:)));
        windowww='Rectangular';
    case {8}     
        wind=triang(numel(a(1,:)))';
        windowww='Triangular';
        
     
end

for n=1:(numel(a(:,1)))
    wind(n,:)=wind(1,:);
end

a=a.*wind;
for n=1/snyibol  :  1/snyibol  :  sure-1/snyibol;
    b(round(snyibol*n),:)=abs(fft(a(round(snyibol*n),:))); 
%b nin k. rowu k/snyibol_1. msdeki sesin fourier transformu% 
end

freqs=linspace(Fs/L_window,Fs/2,floor((L_window/2)));
c=b(:,1:length(freqs)); %b nin son yarisi çöp o yüzden sildik ve c'yi elde ettik%
time=linspace(sure/snyibol,sure,numel(a(:,1)));
c=c/max(max(c));  %normalize
c=20*log10(c); %log
axes(handles.spectrogramplot)
imagesc(time,freqs,c')
colormap(jet)
set(gca,'YDir','normal')
xlabel('Time(s)');
ylabel('Frequency(Hz)');
ylabel(colorbar,'Power/frequency(dB/Hz)')


axes(handles.surfplot)
h=surf(time,freqs,c');
set(h,'LineStyle','none')
xlabel('Time(s)');
ylabel('Frequency(Hz)');
zlabel('Power/frequency(dB/rad/sample)')
view(-25,75);
set(handles.babalog,'String','');
drawnow;

% --- Executes on button press in recordpushbutton.
function recordpushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to recordpushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global recordduration;      
global Fs_rec;
global ses
global Fs
global time

            recObj = audiorecorder(Fs_rec,8,1);
      
            set(handles.babalog,'String','RECORDING..');
            drawnow;
            recordblocking(recObj, recordduration);
            set(handles.babalog,'String','RECORD FINISHED');
            drawnow;
            
            y = getaudiodata(recObj);
            ses=y(:,1)';
            ses=[ses zeros(1,200)]; %sesin sonuna nolur nolmaz diye 200 tane 0 ekledik çünkü for loopta son eleman bos kalir falan
            Fs=Fs_rec;
            m=numel(ses);          
            time=linspace(1/Fs,recordduration,m);
            set(handles.babalog,'String','RECORD FINISHED');
            drawnow;
         
% --- Executes on button press in readpushbutton.
function readpushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to readpushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global filename
global fileformat
global filenameformat
filenameformat=[filename,fileformat]
global ses
global Fs
    [y,Fs]=audioread(filenameformat); 
    
    ses=y(:,1)';
    set(handles.babalog,'String','AUDIO IMPORTED');
    drawnow;
  
    
           
function recorddurationedit_Callback(hObject, eventdata, handles)
% hObject    handle to recorddurationedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global recordduration;
recordduration=str2double(get(hObject,'String'))

% Hints: get(hObject,'String') returns contents of recorddurationedit as text
%        str2double(get(hObject,'String')) returns contents of recorddurationedit as a double



% --- Executes during object creation, after setting all properties.
function recorddurationedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to recorddurationedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global recordduration;
recordduration=str2double(get(hObject,'String'))
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function filenameedit_Callback(hObject, eventdata, handles)
% hObject    handle to filenameedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filename
filename=get(hObject,'String')
% Hints: get(hObject,'String') returns contents of filenameedit as text
%        str2double(get(hObject,'String')) returns contents of filenameedit as a double


% --- Executes during object creation, after setting all properties.
function filenameedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filenameedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global filename
filename='pw';
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in windowtypepopupmenu.
function windowtypepopupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to windowtypepopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns windowtypepopupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from windowtypepopupmenu
global windoww
windoww=get(hObject,'Value')

% --- Executes during object creation, after setting all properties.
function windowtypepopupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to windowtypepopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global windoww
windoww=1;
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function precisionslider_Callback(hObject, eventdata, handles)
% hObject    handle to precisionslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global snyibol
snyibol = get(hObject,'Value')
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function precisionslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to precisionslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global snyibol
snyibol = 20;
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function overlapslider_Callback(hObject, eventdata, handles)
% hObject    handle to overlapslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global overlap
global factor
overlap=get(hObject,'Value')
factor=(2*overlap+100)/200;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function overlapslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to overlapslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global overlap
global factor
overlap=0.00
factor=(2*overlap+100)/200
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end




% --- Executes on button press in playsoundpushbutton.
function playsoundpushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to playsoundpushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ses
global Fs 
global playbackspeed
clear sound;
global reverbyesno;
global stereoyesno;
filteredses=ses;
stereoses=ses;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%REVERB%%%%%%%%%%%%%%%%


if reverbyesno==1
    
set(handles.babalog,'String','PROCESSING');
drawnow;   
%%%%%%%%
%%%AP%%%
%%%%%%%%
N=347;
g=0.3;
polecoeff=[1 zeros(1,N-1) -g];
zerocoeff=[-g zeros(1,N-1) 1];
filteredses=filter(zerocoeff,polecoeff,filteredses);

%%%%%
N=113;
g=0.5;
polecoeff=[1 zeros(1,N-1) -g];
zerocoeff=[-g zeros(1,N-1) 1];
filteredses=filter(zerocoeff,polecoeff,filteredses);

%%%%
N=37;
g=0.7;
polecoeff=[1 zeros(1,N-1) -g];
zerocoeff=[-g zeros(1,N-1) 1];
filteredses=filter(zerocoeff,polecoeff,filteredses);

%%%%%%%%%
%%FBCB%%%
%%%%%%%%%

N=1687;
g=0.773;

polecoeff=[1 zeros(1,N-1) -g];
zerocoeff=1;
filteredses1=filter(zerocoeff,polecoeff,filteredses);

%%%%

N=1601;
g=0.802;

polecoeff=[1 zeros(1,N-1) -g];
zerocoeff=1;
filteredses2=filter(zerocoeff,polecoeff,filteredses);

%%%%

N=2053;
g=0.753;

polecoeff=[1 zeros(1,N-1) -g];
zerocoeff=1;
filteredses3=filter(zerocoeff,polecoeff,filteredses);
%%%%

N=2251;
g=0.733;

polecoeff=[1 zeros(1,N-1) -g];
zerocoeff=1;
filteredses4=filter(zerocoeff,polecoeff,filteredses);
filteredses=[filteredses1+filteredses3;filteredses2+filteredses4];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%STEREO%%%%%%%%%%%%%%%%%%%%
if stereoyesno==1
set(handles.babalog,'String','PROCESSING');
drawnow; 
delayms=40;
delaysample=round(delayms*Fs/1000);
hstereo1=[1 zeros(1,delaysample)];
hstereo2=[zeros(1,delaysample) 1];
ses1=conv(hstereo1,stereoses);
ses2=conv(hstereo2,stereoses);
stereoses=[ses1;ses2];
end

sound(stereoses,playbackspeed*Fs)
set(handles.babalog,'String','');
drawnow;
% --- Executes during object creation, after setting all properties.






% --- Executes during object creation, after setting all properties.
function playbackspeedpopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to playbackspeedpopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global n
n=1
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function playbackspeedslider_Callback(hObject, eventdata, handles)
% hObject    handle to playbackspeedslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global playbackspeed;
playbackspeed=get(hObject,'Value')

% --- Executes during object creation, after setting all properties.
function playbackspeedslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to playbackspeedslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global playbackspeed
playbackspeed=1
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to playbackspeedslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
get(hObject,'Value')
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to playbackspeedslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function uibuttongroup1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uibuttongroup1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global fileformat
fileformat='.mp3'


% --- Executes on button press in mp3radiobutton.
function mp3radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to mp3radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hint: get(hObject,'Value') returns toggle state of mp3radiobutton
global fileformat
fileformat='.mp3'




% --- Executes on button press in wavradiobutton.
function wavradiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to wavradiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of wavradiobutton
global fileformat
fileformat='.wav'


% --- Executes on button press in stoppushbutton.
function stoppushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to stoppushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear sound
set(handles.babalog,'String','STOPPED');
drawnow;
pause(0.6);
set(handles.babalog,'String','');
drawnow;


% --- Executes on slider movement.
function slider26_Callback(hObject, eventdata, handles)
% hObject    handle to slider26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gain7;
gain7=get(hObject,'Value');
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider27_Callback(hObject, eventdata, handles)
% hObject    handle to slider27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider27_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider28_Callback(hObject, eventdata, handles)
% hObject    handle to slider28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider29_Callback(hObject, eventdata, handles)
% hObject    handle to slider29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider29_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider30_Callback(hObject, eventdata, handles)
% hObject    handle to slider30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider30_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider31_Callback(hObject, eventdata, handles)
% hObject    handle to slider31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider32_Callback(hObject, eventdata, handles)
% hObject    handle to slider32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider33_Callback(hObject, eventdata, handles)
% hObject    handle to slider33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider34_Callback(hObject, eventdata, handles)
% hObject    handle to slider34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider34_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider41_Callback(hObject, eventdata, handles)
% hObject    handle to slider41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider41_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global devam;
global windowwrt;
global dftsize;
global framesize;
    devam=1;
    global Fsrtrec;
    recObj = audiorecorder(Fsrtrec,8,1);
  
    
 while devam==1
            
            recordblocking(recObj, (framesize+Fsrtrec/30)/Fsrtrec);
            y = getaudiodata(recObj);
            a=y(round(Fsrtrec/30):numel(y))';
            

switch windowwrt
    case {1}    
        wind=hamming(numel(a(1,:)))';
        windowww='Hamming';
    case {2}     
        wind=blackman(numel(a(1,:)))';
        windowww='Blackman';
    case {3}     
        wind=gausswin(numel(a(1,:)))';
        windowww='Gaussian';
    case {4}     
        wind=chebwin(numel(a(1,:)))';
        windowww='Chebyshev';
    case {5}     
        wind=kaiser(numel(a(1,:)))';
        windowww='Kaiser';
    case {6}     
        wind=bohmanwin(numel(a(1,:)))';
        windowww='Bohman';
    case {7}     
        wind=ones(1,numel(a(1,:)));
        windowww='Rectangular';
    case {8}     
        wind=triang(numel(a(1,:)))';
        windowww='Triangular';
          
end
axes(handles.surfplot)
windowlua=wind.*a;
plot(windowlua);
drawnow;


axes(handles.spectrogramplot)
            sure=numel(a)/Fsrtrec;
            aa=fft(a,dftsize);
            aa=(aa(1:round(numel(aa)/2)));
            aa=(abs(aa));
     
            freqs=linspace(0,Fsrtrec/2,numel(aa));
            plot(freqs,aa);
            ylim([0 10]); 
            xlim([0 Fsrtrec/2]);
           
 end



% --- Executes during object creation, after setting all properties.
function pushbutton7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global devam
devam=0;


% --- Executes on slider movement.
function slider47_Callback(hObject, eventdata, handles)
% hObject    handle to slider47 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gain6;
gain6=get(hObject,'Value');
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider47_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider47 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider48_Callback(hObject, eventdata, handles)
% hObject    handle to slider48 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gain8;
gain8=get(hObject,'Value');
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider48_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider48 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider49_Callback(hObject, eventdata, handles)
% hObject    handle to slider49 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gain10;
gain10=get(hObject,'Value');
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider49_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider49 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider50_Callback(hObject, eventdata, handles)
% hObject    handle to slider50 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gain9;
gain9=get(hObject,'Value')
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider50_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider50 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider51_Callback(hObject, eventdata, handles)
% hObject    handle to slider51 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gain2;
gain2=get(hObject,'Value')
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider51_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider51 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider52_Callback(hObject, eventdata, handles)
% hObject    handle to slider52 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gain1;
gain1=get(hObject,'Value')
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider52_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider52 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider53_Callback(hObject, eventdata, handles)
% hObject    handle to slider53 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gain3;
gain3=get(hObject,'Value')
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider53_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider53 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider54_Callback(hObject, eventdata, handles)
% hObject    handle to slider54 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gain5;
gain5=get(hObject,'Value')
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider54_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider54 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider55_Callback(hObject, eventdata, handles)
% hObject    handle to slider55 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gain4;
gain4=get(hObject,'Value')
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider55_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider55 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global ses;
filtses=ses;
global Fs
global gain1;
global gain2;
global gain3;
global gain4;
global gain5;
global gain6;
global gain7;
global gain8;
global gain9;
global gain10;
global lineermi;
global ses2;
set(handles.babalog,'String','PROCESSING..');
drawnow;
filterorder=250;
filt1 = fir1(filterorder,0.00114*(44100/Fs),'low');
yfilt1=conv(filt1,filtses);
yfilt1=yfilt1*10^(gain1/20);
filt2 = fir1(filterorder,[0.00114*(44100/Fs) 0.0023*(44100/Fs)]);
yfilt2=conv(filt2,filtses);
yfilt2=yfilt2*10^(gain2/20);
filt3 = fir1(filterorder,[0.0023*(44100/Fs) 0.0045*(44100/Fs)]);
yfilt3=conv(filt3,filtses);
yfilt3=yfilt3*10^(gain3/20);
filt4 = fir1(filterorder,[0.0045*(44100/Fs) 0.009*(44100/Fs)]);
yfilt4=conv(filt4,filtses);
yfilt4=yfilt4*10^(gain4/20);
if lineermi==1
filt5 = fir1(filterorder,[0.009*(44100/Fs) 0.0178*(44100/Fs)]);
yfilt5=conv(filt5,filtses);
yfilt5=yfilt5*10^(gain5/20);
end
if lineermi==0
filt5 = butter(filterorder,[0.009*(44100/Fs) 0.0178*(44100/Fs)]);
yfilt5=conv(filt5,filtses);
yfilt5=yfilt5*10^(gain5/20);
yfilt5=yfilt5(1,1:numel(yfilt4));
end
filt6 = fir1(filterorder,[0.0178*(44100/Fs) 0.035*(44100/Fs)]);
yfilt6=conv(filt6,filtses);
yfilt6=yfilt6*10^(gain6/20);
filt7 = fir1(filterorder,[0.035*(44100/Fs) 0.07*(44100/Fs)]);
yfilt7=conv(filt7,filtses);
yfilt7=yfilt7*10^(gain7/20);
filt8 = fir1(filterorder,[0.07*(44100/Fs) 0.14*(44100/Fs)]);
yfilt8=conv(filt8,filtses);
yfilt8=yfilt8*10^(gain8/20);
filt9 = fir1(filterorder,[0.14*(44100/Fs) 0.285*(44100/Fs)]);
yfilt9=conv(filt9,filtses);
yfilt9=yfilt9*10^(gain9/20);
filt10 = fir1(filterorder,[0.285*(44100/Fs) 0.57*(44100/Fs)]);
yfilt10=conv(filt10,filtses);
yfilt10=yfilt10*10^(gain10/20);

ses2=(yfilt1+yfilt2+yfilt3+yfilt4+yfilt5+yfilt6+yfilt7+yfilt8+yfilt9+yfilt10)/4;
clear sound;
sound(ses2,Fs)

set(handles.babalog,'String','');
drawnow;


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global devam;
devam=0;

% --- Executes on button press in readpushbutton.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to readpushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to filenameedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filenameedit as text
%        str2double(get(hObject,'String')) returns contents of filenameedit as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filenameedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in recordpushbutton.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to recordpushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to recorddurationedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of recorddurationedit as text
%        str2double(get(hObject,'String')) returns contents of recorddurationedit as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to recorddurationedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs_rec;
Fs_rec=str2double(get(hObject,'String'));
% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global Fs_rec;
Fs_rec=44100;
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton11.
function radiobutton11_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton11
global reverbyesno;
global stereoyesno;

stereoyesno=0;
reverbyesno=1;


% --- Executes on button press in radiobutton12.
function radiobutton12_Callback(hObject, eventdata, handles)
global stereoyesno;
global reverbyesno;
stereoyesno=1;
reverbyesno=0;
% hObject    handle to radiobutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton12


% --- Executes on button press in radiobutton16.
function radiobutton16_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global reverbyesno;
global stereoyesno;
reverbyesno=0;
stereoyesno=0;
% Hint: get(hObject,'Value') returns toggle state of radiobutton16


% --- Executes during object creation, after setting all properties.
function radiobutton16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radiobutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global reverbyesno;
global stereoyesno;
reverbyesno=0;
stereoyesno=0;


% --- Executes during object creation, after setting all properties.
function mp3radiobutton_CreateFcn(hObject, eventdata, handles)
global fileformat
fileformat='.mp3';
% hObject    handle to mp3radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function recordpushbutton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to recordpushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edittext_Callback(hObject, eventdata, handles)
% hObject    handle to edittext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edittext as text
%        str2double(get(hObject,'String')) returns contents of edittext as a double


% --- Executes during object creation, after setting all properties.
function edittext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edittext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global frekans;
frekans=str2double(get(hObject,'String'));

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ses;
global noiseses;
global frekans;
global Fs;
t=1/Fs:1/Fs:numel(ses)/Fs;
noiseses=ses+0.2.*cos(2*pi*frekans.*t);

set(handles.babalog,'String','Added');
drawnow;


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs;
global noiseses;
clear sound;
sound(noiseses,Fs);

% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs;
global frekans;
global noiseses;
set(handles.babalog,'String','Filtering');
drawnow;
if frekans<500
    order=6000;
else
    if frekans<2000
    order=2000;
    else
        order=1000;
    end
end

filt = fir1(order,[2*(frekans*0.9)/Fs 2*(frekans*1.1)/Fs],'stop');
filtses=conv(filt,noiseses);
set(handles.babalog,'String','');
clear sound;
sound(filtses,Fs);


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global lineermi;
lineermi=get(hObject,'Value');
% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes during object creation, after setting all properties.
function uipanel1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function checkbox2_CreateFcn(hObject, eventdata, handles)
global lineermi;
lineermi=1;
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global windowwrt
windowwrt=get(hObject,'Value');
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global windowwrt
windowwrt=1;
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dftsize;
dftsize=str2double(get(hObject,'String'));
% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
global dftsize;
dftsize=2048;
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global framesize;
framesize=str2double(get(hObject,'String'));
% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
global framesize;
framesize=1000;
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fsrtrec;
    Fsrtrec=str2double(get(hObject,'String'));
% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global Fsrtrec;
    Fsrtrec=44100;
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ses2;
global snyibol;
global L_window;
global Fs;
global filenameformat;
global factor;
global overlap;
global windoww;
set(handles.babalog,'String','PROCESSING..');
drawnow;
m=numel(ses2) %y2 nin eleman sayisi%
sure=m/Fs;  %süre%
L_window = 2*round(((Fs*2/snyibol)*(factor))/2); %window uzunlugu (Fs*2/snyibolden fazla olamaz)
%%bi de ikiye bölüp ikiyle çapt?k ki altta ikiye bölünce de tam say? %%olsun%%


for n=1/snyibol  :  1/snyibol  :  sure-1/snyibol;
    
    a(round(snyibol*n),:)=ses2((round(Fs*n)-L_window/2+1):round(Fs*n)+L_window/2);
    %a nin k. rowu k/snyibol_1. msdeki ses%   
end
%b'nin k. columnu k*Fs/windowlength%
% %ilk column Fs/windowlength
% ortadaki column Fs/2,
% son columnu Fs frekansina esit Hz cinsinden
%Fs/2 yani 22kHz den sonrasi çöp çünkü nyquist dayi öyle diyor%

switch windoww
    case {1}    
        wind=hamming(numel(a(1,:)))';
        windowww='Hamming';
    case {2}     
        wind=blackman(numel(a(1,:)))';
        windowww='Blackman';
    case {3}     
        wind=gausswin(numel(a(1,:)))';
        windowww='Gaussian';
    case {4}     
        wind=chebwin(1,numel(a(1,:)));
        windowww='Chebyshev';
    case {5}     
        wind=kaiser(1,numel(a(1,:)));
        windowww='Kaiser';
    case {6}     
        wind=bohmanwin(1,numel(a(1,:)));
        windowww='Bohman';
    case {7}     
        wind=ones(1,numel(a(1,:)));
        windowww='Rectangular';
    case {8}     
        wind=triang(1,numel(a(1,:)));
        windowww='Triangular';
        
     
end

for n=1:(numel(a(:,1)))
    wind(n,:)=wind(1,:);
end

a=a.*wind;
for n=1/snyibol  :  1/snyibol  :  sure-1/snyibol;
    b(round(snyibol*n),:)=abs(fft(a(round(snyibol*n),:))); 
%b nin k. rowu k/snyibol_1. msdeki sesin fourier transformu% 
end

freqs=linspace(Fs/L_window,Fs/2,floor((L_window/2)));
c=b(:,1:length(freqs)); %b nin son yarisi çöp o yüzden sildik ve c'yi elde ettik%
time=linspace(sure/snyibol,sure,numel(a(:,1)));
c=c/max(max(c));  %normalize
c=20*log10(c); %log
axes(handles.spectrogramplot)
imagesc(time,freqs,c')
set(gca,'YDir','normal')
xlabel('Time(s)');
ylabel('Frequency(Hz)');
ylabel(colorbar,'Power/frequency(dB/Hz)')


axes(handles.surfplot)
h=surf(time,freqs,c');
set(h,'LineStyle','none')
xlabel('Time(s)');
ylabel('Frequency(Hz)');
zlabel('Power/frequency(dB/rad/sample)')
view(-25,75);
set(handles.babalog,'String','');
drawnow;


% --- Executes during object creation, after setting all properties.
function readpushbutton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to readpushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global y;
global Fs;
global ses;

[y,Fs]=audioread('pw.mp3'); 
    
    ses=y(:,1)';


% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

