function varargout = black(varargin)
%--------------------------------------------------------------------------
% black
%--------------------------------------------------------------------------
% Version 6.0
% Written and tested on Matlab R2014a (Windows 7) & R2017a (OS X 10.13)

% Copyright 2018 Oliver Lord, Mike Walter
% email: oliver.lord@bristol.ac.uk
 
% This file is part of black.
 
% black is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
 
% black is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
 
% You should have received a copy of the GNU General Public License
% along with black.  If not, see <http://www.gnu.org/licenses/>.
%--------------------------------------------------------------------------
%black M-file for black.fig
%      black, by itself, creates a new black or raises the existing
%      singleton*.
%
%      H = black returns the handle to a new black or the handle to
%      the existing singleton*.
%
%      black('Property','Value',...) creates a new black using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to black_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      black('CALLBACK') and black('CALLBACK',hObject,...) call the
%      local function named CALLBACK in black.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".

%      hObject    handle to checkbox1 (see GCBO)
%      eventdata  reserved - to be defined in a future version of MATLAB
%      handles    structure with handles and user data (see GUIDATA)

%      handles    structure with handles and user data (see GUIDATA)
%      varargin   unrecognized PropertyName/PropertyValue pairs from the
%           command line (see VARARGIN)
%      varargout  cell array for returning output args (see VARARGOUT);

%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help black

% Last Modified by GUIDE v2.5 21-Feb-2019 16:01:06


%--------------------------------------------------------------------------
% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @black_OpeningFcn, ...
                   'gui_OutputFcn',  @black_OutputFcn, ...
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

% --- Executes just before IRS is made visible. ---------------------------

function black_OpeningFcn(hObject, ~, handles, varargin)

arrayfun(@cla,findall(0,'type','axes'));
setappdata(0,'increment_flag',0);
setappdata(0,'auto_flag',0);
% Clears all figures and initialises flags

set(gcf, 'MenuBar', 'none');
set(gcf, 'ToolBar', 'none');
% Hides menubar and toolbar in figure window

axes(handles.axes1)
plot_axes('w', 'j', 'Wien Fits','Left',1)
axes(handles.axes2)
plot_axes('w', 'j', 'Wien Fits','Right',1)
axes(handles.axes3)
plot_axes('microns', 'Temperature (K)', '', 'Left',0)
axes(handles.axes4)
plot_axes('microns', 'Temperature (K)', '', 'Right',0)
axes(handles.axes5)
plot_axes('Elapsed Time (S)', 'Peak Temperature (K)', 'Temperature History', 'Right',0)
axes(handles.axes6)
plot_axes('min lambda (nm)', 'Average Error (K)', 'Error Minimisation', 'Right',1)
axes(handles.axes7)
plot_axes('min lambda (nm)', 'Average Error (K)', 'Error Minimisation', 'Right',1)

axes(handles.axes8)
plot_axes('pixels', '', '', 'Right',1)
uistack(handles.axes8,'bottom');
grid(handles.axes8,'on')

axes(handles.axes9)
plot_axes('pixels', '', '', 'Left',1)
uistack(handles.axes9,'bottom');
grid(handles.axes9,'on')

axes(handles.axes10)
plot_axes('pixels', 'pixels', 'RAW CCD IMAGE', 'Right',0)
% Sets titles and labels of figures by calling function plot_axes

setappdata(0,'handles',handles);
% Put handles structure into appdata

% Choose default command line output for IRS
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Load current calibration file names
load('calibration.mat');
set(handles.edit2,'string',name_l);
set(handles.edit12,'string',name_r);

% --- Outputs from this function are returned to the command line. --------

function varargout = black_OutputFcn(~, ~, handles) 

varargout{1} = handles.output;

% --- Create functions: Execute during object creation, after setting all -
% properties --------------------------------------------------------------

function edit2_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit7_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit8_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit9_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit10_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit12_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit15_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit16_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit17_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit18_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit20_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit21_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit22_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Callback functions with no content ----------------------------------

function edit2_Callback(~, ~, ~) %#ok<*DEFNU>
function edit12_Callback(~, ~, ~)
function edit20_Callback(~, ~, ~)
function edit21_Callback(~, ~, ~)
function edit22_Callback(~, ~, ~)
function radiobutton1_Callback(~,~,~)
function radiobutton2_Callback(~,~,~)
function radiobutton6_Callback(~,~,~)
function radiobutton8_Callback(~, ~, ~)
function radiobutton34_Callback(~, ~, ~)
function popupmenu1_Callback(~, ~, ~)

% --- Callback  functions with content ------------------------------------

function edit7_Callback(~, ~, handles)

ROI(handles)
% Updates ROI boxes by calling function ROI

function edit8_Callback(~, ~, handles)

ROI(handles)
% Updates ROI boxes by calling function ROI

function edit9_Callback(~, ~, handles)

ROI(handles)
% Updates ROI boxes by calling function ROI

function edit10_Callback(~, ~, handles)

