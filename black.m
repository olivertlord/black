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

% Last Modified by GUIDE v2.5 30-Aug-2019 21:12:11

%--------------------------------------------------------------------------
% GUIDE GENERATED INITIALIZATION CODE
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

%--------------------------------------------------------------------------
% GUIDE GENERATED CREATE FUNCTIONS FOR GUI ELEMENTS
function edit_wavelength_min_left_CreateFcn(hObject, ~, ~) %#ok<INUSD>

function edit_wavelength_max_left_CreateFcn(hObject, ~, ~) %#ok<INUSD>

function edit_ROI_min_left_CreateFcn(hObject, ~, ~) %#ok<INUSD>

function edit_ROI_max_left_CreateFcn(hObject, ~, ~) %#ok<INUSD>

function edit_calname_right_CreateFcn(hObject, ~, ~) %#ok<INUSD>

function edit_calname_left_CreateFcn(hObject, ~, ~) %#ok<INUSD>

function edit_wavelength_min_right_CreateFcn(hObject, ~, ~) %#ok<INUSD>

function edit_wavelength_max_right_CreateFcn(hObject, ~, ~) %#ok<INUSD>

function edit_ROI_min_right_CreateFcn(hObject, ~, ~) %#ok<INUSD>

function edit_ROI_max_right_CreateFcn(hObject, ~, ~) %#ok<INUSD>

function edit_filename_CreateFcn(hObject, ~, ~) %#ok<INUSD>

function edit_file_max_CreateFcn(hObject, ~, ~) %#ok<INUSD>

function edit_file_min_CreateFcn(hObject, ~, ~) %#ok<INUSD>

function popupmenu_fit_type_CreateFcn(hObject, ~, ~) %#ok<INUSD>

function popupmenu_error_min_type_CreateFcn(~, ~, ~)

function edit_Background_File_CreateFcn(~, ~, ~)


%--------------------------------------------------------------------------
% GUIDE GENERATED OPENING FUNCTION
% Executes just before black is made visible.
function black_OpeningFcn(hObject, ~, handles, varargin)

% Sets button and edit box state
control_colors({1 1 0 0 1 0 0 0 1 1 1 1 1 1 1 1 1 1},handles)

% Sets titles and labels of figures by calling function plot_axes
plot_axes(handles,'plot_wien_left','w', 'j', 'Wien fits','Left',1,1)

plot_axes(handles,'plot_residuals_left','w', '', '','Left',1,1)

plot_axes(handles,'plot_wien_right','w', 'j', 'Wien fits','Right',1,1)

plot_axes(handles,'plot_residuals_right','w', '', '','Right',1,1)

plot_axes(handles,'plot_section_left','microns', 'Temperature (K)',...
    '', 'Left',0,1)

plot_axes(handles,'plot_section_pixels_left','pixels', '',...
    'Cross-sections', 'Left',1,1)

plot_axes(handles,'plot_section_right','microns','Temperature (K)',...
    '','Right',0,1)

plot_axes(handles,'plot_section_pixels_right','pixels', '',...
    'Cross-sections', 'Right',1,1)

plot_axes(handles,'plot_history','Elapsed Time (S)',...
    'Peak Temperature (K)','Temperature History', 'Right',0,1)

plot_axes(handles,'plot_emin_left','min lambda (nm)',...
    'Average Error (K)','Error Minimisation', 'Right',1,1)

plot_axes(handles,'plot_emin_right','min lambda (nm)',...
    'Average Error (K)','Error Minimisation', 'Right',1,1)

plot_axes(handles,'plot_raw','pixels','pixels','RAW CCD IMAGE','Right',0,1)

% Choose default command line output for IRS
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Load current calibration file names
load('calibration.mat'); 
set(handles.edit_calname_left,'string',name_l);
set(handles.edit_calname_right,'string',name_r);

% Initialise file_counter
file_counter = 1;

% Initialise increment_flag
increment_flag = 0;

% Store file_counter in AppData
setappdata(0,'file_counter',file_counter);

% Initialise auto_flag
setappdata(0,'auto_flag',0);

% Set increment flag
setappdata(0,'increment_flag',increment_flag)

