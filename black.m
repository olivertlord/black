% *** BLACK VERSION 6: BY OLIVER T. LORD **********************************
% *************************************************************************

% Software for the fitting of spectroradiometric data to determine
% temperature cross-sections in both real-time and post-hoc.

% *************************************************************************

% --- Main GUI script -----------------------------------------------------

function varargout = black(varargin)
% BLACK M-file for black.fig

% --- Initialization code - DO NOT EDIT -----------------------------------

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
plot_axes('w', 'j', 'Wien Fits')
axes(handles.axes2)
plot_axes('w', 'j', 'Wien Fits')
axes(handles.axes3)
plot_axes('pixels', 'Temperature (K)', '')
axes(handles.axes4)
plot_axes('pixels', 'Temperature (K)', '')
axes(handles.axes5)
plot_axes('Elapsed Time (S)', 'Peak Temperature (K)', 'Temperature History')
axes(handles.axes6)
plot_axes('min lambda (nm)', 'Average Error (K)', 'Error Minimisation')
axes(handles.axes7)
plot_axes('min lambda (nm)', 'Average Error (K)', 'Error Minimisation')
axes(handles.axes8)
plot_axes('pixels', '', '')
axes(handles.axes9)
plot_axes('pixels', '', '')
axes(handles.axes10)
plot_axes('pixels', 'pixels', 'RAW CCD IMAGE')
% Sets titles and labels of figures by calling function plot_axes

colers=char('r','g','b','c','m','b');
setappdata(0,'colers',colers);
% Sets up global plot color list

setappdata(0,'ccnt',1);
% Initialises global color counter

% Choose default command line output for IRS
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

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

% --- User sets left hand calibraton file ---------------------------------
function pushbutton1_Callback(~, ~, handles)

cfilel = uigetfile('./calfiles/*.SPE','Winspec Calibration File');
set(handles.edit2,'string',cfilel);

% --- User sets right hand calibraton file --------------------------------
function pushbutton5_Callback(~, ~, handles)

cfiler = uigetfile('./calfiles/*.SPE','Winspec Calibration File');
set(handles.edit12,'string',cfiler);

% --- User sets unknown file ----------------------------------------------
function pushbutton29_Callback(~, ~, handles)

[ufile,upath]=uigetfile('C:\Documents and Settings\Oliver Lord\Desktop\Data.SPE','Winspec unknown File');
set(handles.edit20,'string',ufile);
setappdata(0,'upath',upath);
% User selects file, apply name to GUI box, add path to appdata for later
% use

[~, filenumber, ~] = file_enumerator (upath, ufile);
% Function enumerator called to determine filenumber from filename

set(handles.edit22,'string',filenumber);
set(handles.edit21,'string',filenumber);
% Set initial and last file number boxes in GUI

% --- FILE RANGE MODE - FIT BUTTON-----------------------------------------
function pushbutton30_Callback(~, ~, handles)

if getappdata(0,'auto_flag') < 2 && get(handles.radiobutton41,'Value') == 0
    arrayfun(@cla,findall(0,'type','axes'));
end
% Clear all plots within GUI

ufile = get(handles.edit20,'string');
% Get name of unknown file from GUI box

upath = getappdata(0,'upath');
% Get path from appdata

[filelist, filenumber, prefix] = file_enumerator (upath, ufile);
% Call enumerator to extract complete file listing 

fi = eval(get(handles.edit22,'string'));
fl = eval(get(handles.edit21,'string'));
% Get file range fro GUI boxes

if fl<fi
    fl = fi;
    set(handles.edit21,'string',fl);
end
% Catches fl<fi user input error

if (fl>1) && (filenumber~=fi)
    ufile = horzcat(prefix,fi,'.SPE');
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
    
    ufile = horzcat(prefix,fi,'.SPE');
    set(handles.edit20,'string',ufile);
    set(handles.edit22,'string',fi);
    set(handles.edit21,'string',fl);
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

[savename, result] = Tcalc(handles, fi, fl, filelist, upath, prefix); %#ok<ASGLU>
% Calls Tcalc

result_file = char(strcat(upath,'/',savename,'_summary.txt'));
save(result_file,'result','-ASCII','-double');
% Saves summary data to text file