ROI(handles)
% Updates ROI boxes by calling function ROI

function edit15_Callback(~, ~, handles)

ROI(handles)
% Updates ROI boxes by calling function ROI

function edit16_Callback(~, ~, handles)

ROI(handles)

function edit17_Callback(~, ~, handles)

ROI(handles)
% Updates ROI boxes by calling function ROI

function edit18_Callback(~, ~, handles)

ROI(handles)
% Updates ROI boxes by calling function ROI

%--------------------------------------------------------------------------
% --- Executes when user clisks on the Update Calibration Image button
function pushbutton1_Callback(~, ~, handles) %#ok<DEFNU>

% Load current calibration data
calmat = matfile('calibration.mat','Writable',true);

% Extracts path to folder containing black
split_path = strsplit(mfilename('fullpath'), 'black');

% Creates path to black
home_path = strcat(split_path{1},'black',split_path{2});

% User points to left calibration file. File browser starts in calibration
% folder regardless of the path to black
[cfilel, calpath] = uigetfile(strcat(home_path,'calibration/*.SPE'),...
    'Winspec Calibration File - LEFT'); %#ok<ASGLU>
set(handles.edit2,'string',cfilel);

% User points to right calibration file. File browser starts in calibration
% folder regardless of the path to black
[cfiler, calpath] = uigetfile(strcat(home_path,'calibration/*.SPE'),...
    'Winspec Calibration File - RIGHT');
set(handles.edit12,'string',cfiler);

% Read in left hand calibration data and convert to double
fid=fopen(strcat(calpath,cfilel),'r');
cal_data_l=fread(fid,[1024,256],'real*4','l');
fclose(fid);

% Read in right hand calibration data and convert to double
fid=fopen(strcat(calpath,cfiler),'r');
cal_data_r=fread(fid,[1024,256],'real*4','l');
fclose(fid);

% Save data to .MAT file
calmat.cal_l = cal_data_l;
calmat.cal_r = cal_data_r;
calmat.name_l = cfilel;
calmat.name_r = cfiler;

% Put calibration file path into appdata
setappdata(0,'calpath',calpath);

% --- User sets unknown file ----------------------------------------------
function pushbutton29_Callback(~, ~, handles)

[ufile,upath]=uigetfile('C:\Documents and Settings\Oliver Lord\Desktop\Data.SPE','Winspec unknown File');
set(handles.edit20,'string',ufile);
setappdata(0,'upath',upath);
% User selects file, apply name to GUI box, add path to appdata for later
% use

[~, filenumber, prefix] = file_enumerator (upath, ufile);
% Function enumerator called to determine filenumber from filename

set(handles.edit22,'string',num2str(filenumber));
set(handles.edit21,'string',num2str(filenumber));
% Set initial and last file number boxes in GUI

data_prep(handles,filenumber,prefix,filenumber,1024,256);

ROI(handles)

% --- FILE RANGE MODE - FIT BUTTON-----------------------------------------
function pushbutton30_Callback(~, ~, handles)

if getappdata(0,'auto_flag') < 2 && get(handles.radiobutton41,'Value') == 0
    arrayfun(@cla,findall(0,'type','axes'));
end
% Clear all plots within GUI

ufile = get(handles.edit20,'string');
% Get name of unknown file from GUI box

upath = getappdata(0,'upath');
% Get unknown file path from appdata

calpath = getappdata(0,'calpath');
% Get calibration file path from appdata

dir_content = dir(strcat(upath,'*.SPE'));

[filelist, filenumber, prefix] = file_enumerator (upath, ufile);
% Call enumerator to extract complete file listing unless in auto mode

auto_flag = getappdata(0,'auto_flag');
% Get auto_flag state

if auto_flag ~= 0
    set(handles.edit21,'string',num2str(filenumber));
    set(handles.edit22,'string',num2str(filenumber));
end
% Set GUI boxes to current filenumber if in auto mode

fi = eval(get(handles.edit22,'string'));
fl = eval(get(handles.edit21,'string'));
% Get file range from GUI boxes
    
if fl<fi
    fl = fi;
    set(handles.edit21,'string',num2str(fl));
end
% Catches fl<fi user input error

if (fl>1) && (filenumber~=fi)
    ufile = horzcat(prefix,num2str(fi),'.SPE');
    set(handles.edit20,'string',ufile);
end
% Changes filename if it does not match fi

if get(handles.radiobutton41,'Value') == 1
    
    if fl ~= fi
        history_length = length(filelist(filelist>=fi & filelist<=fl));
        setappdata(0,'history_length',history_length);
    end
    % If user previously fitted a file range, determine the length of that
    % range to ensure persistent variables are not overwritten
    
    [fl, fi] = deal(fl + 1);
    % Sets GUI boxes to the next file number
    
    while fl < max(filelist(:)) && ~ismember(fl,filelist)
        [fl, fi] = deal(fl + 1);
    end
    % Skips over missing files
    
    if fl > max(filelist(:))
        [fl, fi] = deal(max(filelist(:)));
    end
    % Prevents user incrmenting beyond max file number in directory
    
    ufile = horzcat(prefix,num2str(fi),'.SPE');
    set(handles.edit20,'string',ufile);
    set(handles.edit22,'string',num2str(fi));
    set(handles.edit21,'string',num2str(fl));
    % Updates GUI boxes to new values
    