% Store handles structures in AppData
setappdata(0,'handles',handles)

% Read in hardware parameters
hp = matfile('hardware_parameters.mat','Writable',true);

% Update wavelengths based on current hardware parameters
pixels = 1:1024;
hp.w = hp.conp+hp.pix1.*pixels+hp.pix2.*pixels.^2;

%--------------------------------------------------------------------------
% GUIDE GENERATED OUTPUT FUNCTION
function varargout = black_OutputFcn(~, ~, handles) 

varargout{1} = handles.output;

%--------------------------------------------------------------------------
% CALLBACK FUNCTIONS

%--- LEFT MIN WAVELENGTH EDIT BOX -----------------------------------------
function edit_wavelength_min_left_Callback(~, ~, handles) %#ok<*DEFNU>

% Load previous file path from .MAT file
unkmat = matfile('unknown.mat','Writable',true);

% Prevent user going beyond range
if eval(get(handles.edit_wavelength_min_left,'string')) < unkmat.wavelengths(1,1)
    set(handles.edit_wavelength_min_left,'string',num2str(round(unkmat.wavelengths(1,1))));
end

% Updates ROI boxes by calling function ROI
ROI(handles)

%--- LEFT MAX WAVELENGTH EDIT BOX -----------------------------------------
function edit_wavelength_max_left_Callback(~, ~, handles)

% Load previous file path from .MAT file
unkmat = matfile('unknown.mat','Writable',true);

% Prevent user going beyond range
if eval(get(handles.edit_wavelength_max_left,'string')) > unkmat.wavelengths(1,end)
    set(handles.edit_wavelength_max_left,'string',num2str(round(unkmat.wavelengths(1,end))));
end

% Updates ROI boxes by calling function ROI
ROI(handles)

%--- LEFT MIN ROI EDIT BOX ------------------------------------------------
function edit_ROI_min_left_Callback(~, ~, handles)

% Prevent user going beyond range
if eval(get(handles.edit_ROI_min_left,'string')) < 128
    set(handles.edit_ROI_min_left,'string',num2str(128));
end

% Updates ROI boxes by calling function ROI
ROI(handles)

%--- LEFT MAX ROI EDIT BOX ------------------------------------------------
function edit_ROI_max_left_Callback(~, ~, handles)

% Prevent user going beyond range
if eval(get(handles.edit_ROI_max_left,'string')) > 256
    set(handles.edit_ROI_max_left,'string',num2str(256));
end

% Updates ROI boxes by calling function ROI
ROI(handles)

%--- RIGHT MIN WAVELENGTH EDIT BOX -----------------------------------------
function edit_wavelength_min_right_Callback(~, ~, handles) %#ok<*DEFNU>

% Load previous file path from .MAT file
unkmat = matfile('unknown.mat','Writable',true);

% Prevent user going beyond range
if eval(get(handles.edit_wavelength_min_right,'string')) < unkmat.wavelengths(1,1)
    set(handles.edit_wavelength_min_right,'string',num2str(round(unkmat.wavelengths(1,1))));
end

% Updates ROI boxes by calling function ROI
ROI(handles)

%--- RIGHT MAX WAVELENGTH EDIT BOX -----------------------------------------
function edit_wavelength_max_right_Callback(~, ~, handles)

% Load previous file path from .MAT file
unkmat = matfile('unknown.mat','Writable',true);

% Prevent user going beyond range
if eval(get(handles.edit_wavelength_max_right,'string')) > unkmat.wavelengths(1,end)
    set(handles.edit_wavelength_max_right,'string',num2str(round(unkmat.wavelengths(1,end))));
end

% Updates ROI boxes by calling function ROI
ROI(handles)

%--- RIGHT MIN ROI EDIT BOX ------------------------------------------------
function edit_ROI_min_right_Callback(~, ~, handles)

% Prevent user going beyond range
if eval(get(handles.edit_ROI_min_right,'string')) < 1
    set(handles.edit_ROI_min_right,'string',num2str(1));
end

% Updates ROI boxes by calling function ROI
ROI(handles)

%--- RIGHT MAX ROI EDIT BOX ------------------------------------------------
function edit_ROI_max_right_Callback(~, ~, handles)

