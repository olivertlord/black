function varargout = hardware_parameters(varargin)
%--------------------------------------------------------------------------
% hardware_parameters (GUI)
%--------------------------------------------------------------------------
% Version 1.6
% Written and tested on Matlab R2014a (Windows 7) & R2017a (OS X 10.13)

% Copyright 2018 Oliver Lord, Weiwei Wang
% email: oliver.lord@bristol.ac.uk
 
% This file is part of MIRRORS.
 
% MIRRORS is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
 
% MIRRORS is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
 
% You should have received a copy of the GNU General Public License
% along with MIRRORS.  If not, see <http://www.gnu.org/licenses/>.
%--------------------------------------------------------------------------
%HARDWARE_PARAMETERS MATLAB code file for hardware_parameters.fig
%      HARDWARE_PARAMETERS, by itself, creates a new HARDWARE_PARAMETERS or
%      raises the existing singleton*.
%
%      H = HARDWARE_PARAMETERS returns the handle to a new
%      HARDWARE_PARAMETERS or the handle to the existing singleton*.
%
%      HARDWARE_PARAMETERS('Property','Value',...) creates a new
%      HARDWARE_PARAMETERS using the given property value pairs.
%      Unrecognized properties are passed via varargin to
%      hardware_parameters_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      HARDWARE_PARAMETERS('CALLBACK') and
%      HARDWARE_PARAMETERS('CALLBACK',hObject,...) call the local function
%      named CALLBACK in HARDWARE_PARAMETERS.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help hardware_parameters

% Last Modified by GUIDE v2.5 21-Feb-2019 15:56:24

%--------------------------------------------------------------------------
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @hardware_parameters_OpeningFcn, ...
                   'gui_OutputFcn',  @hardware_parameters_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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

% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,...
        'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,...
        'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,...
        'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit23_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,...
        'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit24_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,...
        'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit25_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,...
        'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit27_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,...
        'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit28_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,...
        'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%--------------------------------------------------------------------------
% --- Executes just before hardware_parameters is made visible.
function hardware_parameters_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.

% Choose default command line output for hardware_parameters
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Load current hardware_parameters
m = matfile('hardware_parameters.mat','Writable',true);
 
set(handles.edit9, 'String', num2str(m.conp)); 
set(handles.edit10, 'String', num2str(m.pix1)); 
set(handles.edit11, 'String', num2str(m.pix2));

set(handles.edit23, 'String', num2str(m.conl)); 
set(handles.edit24, 'String', num2str(m.lam1)); 
set(handles.edit25, 'String', num2str(m.lam2));

set(handles.edit27, 'string', num2str(m.row));
set(handles.edit28, 'string', num2str(m.col));

%--------------------------------------------------------------------------
% --- Outputs from this function are returned to the command line.
function varargout = hardware_parameters_OutputFcn(~, ~, handles)

% Get default command line output from handles structure
varargout{1} = handles.output;

%--------------------------------------------------------------------------
function edit9_Callback(~, ~, handles)
box = handles.edit9;
check_numeric(box)

%--------------------------------------------------------------------------
function edit10_Callback(~, ~, handles)
box = handles.edit10;
check_numeric(box)

%--------------------------------------------------------------------------
function edit11_Callback(~, ~, handles)
box = handles.edit11;
check_numeric(box)

%--------------------------------------------------------------------------
function edit23_Callback(~, ~, handles)
box = handles.edit23;
check_numeric(box)

%--------------------------------------------------------------------------
function edit24_Callback(~, ~, handles)
box = handles.edit24;
check_numeric(box)

%--------------------------------------------------------------------------
function edit25_Callback(~, ~, handles)
box = handles.edit25;
check_numeric(box)

%--------------------------------------------------------------------------
function edit27_Callback(~, ~, handles)
box = handles.edit24;
check_numeric(box)

%--------------------------------------------------------------------------
function edit28_Callback(~, ~, handles)
box = handles.edit25;
check_numeric(box)

%--------------------------------------------------------------------------
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(~, ~, handles)

m = matfile('hardware_parameters.mat','Writable',true);

m.conl = eval(get(handles.edit23,'String'));
m.lam1 = eval(get(handles.edit24,'String'));
m.lam2 = eval(get(handles.edit25,'String'));

m.conp = eval(get(handles.edit9,'String'));
m.pix1 = eval(get(handles.edit10,'String'));
m.pix2 = eval(get(handles.edit11,'String'));

m.row = eval(get(handles.edit27,'String'));
m.col = eval(get(handles.edit28,'String'));

close

%--------------------------------------------------------------------------
% --- Checks that entered data is numerical
function check_numeric(box)
str=get(box,'String');
if isempty(str2num(str))
    set(box,'string','0');
    warndlg('Input must be numerical');
end
