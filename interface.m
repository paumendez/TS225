@@ -0,0 +1,278 @@
function varargout = interface(varargin)
% INTERFACE MATLAB code for interface.fig
%      INTERFACE, by itself, creates a new INTERFACE or raises the existing
%      singleton*.
%
%      H = INTERFACE returns the handle to a new INTERFACE or the handle to
%      the existing singleton*.
%
%      INTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFACE.M with the given input arguments.
%
%      INTERFACE('Property','Value',...) creates a new INTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before interface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to interface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help interface

% Last Modified by GUIDE v2.5 23-Dec-2015 23:56:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @interface_OpeningFcn, ...
                   'gui_OutputFcn',  @interface_OutputFcn, ...
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


% --- Executes just before interface is made visible.
function interface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to interface (see VARARGIN)

% Choose default command line output for interface
handles.output = hObject;

handles.data.nbr=0;
handles.data.lnom={}; 
handles.data.lim={};
handles.data.selec=0;
handles.data.hauteur=0;
handles.data.longeur=0;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes interface wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = interface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(handles.listbox1,'Value');
handles.data.selec=a;
guidata(hObject,handles);


% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    
end



% --- Executes on button press in creer.
function creer_Callback(hObject, eventdata, handles)
% hObject    handle to creer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.data.nbr<2
    warndlg('Veuillez selectionner au minimum deux images','!! Warning !!');
else
N=handles.data.nbr;
Liste_im=handles.data.lim;
h=length(Liste_im{1}(:,1));
l=length(Liste_im{1}(1,:));
[ Im_out ] = mosaique3( Liste_im,h,l,N );
figure(1)
imshow(uint8(Im_out));
end



% --- Executes on button press in choisir.
function choisir_Callback(hObject, eventdata, handles)
% hObject    handle to choisir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[NomFich,Chemin] = uigetfile({'*.bmp';'*.jpg';'*.png'},'Choisissez une image');
if isequal(NomFich,0) 
disp('Image non acquise') 
else
    Chemin_abs=[Chemin NomFich];
    im=double(imread(Chemin_abs));
    if (handles.data.nbr>=1)
        h=length(im(:,1));
        l=length(im(1,:));
        if(h~=handles.data.hauteur || l~=handles.data.longeur)
            warndlg('Pas la meme taille','!! Warning !!');
        else
            N=handles.data.nbr+1;
            Chemin_abs=[Chemin NomFich];
            im=double(imread(Chemin_abs));
            handles.data.lnom{N}=NomFich;
            set(handles.listbox1,'String',handles.data.lnom);
            handles.data.lim{N}=im;
            handles.data.nbr=N;
            guidata(hObject,handles);
        end
    else  
        N=handles.data.nbr+1;
        Chemin_abs=[Chemin NomFich];
        im=double(imread(Chemin_abs));
        handles.data.lnom{N}=NomFich;
        set(handles.listbox1,'String',handles.data.lnom);
        handles.data.lim{N}=im;
        handles.data.nbr=N;
        handles.data.hauteur=length(im(:,1));
        handles.data.longeur=length(im(1,:));
        guidata(hObject,handles);
    end
end


% --- Executes on button press in supprimer.
function supprimer_Callback(hObject, eventdata, handles)
% hObject    handle to supprimer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
N=handles.data.nbr;
a=handles.data.selec;
List_im=handles.data.lim;
List_nom=handles.listbox1.String;
if (N>2)
    if (a==0)
      warndlg('Selectionner une image','!! Warning !!');  
    elseif(a==1)
        Newlim={};
        Newlnom={};
        for i=2:N
            Newlim{i-1}=List_im{i};
            Newlnom{i-1}=List_nom{i};
        end
        handles.data.lim=Newlim;
        handles.data.lnom=Newlnom;
        
        handles.listbox1.Value=a;
        handles.listbox1.String=Newlnom;
       
        handles.data.nbr=N-1;
        handles.data.selec=0;
    else%fait
        Newlim={};
        Newlnom={};
        for i=1:a-1
            Newlim{i}=List_im{i};
            Newlnom{i}=List_nom{i};
        end
        for i=a+1:N
            Newlim{i-1}=List_im{i};
            Newlnom{i-1}=List_nom{i};
        end
        handles.data.lim=Newlim;
        
        handles.listbox1.Value=a-1;
        handles.listbox1.String=Newlnom;
        
        handles.data.lnom=Newlnom;
        handles.data.nbr=N-1;
        handles.data.selec=0;
    end
elseif(N==2)%fait
    if (a==0)
        warndlg('Selectionner une image','!! Warning !!');  
    elseif(a==1)
        
        handles.data.lim=List_im{2};
        handles.data.lnom=List_nom{2};
        
        handles.listbox1.Value=a;
        handles.listbox1.String=List_nom{2};
        
        handles.data.selec=0;
        handles.data.nbr=N-1;
    else
        handles.data.lim=List_im{1};
        handles.data.lnom=List_nom{1};
        
        handles.listbox1.Value=a-1;
        handles.listbox1.String=List_nom{1};
        
        handles.data.selec=0;
        handles.data.nbr=N-1;
    end
elseif(N==0)
    warndlg('Ajouter une image','!! Warning !!');
else
    if (a==0)
        warndlg('Selectionner une image','!! Warning !!');  
    elseif(a==1) %fait
        handles.data.lim={};
        handles.data.lnom={};
        
        handles.listbox1.Value=a;
        handles.listbox1.String={};
        
        handles.data.nbr=0;
        handles.data.hauteur=0;
        handles.data.longeur=0;
        handles.data.selec=0;
        handles.data.nbr=N-1;
     else
        errordlg('Error', '!! Error !!');
    end
end
guidata(hObject,handles);


% --- Executes on button press in toutsuppr.
function toutsuppr_Callback(hObject, eventdata, handles)
% hObject    handle to toutsuppr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.data.nbr=0;
handles.data.lim={};
handles.data.lnom={};
handles.listbox1.String={};
handles.data.selec=0;
handles.data.hauteur=0;
handles.data.longeur=0;
guidata(hObject,handles);