% Prevent user going beyond range
if eval(get(handles.edit_ROI_max_right,'string')) > 128
    set(handles.edit_ROI_max_right,'string',num2str(128));
end

% Updates ROI boxes by calling function ROI
ROI(handles)

%--- POPUP MENU FIT TYPE --------------------------------------------------
function popupmenu_fit_type_Callback(~, ~, ~)

%--- RADIOBUTTON AUTO ROTATE ----------------------------------------------
function radiobutton_auto_rotate_Callback(~, ~, ~)

%--- RADIOBUTTON T CORRECTION ---------------------------------------------
function radiobutton_T_correction_Callback(~, ~, ~)

%--- RADIOBUTTON ERROR MIN ------------------------------------------------
function radiobutton_error_min_Callback(~, ~, ~)

%--- RADIOBUTTON W EMISSIVITY ---------------------------------------------
function radiobutton_W_emissivity_Callback(~, ~, ~)

%--- RADIOBUTTON SMOOTH ---------------------------------------------------
function slider_smooth_Callback(~, ~, handles)

% Update text box when slider is changed
smooth = ceil(get(handles.slider_smooth,'Value'));
set(handles.text_smooth,'String',num2str(smooth));

%--- RADIOBUTTON DESATURATE -----------------------------------------------
function radiobutton_desaturate_Callback(~, ~, ~)

%--- RADIOBUTTON SAVE OUTPUT ----------------------------------------------
function radiobutton_save_output_Callback(~, ~, ~)

%--- UPDATE CALIBRATION FILE PUSHBUTTON -----------------------------------
function pushbutton_update_calibration_files_Callback(~, ~, handles)

% Load current calibration data
calmat = matfile('calibration.mat','Writable',true);

% User selects left calibration file
[calmat.name_l, calmat.path] = uigetfile(strcat(calmat.path,'*.SPE;*.sif'),...
    'Winspec Calibration File - LEFT'); 
set(handles.edit_calname_left,'string',calmat.name_l);

% User selects right calibration file
[calmat.name_r, calmat.path] = uigetfile(strcat(calmat.path,'*.SPE;*.sif'),...
    'Winspec Calibration File - RIGHT');
set(handles.edit_calname_right,'string',calmat.name_r);

% Read .sif files from iDus detector using Andor sifreader
if strcmp(calmat.name_l(1,end-2:end), 'sif') == 1
    
    disp('check')
    [calmat.cal_l,calmat.wavelengths] = sifreader(strcat(calmat.path,calmat.name_l));
    [calmat.cal_r,calmat.wavelengths] = sifreader(strcat(calmat.path,calmat.name_r));
    
    % Remove saturated pixels
    %calmat.cal_l(calmat.cal_l> 64000) = NaN;
    %calmat.cal_r(calmat.cal_r> 64000) = NaN;

% Read .spe files from PIXIS detector
elseif strcmp(calmat.name_l(1,end-2:end),'spe') == 1
    
    fid=fopen(strcat(calmat.path,calmat.name_l),'r');
    calmat.cal_l=fread(fid,[1024,256],'real*4','l');
    fclose(fid);
    
    fid=fopen(strcat(calmat.path,calmat.name_r),'r');
    calmat.cal_r=fread(fid,[1024,256],'real*4','l');
    fclose(fid);
    
    % Remove saturated pixels
    calmat.cal_l(calmat.cal_l> 8.4077e-41) = NaN;
    calmat.cal_r(calmat.cal_r> 8.4077e-41) = NaN;
end
%--- UNKNOWN FILE PUSHBUTTON ----------------------------------------------
function pushbutton_unknown_file_Callback(~, ~, handles)

% Load previous file path from .MAT file
unkmat = matfile('unknown.mat','Writable',true);

% Prompts uder to select unknown file(s)
[unkmat.names,unkmat.path]=uigetfile(strcat(unkmat.path,'*.SPE;*.sif'),...
    'Select Image(s)','MultiSelect','on');

% Ensure filenames are strings
if ischar(unkmat.names(1,:)) == true
    filenames = cellstr(unkmat.names);
else
    filenames = unkmat.names;
end

% Prints first filename to GUI
set(handles.edit_filename,'string',filenames);

