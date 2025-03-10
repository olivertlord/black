function varargout = black(varargin)

% GUIDE GENERATED INITIALIZATION CODE ---------------------------------------------------------------------------------------
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

% GUIDE GENERATED CREATE FUNCTIONS FOR GUI ELEMENTS -------------------------------------------------------------------------
function edit_wavelength_min_left_CreateFcn(~, ~, ~) 
function edit_wavelength_max_left_CreateFcn(~, ~, ~)
function edit_ROI_min_left_CreateFcn(~, ~, ~)
function edit_ROI_max_left_CreateFcn(~, ~, ~)
function edit_calname_right_CreateFcn(~, ~, ~)
function edit_calname_left_CreateFcn(~, ~, ~)
function edit_wavelength_min_right_CreateFcn(~, ~, ~)
function edit_wavelength_max_right_CreateFcn(~, ~, ~)
function edit_ROI_min_right_CreateFcn(~, ~, ~)
function edit_ROI_max_right_CreateFcn(~, ~, ~)
function edit_filename_CreateFcn(~, ~, ~)
function edit_file_max_CreateFcn(~, ~, ~)
function edit_file_min_CreateFcn(~, ~, ~)
function popupmenu_fit_type_CreateFcn(~, ~, ~)
function popupmenu_error_min_type_CreateFcn(~, ~, ~)
function edit_Background_File_CreateFcn(~, ~, ~)

% OPENING FUNCTION ----------------------------------------------------------------------------------------------------------
function black_OpeningFcn(hObject, ~, handles, varargin)

% Sets button and edit box state
update_button_states({1 1 0 0 1 0 0 0 1 1 1 1 1 1 1 1 1 1 1 0 0},handles)

% Sets titles and labels of figures by calling function update_axes
update_axes(handles.plot_wien_left,'', 'j', '','Left',1,1)
update_axes(handles.plot_residuals_left,'w', '', '','Left',1,1)
update_axes(handles.plot_wien_right,'', 'j', '','Right',1,1)
update_axes(handles.plot_residuals_right,'w', '', '','Right',1,1)
update_axes(handles.plot_section_pixels_left,'pixels', '', '', 'Left',1,1)
update_axes(handles.plot_section_left,'microns', 'Temperature (K)', '', 'Left',0,1)
update_axes(handles.plot_section_pixels_right,'pixels', '', '', 'Right',1,1)
update_axes(handles.plot_section_right,'microns','Temperature (K)', '','Right',0,1)
update_axes(handles.plot_history,'Elapsed Time (S)', 'Peak Temperature (K)','Temperature History', 'Right',0,1)
update_axes(handles.plot_emin_left,'min lambda (nm)', '', 'Error Min Left', 'Right',1,1)
update_axes(handles.plot_emin_right,'min lambda (nm)', 'Average Error (K)', 'Error Min Right', 'Right',1,1)
update_axes(handles.plot_raw,'pixels','pixels', 'IMAGE','Right',0,1)

% Choose default command line output for IRS
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Load current calibration file names
load('calibration.mat', 'name_l', 'name_r'); 
set(handles.edit_calname_left,'string',name_l);
set(handles.edit_calname_right,'string',name_r);

% Read in hardware parameters
hp = matfile('hardware_parameters.mat','Writable',true);

% Update wavelengths based on current hardware parameters
pixels = 1:1024;
hp.w = hp.conp+hp.pix1.*pixels+hp.pix2.*pixels.^2;
unkmat = matfile('unknown.mat','Writable',true);
set(handles.edit_wavelength_min_left,'string',num2str(round(min(unkmat.wavelengths))));
set(handles.edit_wavelength_max_left,'string',num2str(round(max(unkmat.wavelengths))));
set(handles.edit_wavelength_min_right,'string',num2str(round(min(unkmat.wavelengths))));
set(handles.edit_wavelength_max_right,'string',num2str(round(max(unkmat.wavelengths))));

% OUTPUT FUNCTION -----------------------------------------------------------------------------------------------------------
function varargout = black_OutputFcn(~, ~, handles) 
varargout{1} = handles.output;

% EDIT BOX CALLBACKS --------------------------------------------------------------------------------------------------------
function edit_wavelength_min_left_Callback(hObject, eventdata, handles)
    edit_box_callback(hObject, eventdata, handles, 1, 'end', true);

function edit_wavelength_max_left_Callback(hObject, eventdata, handles)
    edit_box_callback(hObject, eventdata, handles, 1, 'end', true);

function edit_ROI_min_left_Callback(hObject, eventdata, handles)
    edit_box_callback(hObject, eventdata, handles, 128, 256, false);