elseif get(handles.radiobutton41,'Value') == 0 && fi == fl
    
    history_length = -1;
    setappdata(0,'history_length',history_length);
    % Sets history_length to special value -1 in unique situation in which
    % user executes a non-incrementing Wien Fit to a single file

else
    
    history_length = 0;
    setappdata(0,'history_length',history_length);
    % Sets history_length to zero in all other cases; i.e. if increment
    % button is not checked and fi ~= fl
    
end
% Increments current file by one if user has selected radiobutton

[savename, result] = Tcalc(handles, fi, fl, filelist, upath, prefix, calpath); %#ok<ASGLU>
% Calls Tcalc

result_file = char(strcat(upath,'/',savename,'/',savename,'_summary.txt'));
save(result_file,'result','-ASCII','-double');
% Saves summary data to text file

% --- CLEAR FIGURES BUTTON ------------------------------------------------

function pushbutton35_Callback(~, ~, ~)
arrayfun(@cla,findall(0,'type','axes'))
clear all;   %#ok<CLFUN>
clear global;
fclose('all');

% --- EXIT BUTTON ---------------------------------------------------------

function pushbutton39_Callback(~, ~, ~)
clear all;   %#ok<CLFUN>
clear global;
fclose('all');
close all;

% --- UPDATE HARDWARE PARAMETERS BUTTON -----------------------------------

function pushbutton44_Callback(hObject, eventdata, handles)
hardware_parameters

% --- IMCREMENT MODE ------------------------------------------------------

function radiobutton41_Callback(~, ~, handles)

set(handles.radiobutton5,'enable','on')
% Enables live mode radiobutton when increment mode is switched off

if get(handles.radiobutton41,'Value') == 1
    
    set(handles.radiobutton5,'enable','off')
    % Disables live mode radiobutton when increment mode is switched on
    
end

% --- AUTO MODE -----------------------------------------------------------

function radiobutton5_Callback(hObject, eventdata, handles)

clear global code timestamp timeSec elapsedSec errpeakl errpeakr...
    maxtempl maxtempr avel stdtempl min_lambda_left max_lambda_left aver...
    stdtempr min_lambda_right max_lambda_right
% Clear global variables

auto_flag = 0;
setappdata(0,'auto_flag',auto_flag);
% Set auto_flag to 0. Ensures auto_flag is zero if user deselects
% radiobutton

buttons = findobj('Style','pushbutton');
set(buttons, 'enable', 'on')
set(handles.radiobutton9,'enable','on');
% Enables all buttons when auto mode is switched off

set(handles.radiobutton41,'enable','on')
% Enables increment radiobutton when auto mode is switched off

if get(handles.radiobutton5,'Value') == 1
    
    buttons = findobj('Style','pushbutton');
    set(buttons, 'enable', 'off')
    % Disables all buttons when auto mode is switched off
    
    set(handles.radiobutton41,'enable','off')
    % Disables increment radiobutton in auto mode
    
    set(handles.radiobutton9,'Value',1);
    set(handles.radiobutton9,'enable','off');
    
    upath = strcat(uigetdir('C:\Documents and Settings\Oliver Lord\Desktop\Data.SPE','Winspec unknown File'),'/');
    setappdata(0,'upath',upath);
    dir_content = dir(strcat(upath,'/*.SPE'));
    initial_list = {dir_content.name};
    % Collect list of current .TIFF files

    while get(handles.radiobutton5,'Value') == 1
        pause(0.5)
        dir_content = dir(strcat(upath,'/*.SPE'));
        new_list = {dir_content.name};
        % Collects new list of filenames
        new_filename = setdiff(new_list,initial_list);
        % Determines list of new files

        if ~isempty(new_filename)

            auto_flag = auto_flag + 1;
            setappdata(0,'auto_flag',auto_flag);
            % Increments auto_flag each time a new file is processed
            
            set(handles.edit20,'string',new_filename{end});
            % Update GUI boxes

            pushbutton30_Callback(hObject, eventdata, handles)
            % Calls main processing subroutine
            
            fclose('all');
            % Close open files
            
            initial_list = new_list;
            % Updates initial list to include new files
        end
        % Performs T measurement if new file arrives
    end
    % Outer loop waiting for users to switch auto mode off
end
% Enters auto-mode if radiobutton is switched on

% --- UPDATE ROTATION PARAMETERS ------------------------------------------

function pushbutton43_Callback(~, ~, handles)

upath = getappdata(0,'upath');
% Get unknown data folder path

rotate(handles,upath);
% Call rotate function


% --- Executes on button press in radiobutton9.
function radiobutton9_Callback(hObject, eventdata, handles)