% Read first .sif file to check wavelength using Andor sifreader
[unkmat.unk,unkmat.wavelengths] = sifreader(strcat(unkmat.path,...
            filenames{1}));

data_prep(handles,unkmat.path,filenames{1},1);

% Initializes file_counter
file_counter = 1;

% Stores file_counter in AppData
setappdata(0,'file_counter',file_counter);

% Update button and edit box state
if length(unkmat.names) < 2
    control_colors({1 1 0 0 1 1 1 0 1 1 1 1 1 1 1 1 1 1},handles)
elseif length(unkmat.names) >= 2
    control_colors({1 1 1 1 1 1 1 0 1 1 1 1 1 1 1 1 1 1},handles)
end

% Update wavelength range boxes
set(handles.edit_wavelength_min_left,'string',num2str(round(min(unkmat.wavelengths))));
set(handles.edit_wavelength_max_left,'string',num2str(round(max(unkmat.wavelengths))));
set(handles.edit_wavelength_min_right,'string',num2str(round(min(unkmat.wavelengths))));
set(handles.edit_wavelength_max_right,'string',num2str(round(max(unkmat.wavelengths))));

% Updates ROI boxes by calling function ROI
ROI(handles)

%--- CHOOSE BACKGROUND FILE -----------------------------------------------
function pushbutton_background_file_Callback(~, ~, handles)

% Read in hardware parameters
hp = matfile('hardware_parameters.mat','Writable',true);

% Load previous file path from .MAT file
unkmat = matfile('unknown.mat','Writable',true);

% Prompts uder to select unknown file(s)
[backfile,backpath]=uigetfile(strcat(unkmat.path,'*.SPE;*.SIF'),...
    'Select Background Image(s)');

% Read .sif files using Andor sifreader
if strcmp(backfile(1,end-2:end), 'sif') == 1
    backdata = sifreader(strcat(backpath,backfile));

% Read .spe files
elseif strcmp(calmat.name_l(1,end-2:end),'spe') == 1
    fid=fopen(strcat(backpath,backfile),'r');
    backdata=fread(fid,[hp.col hp.row],'real*4','l');
end

% Prints background filename to GUI
set(handles.edit_Background_File,'string',backfile);

% Store list of selected files in AppData
setappdata(0,'backdata',backdata);

% --- DECREMENT PUSHBUTTON ------------------------------------------------
function pushbutton_decrement_Callback(~, ~, handles)

% Get list of stored files from AppData
ufiles = getappdata(0,'ufiles');

% Get current file
current_file = get(handles.edit_filename,'String');

% Get the current position
idx = strfind(ufiles,current_file);
file_counter = find(not(cellfun('isempty',idx)));

% Unless we are at the beginning of the list
if file_counter > 1
    
    % Decrement file_counter
    file_counter = file_counter - 1;
    
    % Store updated value in AppData
    setappdata(0,'file_counter',file_counter)
    
end

% Set increment flag
setappdata(0,'increment_flag',1)

% Execute process pushbutton code    
pushbutton_process_Callback([],[],handles)

% --- INCREMENT PUSHBUTTON ------------------------------------------------
function pushbutton_increment_Callback(~, ~, handles)

% Get list of stored files from AppData
ufiles = getappdata(0,'ufiles');

% Get current file
current_file = get(handles.edit_filename,'String');
assignin('base','ufiles',ufiles)

% Get the current position
idx = strfind(ufiles,current_file);
file_counter = find(not(cellfun('isempty',idx)));

% Unless we are at the end of the list
if file_counter < length(ufiles)
    
    % Decrement file_counter
    file_counter = file_counter + 1;
    
    % Store updated value in AppData
    setappdata(0,'file_counter',file_counter)    
    
end

% Set increment flag
setappdata(0,'increment_flag',1)

% Execute process pushbutton code
pushbutton_process_Callback([],[],handles)

% --- PROCESS PUSHBUTTON --------------------------------------------------
function pushbutton_process_Callback(~, ~, handles)

control_colors({1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1},handles)


% Load unknown matfile
unkmat = matfile('unknown.mat','Writable',true);