function edit_ROI_max_left_Callback(hObject, eventdata, handles)
    edit_box_callback(hObject, eventdata, handles, 128, 256, false);

function edit_wavelength_min_right_Callback(hObject, eventdata, handles)
    edit_box_callback(hObject, eventdata, handles, 1, 'end', true);

function edit_wavelength_max_right_Callback(hObject, eventdata, handles)
    edit_box_callback(hObject, eventdata, handles, 1, 'end', true);

function edit_ROI_min_right_Callback(hObject, eventdata, handles)
    edit_box_callback(hObject, eventdata, handles, 1, 128, false);

function edit_ROI_max_right_Callback(hObject, eventdata, handles)
    edit_box_callback(hObject, eventdata, handles, 1, 128, false);

% UPDATE CALIBRATION FILE PUSHBUTTON ----------------------------------------------------------------------------------------
function pushbutton_update_calibration_files_Callback(~, ~, handles)

calmat = data_load('calibration.mat','name_l', 'path', 'cal_l', 'wavelengths', 'Winspec Calibration File - LEFT',...
    handles.edit_calname_left, 'on', false);
save('calibration.mat', '-struct', 'calmat', '-v7.3');

calmat = data_load('calibration.mat','name_r', 'path', 'cal_r', 'wavelengths', 'Winspec Calibration File - RIGHT',...
    handles.edit_calname_right, 'on', false);
save('calibration.mat', '-struct', 'calmat', '-v7.3');

% UNKNOWN FILE PUSHBUTTON ---------------------------------------------------------------------------------------------------
function pushbutton_unknown_file_Callback(~, ~, handles)

pushbutton_clear_figures_Callback([], [], handles)

% Load and validate files
unkmat = data_load('unknown.mat','names', 'path', 'unk', 'wavelengths', 'Select Image(s)', handles.edit_filename, 'on',...
    false);

% Update fitting queue
unkmat.queue = unkmat.names;
save('unknown.mat', '-struct', 'unkmat', '-v7.3');

data_prep(handles,unkmat.path,unkmat.names{1});

% Update button and edit box state
set(handles.radiobutton_sum,'value',0);
if length(unkmat.names) < 2
    update_button_states({2 2 0 0 2 1 1 2 2 2 2 2 2 2 2 2 2 2 2 0 2},handles)
elseif length(unkmat.names) >= 2
    update_button_states({2 2 0 1 2 1 1 2 2 2 2 2 2 2 2 2 2 2 2 1 2},handles)
end

% Draw ROIs on raw image
ROI(handles);

% FLIP IMAGE RADIOBUTTON ------------------------------------------------------------------------------------------------------
function radiobutton_flip_image_Callback(~, ~, ~)

% INCREMENT PUSHBUTTON ------------------------------------------------------------------------------------------------------
function pushbutton_increment_Callback(~, ~, handles)
% Load filenames from .MAT file
unkmat = data_load('unknown.mat', 'names', 'path', 'unkdata', 'wavelengths', '', [], '', true);

% Get the current filename from the text box
currentFilename = get(handles.edit_filename, 'String');

% Find the current filename index
currentIndex = find(strcmp(unkmat.names, currentFilename), 1);

% Check if the current index is valid and increment
if ~isempty(currentIndex) && currentIndex < numel(unkmat.names)
    newIndex = currentIndex + 1;
    set(handles.edit_filename, 'String', unkmat.names(newIndex))

    % Disable the button if the last file is reached
    if newIndex == numel(unkmat.names)
        update_button_states({2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2}, handles);
    end
end

% Update fitting queue
unkmat.queue = unkmat.names(newIndex);
save('unknown.mat', '-struct', 'unkmat', '-v7.3');

% Execute process pushbutton code
pushbutton_process_Callback([], [], handles);

% DECREMENT PUSHBUTTON ------------------------------------------------------------------------------------------------------
function pushbutton_decrement_Callback(~, ~, handles)

% Load filenames from .MAT file
unkmat = data_load('unknown.mat', 'names', 'path', 'unkdata', 'wavelengths', '', [], '', true);

% Get the current filename from the text box
currentFilename = get(handles.edit_filename, 'String');

% Find the current filename index
currentIndex = find(strcmp(unkmat.names, currentFilename), 1);

% Check if the current index is valid and decrement
if ~isempty(currentIndex) && currentIndex > 1
    newIndex = currentIndex - 1;
    set(handles.edit_filename, 'String', unkmat.names(newIndex));

    % Disable the button if the first file is reached
    if newIndex == 1
        update_button_states({2 2 0 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2}, handles);
    end
end