% --- CLEAR FIGURES BUTTON ------------------------------------------------

function pushbutton35_Callback(~, ~, ~)
arrayfun(@cla,findall(0,'type','axes'))

% --- EXIT BUTTON ---------------------------------------------------------

function pushbutton39_Callback(~, ~, ~)
clear all;  %#ok<CLALL>
clear global;
close all;

% --- IMCREMENT MODE ------------------------------------------------------

function radiobutton41_Callback(~, ~, ~)

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
% Enables all buttons when auto mode if user deselects radiobutton

if get(handles.radiobutton5,'Value') == 1
    
    buttons = findobj('Style','pushbutton');
    set(buttons, 'enable', 'off')
    % Disables all buttons when auto mode is switched off
    
    upath = strcat(uigetdir('C:\Documents and Settings\Oliver Lord\Desktop\Data.SPE','Winspec unknown File'),'/');
    setappdata(0,'upath',upath);
    dir_content = dir(strcat(upath,'/*.SPE'));
    initial_list = {dir_content.name};
    % Collect list of current .TIFF files

    while get(handles.radiobutton5,'Value') == 1

        pause(1);
        dir_content = dir(strcat(upath,'/*.SPE'));
        new_list = {dir_content.name};
        % Collects new list of filenames

        new_filename = setdiff(new_list,initial_list);
        % Determines list of new files

        if ~isempty(new_filename)
            
            auto_flag = auto_flag + 1;
            setappdata(0,'auto_flag',auto_flag);
            % Increments auto_flag each time a new file is processed
            
            [~, filenumber, ~] = file_enumerator (upath, new_filename{1});
            % Call enumerator to extract file number from name
            
            set(handles.edit20,'string',new_filename{1});
            set(handles.edit21,'string',filenumber);
            set(handles.edit22,'string',filenumber);
            % Update GUI boxes

            pushbutton30_Callback(hObject, eventdata, handles)
            % Calls main processing subroutine

            initial_list = new_list;
            % Updates initial list to include new files
        end
        % Performs T measurement if new file arrives
    end
    % Outer loop waiting for users to switch auto mode off
end
% Enters auto-mode if radiobutton is switched on

% --- FILE ENUMERATOR -----------------------------------------------------

function [filelist, filenumber, prefix] = file_enumerator (upath, ufile)

dir_content = dir(strcat(upath,'*.SPE'));
[~,idx] = sort([dir_content.datenum]);
dir_content = dir_content(idx);
% Collect date sorted list of filenames

filelist = zeros(length(idx));
% Pre-allocate filelist array

for i = 1:length(dir_content)

    digit_str = '';
    counter_1 = 0;
    % Set counters
    
    for j = 5:length(dir_content(i).name)
        
        digit = dir_content(i).name(end+1-j:end+1-j);
        % Extract element of filename
        
        if isstrprop(digit,'digit')
        % Determine if it is a number
        
            digit_str = strcat(digit,digit_str);
            counter_1 = counter_1 + 1;
            % If it is, add it to previous digits & increment counter
            
        else
            
            filelist(i) = str2double(digit_str);
            % If it isn't a digit, save current run of digits to filelist
            % converted to numbers
            
            if strcmp(dir_content(i).name,ufile) == 1
            % If Current  filename (i) is the same as the string in the GUI
            % unknown file box, set filenumber to i
                
                filenumber = filelist(i);
                prefix = dir_content(i).name(1:end-(4+counter_1));
                % Determine prefix for saving files later
                
            end
           
            break
            % Exit loop
        
        end
        
    end
    % Extract number from end of file or arbitrary length with any 
    % preceding or subsequent non-numeric character

end

% --- PLOT AXES -----------------------------------------------------------

function plot_axes(xlab, ylab, title_string)

xlabel(xlab, 'FontSize', 14);
ylabel(ylab, 'FontSize', 14);
title(title_string, 'FontSize', 16);
% Sets plot attributes and is called whenever data is plotted

% --- UPDATE ROTATION PARAMETERS ------------------------------------------

function pushbutton43_Callback(~, ~, handles)

upath = getappdata(0,'upath');
% Get unknown data folder path

rotate(handles,upath);
% Call rotate function