% Ensure filenames are strings
if ischar(unkmat.names(1,:)) == true
    filenames = cellstr(unkmat.names);
else
    filenames = unkmat.names;
end

% Load calibration matfile
calmat = matfile('calibration.mat','Writable',true);

% Get wavelengths
if isempty(strfind(cellstr(unkmat.names(1,:)), 'sif')) == false
    wavelengths = unkmat.wavelengths;
elseif isempty(strfind(cellstr(unkmat.names(1,:)), 'spe')) == false
    hp = matfile('hardware_parameters.mat','Writable',true);
    wavelengths = hp.w;
end

% Get current value of file_counter
file_counter = getappdata(0,'file_counter');

% Get current value of increment flag
increment_flag = getappdata(0,'increment_flag');

% If increment mode is not selected
if increment_flag == 0
    
    % Clear all axes
    %arrayfun(@cla,findall(0,'type','axes'));
    
    filelist = filenames(1,:);
    
elseif increment_flag == 1
    
    filelist = filenames(file_counter,:);
    
end

% Prints current filename to GUI
%set(handles.edit_filename,'String',filelist(file_counter,:));

% Reset increment flag
setappdata(0,'increment_flag',0)

% Oopen file w/ W-lamp spectral radiance values (lamp)
fid = fopen(strcat(pwd,'/E256.dat'),'r','l');
for i = 1:58
    E(i) = fscanf(fid,'%f6.3'); %#ok<AGROW>
end
for i = 1:58
    lam(i)=460+i*10; %#ok<AGROW>
end

hp.sr = lampcal(wavelengths,lam,E);

% Create a unique folder with date and time if save output radiobutton is 
% selected
folder = strcat('output_black_',regexprep(datestr(now),'[\s :]','-'));
if get(handles.radiobutton_save_output,'Value') == 1
    
    mkdir(strcat(unkmat.path,folder));
    
    % Copy calibration.mat and hardware_parameters.mat to new folder
    copyfile(strcat(pwd,'/calibration.mat'),...
        strcat(unkmat.path,folder,'/calibration.mat'));
    copyfile(strcat(pwd,'/hardware_parameters.mat'),...
        strcat(unkmat.path,folder,'/hardware_parameters.mat'));

end

% Create directory if in auto mode and if it doesnt yet exist
if getappdata(0,'auto_flag') == 1 && exist(strcat(getappdata(0,'upath'),folder),'dir') == 0
    
    mkdir(strcat(upath,folder));

end

setappdata(0,'sum_store',zeros(1024,256,length(unkmat.names)));

if getappdata(0,'auto_flag') > 0;
    timeStart = getappdata(0, 'timeStart');
else
    FileInfo = dir(strcat(unkmat.path,filelist{1}));
    timestamp = datenum(FileInfo.date);
    timevector = datevec(timestamp);
    timeStart = (timevector(1,6) + (timevector(1,5)*60) + (timevector(1,4)*60*60));
end
    
for i = 1:length(filelist)
    [unkdata,skip] = data_prep(handles,unkmat.path,filelist{i},i);
    FileInfo = dir(strcat(unkmat.path,filelist{i}));
    timestamp = datenum(FileInfo.date);
    timevector = datevec(timestamp);
    timeSec = (timevector(1,6) + (timevector(1,5)*60) + (timevector(1,4)*60*60));
    elapsedSec = round(timeSec-timeStart);
    
    if skip == 0
        Tcalc(handles, unkmat.path, folder, unkdata, calmat.cal_l, calmat.cal_r, hp, wavelengths, i, elapsedSec, filelist{i}, timestamp);
    end
end

% --- CLEAR FIGURES BUTTON ------------------------------------------------

function pushbutton_clear_figures_Callback(~, ~, ~)
arrayfun(@cla,findall(0,'type','axes'))
clear all;  
clear global;
fclose('all');

% --- EXIT BUTTON ---------------------------------------------------------

function pushbutton_quit_Callback(~, ~, ~)
clear all;
clear global;
fclose('all');
close all;

% --- UPDATE HARDWARE PARAMETERS BUTTON -----------------------------------

function pushbutton_update_hardware_parameters_Callback(~, ~, ~)
hardware_parameters