% Update fitting queue
unkmat.queue = unkmat.names(newIndex);
save('unknown.mat', '-struct', 'unkmat', '-v7.3');

% Execute process pushbutton code
pushbutton_process_Callback([], [], handles);

% CHOOSE BACKGROUND FILE ----------------------------------------------------------------------------------------------------
function pushbutton_background_file_Callback(~, ~, handles)

% Load and validate files
bakmat = data_load('background.mat','names', 'path', 'background', 'wavelengths', 'Select Image(s)',...
    handles.edit_Background_File, 'on', false);

% Update hardware parameters
save('background.mat', '-struct', 'bakmat', '-v7.3');

update_button_states({2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1}, handles)

% POPUP MENU FIT TYPE -------------------------------------------------------------------------------------------------------
function popupmenu_fit_type_Callback(~, ~, ~)

% POPUP MENU ERROR MIN ------------------------------------------------------------------------------------------------------
function popupmenu_error_min_type_Callback(~, ~,~)

% SLIDER SMOOTHING ----------------------------------------------------------------------------------------------------------
function slider_smooth_Callback(~, ~, handles)

% Update text box when slider is changed
smooth = ceil(get(handles.slider_smooth,'Value'));
set(handles.text_smooth,'String',num2str(smooth));

% RADIOBUTTON AUTO ROTATE ---------------------------------------------------------------------------------------------------
function radiobutton_auto_rotate_Callback(~, ~, ~)

% RADIOBUTTON T CORRECTION --------------------------------------------------------------------------------------------------
function radiobutton_T_correction_Callback(~, ~, ~)

% RADIOBUTTON W EMISSIVITY --------------------------------------------------------------------------------------------------
function radiobutton_W_emissivity_Callback(~, ~, ~)

% RADIOBUTTON SUM -----------------------------------------------------------------------------------------------------------
function radiobutton_sum_Callback(~, ~,handles)

if get(handles.radiobutton_sum,'value') == 1
    update_button_states({2 2 0 0 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2}, handles)

else
    unkmat = load('unknown.mat'); 
    unkmat.queue = unkmat.names;
    save('unknown.mat', '-struct', 'unkmat', '-v7.3');
    update_button_states({2 2 0 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2}, handles)
end

% RADIOBUTTON SUBTRACT ------------------------------------------------------------------------------------------------------
function radiobutton_subtract_background_Callback(~, ~, handles)

% If the subtract background radiobutton is switched on but there is no
% background file selected then force user to select one
if get(handles.radiobutton_subtract_background,'Value') == 1 &&...
       strcmp(get(handles.edit_Background_File,'string'),'None') == 1
    pushbutton_background_file_Callback([], [], handles)
end

% RADIOBUTTON SAVE OUTPUT ---------------------------------------------------------------------------------------------------
function radiobutton_save_output_Callback(~, ~, ~)

% PUSHBUTTON LIVE MODE ------------------------------------------------------------------------------------------------------
function pushbutton_live_Callback(hObject, eventdata, handles)

if get(handles.pushbutton_live,'Value') == 1

    pushbutton_clear_figures_Callback([], [], handles)
    
    set(handles.radiobutton_sum,'value',0);
    update_button_states({0 0 0 0 1 0 0 0 2 0 2 2 2 2 2 2 2 2 0 0 2}, handles)

    unkmat =  matfile('unknown.mat','Writable',true);

    if isequal(unkmat.path, 0)  % Check if user canceled
        unkmat.path = '';  % Set to empty string (or a default path)
    end
    unkmat.path = strcat(uigetdir(fullfile(unkmat.path, '*.sif'), 'Select target folder'),'/');
        
    dir_content = dir(strcat(unkmat.path,'*.sif'));

    % Collect list of current .TIFF files
    unkmat.names = {dir_content.name};

    timeStart = [];
    folder = [];

    while get(handles.pushbutton_live,'Value') == 1
        pause(0.5)
        % Make list of new files with their dates
        dir_content = dir(strcat(unkmat.path,'*.sif'));
        
        % Create a table with names and dates
        file_table = table({dir_content.name}', [dir_content.datenum]', ...
                           'VariableNames', {'Name', 'DateNum'});
        
        % Sort by date modified (newest first)
        file_table = sortrows(file_table, 'DateNum', 'descend');
        
        % Get sorted list of names
        sorted_list = file_table.Name';
        
        % Find which files are new (not in unkmat.names)
        new_files = {};
        for i = 1:length(sorted_list)
            if ~any(strcmp(sorted_list{i}, unkmat.names))
                new_files{end+1} = sorted_list{i}; %#ok<AGROW>
            end
        end
        
        % Check if there are any new files
        if ~isempty(new_files)
            % Process the first file (which is the newest since we sorted descending)
            unkmat.queue = new_files(1);
            
            % Update GUI boxes
            set(handles.edit_filename,'string',unkmat.queue);
            
            % Calls main processing subroutine
            [timeStart, folder] = pushbutton_process_Callback(hObject, eventdata, handles, timeStart, folder, 'auto');
            
            % Updates initial list to include all new files
            unkmat.names = [unkmat.names, new_files];
        end
    end