% --- IMCREMENT MODE ------------------------------------------------------

function radiobutton_increment_Callback(~, ~, handles)

set(handles.pushbutton_live,'enable','on')
% Enables live mode radiobutton when increment mode is switched off

if get(handles.radiobutton_increment,'Value') == 1
    
    set(handles.pushbutton_live,'enable','off')
    % Disables live mode radiobutton when increment mode is switched on
    
end

% --- AUTO MODE -----------------------------------------------------------

function pushbutton_live_Callback(hObject, eventdata, handles)

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
set(handles.radiobutton_save_output,'enable','on');
% Enables all buttons when auto mode is switched off

%set(handles.radiobutton_increment,'enable','on')
% Enables increment radiobutton when auto mode is switched off

if get(handles.pushbutton_live,'Value') == 1
    
    buttons = findobj('Style','pushbutton');
    set(buttons, 'enable', 'off')
    % Disables all buttons when auto mode is switched off
    
    %set(handles.radiobutton_increment,'enable','off')
    % Disables increment radiobutton in auto mode
    
    set(handles.radiobutton_save_output,'Value',1);
    set(handles.radiobutton_save_output,'enable','off');
    
    upath = strcat(uigetdir('C:\Documents and Settings\Oliver Lord\Desktop\Data.SPE','Winspec unknown File'),'/');
    setappdata(0,'upath',upath);
    
    dir_content = dir(strcat(upath,'*.sif'));
    initial_list = {dir_content.name};
    % Collect list of current .TIFF files
    
    unkmat =  matfile('unknown.mat','Writable',true);

    while get(handles.pushbutton_live,'Value') == 1
        pause(0.5)
        dir_content = dir(strcat(upath,'*.sif'));
        new_list = {dir_content.name};
        % Collects new list of filenames
        new_filename = setdiff(new_list,initial_list);
        % Determines list of new files

        if ~isempty(new_filename)
            strcat(upath,new_filename{1})
            
            if auto_flag == 0;
                FileInfo = dir(strcat(upath,new_filename{1}));
                timestamp = datenum(FileInfo.date);
                timevector = datevec(timestamp);
                timeStart = (timevector(1,6) + (timevector(1,5)*60) + (timevector(1,4)*60*60));
                setappdata(0, 'timeStart', timeStart)
            end
            
            auto_flag = auto_flag + 1;
            setappdata(0,'auto_flag',auto_flag);
            % Increments auto_flag each time a new file is processed
            
            set(handles.edit_filename,'string',new_filename{1});
            % Update GUI boxes
            
            unkmat.names = new_filename{1};
            unkmat.path = upath;
            
            % Read first .sif file to check wavelength using Andor sifreader
            [unkmat.unk,unkmat.wavelengths] = sifreader(strcat(upath,...
                new_filename{1}));

            % Update wavelength range boxes
            set(handles.edit_wavelength_min_left,'string',num2str(round(min(unkmat.wavelengths))));
            set(handles.edit_wavelength_max_left,'string',num2str(round(max(unkmat.wavelengths))));
            set(handles.edit_wavelength_min_right,'string',num2str(round(min(unkmat.wavelengths))));
            set(handles.edit_wavelength_max_right,'string',num2str(round(max(unkmat.wavelengths))));
            
            pushbutton_process_Callback(hObject, eventdata, handles)
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
function pushbutton_rotate_Callback(~, ~, handles)
rotate(handles);

% --- Executes on button press in radiobutton_sum.
function radiobutton_sum_Callback(~, ~,~)

% --- Executes on selection change in popupmenu_error_min_type.
function popupmenu_error_min_type_Callback(~, ~,~)

% --- Executes on button press in radiobutton_subtract_background.
function edit_Background_File_Callback(~, ~,~)

% --- Executes on button press in radiobutton_subtract_background.
function radiobutton_subtract_background_Callback(~, ~, handles)

% If the subtract background radiobutton is switched on but there is no
% background file selected then force user to select one
if get(handles.radiobutton_subtract_background,'Value') == 1 &&...
       strcmp(get(handles.edit_Background_File,'string'),'None') == 1
    pushbutton_background_file_Callback([], [], handles)
end