else
    update_button_states({1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0},handles)

end

% PUSHBUTTON PROCESS --------------------------------------------------------------------------------------------------------
function [timeStart, folder] = pushbutton_process_Callback(varargin)
% Flexible callback function with default arguments
% Handles cases where not all arguments are provided

% Set default values
handles = [];
timeStart = [];
mode = 'manual'; % Default mode

% Parse input arguments
if nargin >= 3
    handles = varargin{3};
end
if nargin >= 4
    timeStart = varargin{4};
end
if nargin >= 5
    folder = varargin{5}; %#ok<NASGU>
end
if nargin >= 6
    mode = varargin{6};
end

% Load unknown matfile
unkmat = matfile('unknown.mat','Writable',true);

% Load calibration matfile
calmat = matfile('calibration.mat','Writable',true);

% Get wavelengths
if ~contains(cellstr(unkmat.queue(1,:)), 'sif') == false
    wavelengths = unkmat.wavelengths;
elseif ~contains(cellstr(unkmat.queue(1,:)), 'spe') == false
    hp = matfile('hardware_parameters.mat','Writable',true);
    wavelengths = hp.w;
end

% Open file w/ W-lamp spectral radiance values (lamp)
fid = fopen(strcat(pwd,'/E256.dat'),'r','l');
for i = 1:58
    E(i) = fscanf(fid,'%f6.3'); %#ok<AGROW>
end
for i = 1:58
    lam(i)=460+i*10; %#ok<AGROW>
end
hp.sr = lampcal(wavelengths,lam,E);

% Create a unique folder with date and time if desired
folder = strcat('output_black_', regexprep(string(datetime('now', 'Format', 'yyyy-MM-dd_HH-mm-ss')), '[\s:]', '-'));
if isempty(timeStart) && get(handles.radiobutton_save_output,'Value') == 1

    mkdir(strcat(unkmat.path,folder));
    
    % Copy calibration.mat and hardware_parameters.mat to new folder
    copyfile(strcat(pwd,'/calibration.mat'),...
        strcat(unkmat.path,folder,'/calibration.mat'));
    copyfile(strcat(pwd,'/hardware_parameters.mat'),...
        strcat(unkmat.path,folder,'/hardware_parameters.mat'));
end

% Initialize summed data if needed
sumMode = ~isempty(handles) && get(handles.radiobutton_sum, 'value');
if sumMode
    summedData = [];
end

% Initialize timeStart with the timestamp of the first file if not in auto mode
if ~isequal(mode, 'auto') 
    timeStart = [];
end

for i = 1:length(unkmat.queue)
    % Prepare data
    [unkdata, skip] = data_prep(handles, unkmat.path, string(unkmat.queue(1,i)));
         
    % Get file info and convert timestamp to datetime
    FileInfo = dir(fullfile(unkmat.path, string(unkmat.queue(1,i))));
    timestamp = datetime(FileInfo.date, 'InputFormat', 'dd-MMM-yyyy HH:mm:ss');
    
    % Store the first timestamp
    if isempty(timeStart)
        timeStart = timestamp;
    end
    
    % Calculate elapsed time in seconds
    elapsedSec = round(seconds(timestamp - timeStart));

    % Skip processing if needed
    if skip == 1
        continue;
    end

    % If summing mode is enabled, accumulate data
    if sumMode
        if isempty(summedData)
            summedData = unkdata;
        else
            summedData = summedData + unkdata;
        end
    else
        % Process individual files normally
        fit_prep(handles, unkmat.path, folder, unkdata, calmat.cal_l, calmat.cal_r, ...
                 hp, wavelengths, elapsedSec, string(unkmat.queue(1,i)), timestamp);
    end
end

% If sum mode is enabled, run `fit_prep` once on the summed data
if sumMode && ~isempty(summedData)

    % Compute color limits safely
    maxVal = max(summedData(:));
    if maxVal == 0 || isnan(maxVal) % Prevents invalid CLim range
        clim = [0 1]; % Default safe range
    else
        clim = [0 maxVal];
    end
    
    % Plot raw image
    update_axes(handles.plot_raw, 'wavelength (nm)', 'pixels', ...
        sprintf('IMAGE: %s', 'summed data'), 'Right', 1, 0, 1, ...
        size(summedData, 2), wavelengths(1), wavelengths(end));
    
    % Use the safe color range
    imagesc(handles.plot_raw, wavelengths, 1:256, summedData(1:1024, 1:256)', clim);

    fit_prep(handles, unkmat.path, folder, summedData, calmat.cal_l, calmat.cal_r, ...
             hp, wavelengths, elapsedSec, 'summed_data', timestamp);
end

% Update button states
namesLen = length(unkmat.names);
queueLen = length(unkmat.queue);

% Define the default button state
defaultState = {2 2 1 0 2 2 2 1 2 2 2 2 2 2 2 2 2 2 2 2 2};

if namesLen > 1
    if queueLen == 1
        if strcmp(unkmat.names(1,end), unkmat.queue(1,1))
            update_button_states({2 2 1 0 2 2 2 1 2 2 2 2 2 2 2 2 2 2 2 2 2}, handles);
        elseif strcmp(unkmat.names(1,1), unkmat.queue(1,1))
            update_button_states({2 2 0 1 2 2 2 1 2 2 2 2 2 2 2 2 2 2 2 2 2}, handles);
        end
    else
        update_button_states(defaultState, handles);
    end
elseif namesLen == 1 && queueLen == 1
    update_button_states(defaultState, handles);
end

% PUSHBUTTON ROTATE ---------------------------------------------------------------------------------------------------------
function pushbutton_rotate_Callback(~, ~, handles)
rotate(handles);
    
% PUSHBUTTON CLEAR FIGURES --------------------------------------------------------------------------------------------------
function pushbutton_clear_figures_Callback(~, ~, handles)

% Find all axes in the current environment
all_axes = findall(0, 'type', 'axes');

% Exclude the axes for handles.plot_raw
axes_to_clear = setdiff(all_axes, handles.plot_raw);

% Clear the selected axes
arrayfun(@cla, axes_to_clear);

% Close all open files
fclose('all');

% Sets button and edit box state
update_button_states({2 2 2 2 2 2 2 0 2 2 2 2 2 2 2 2 2 2 2 2 2},handles)

% EXIT BUTTON ---------------------------------------------------------------------------------------------------------------
function pushbutton_quit_Callback(~, ~, ~)

% Close all open figures
close all;

% Close all open files
fclose('all');

% UPDATE HARDWARE PARAMETERS BUTTON -----------------------------------------------------------------------------------------
function pushbutton_update_hardware_parameters_Callback(~, ~, ~)
hardware_parameters

% HELPER FUNCTION: EDIT_BOX_CALLBACK ----------------------------------------------------------------------------------------
function edit_box_callback(hObject, ~, handles, lower_limit, upper_limit, load_wavelengths)
% Generic callback function for edit boxes to enforce boundary constraints
% hObject        - Handle to the edit box
% handles        - GUI handles structure
% lower_limit    - Lower boundary value
% upper_limit    - Upper boundary value
% bound_type     - 'min' or 'max' to determine comparison type
% load_wavelengths - Boolean, whether to load wavelengths from the MAT file

% Get the tag of the current edit box to detect if it is a left or right box
tag = get(hObject, 'Tag');

% Retrieve the current value entered by the user
value = str2double(get(hObject, 'String'));

if load_wavelengths
    unkmat = matfile('unknown.mat', 'Writable', true);
    lower_limit = unkmat.wavelengths(1,1);
    upper_limit = unkmat.wavelengths(1,end);
end

% Ensure the value is within the lower and upper bounds
if value < lower_limit
    value = lower_limit;  % Set to lower limit if value is too small
elseif value > upper_limit
    value = upper_limit;  % Set to upper limit if value is too large
end

% If interacting with the "left" box, ensure the value is less than the "right" box
if contains(tag, 'min')
    % Get the corresponding "right" box value
    right_tag = strrep(tag, 'min', 'max');
    right_value = str2double(get(handles.(right_tag), 'String'));
    if value >= right_value  % If value is greater than or equal to the right value
        value = lower_limit;  % Adjust to be smaller than the right value
    end
end

% If interacting with the "right" box, ensure the value is greater than the "left" box
if contains(tag, 'max')
    % Get the corresponding "left" box value
    left_tag = strrep(tag, 'max', 'min');
    left_value = str2double(get(handles.(left_tag), 'String'));
    if value <= left_value  % If value is less than or equal to the left value
        value = upper_limit;  % Adjust to be greater than the left value
    end
end

% Update the edit box with the corrected value
set(hObject, 'String', num2str(round(value)));

% Update ROI boxes if needed
ROI(handles);
