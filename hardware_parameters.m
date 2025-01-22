function varargout = hardware_parameters(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name', mfilename, ...
                   'gui_Singleton', gui_Singleton, ...
                   'gui_OpeningFcn', @hardware_parameters_OpeningFcn, ...
                   'gui_OutputFcn', @hardware_parameters_OutputFcn, ...
                   'gui_LayoutFcn', [], ...
                   'gui_Callback', []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before hardware_parameters is made visible.
function hardware_parameters_OpeningFcn(hObject, ~, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

% Load current hardware_parameters
m = matfile('hardware_parameters.mat', 'Writable', true);
fields = {'conp', 'pix1', 'pix2', 'conl', 'lam1', 'lam2', 'row', 'col'};
editHandles = [handles.edit3, handles.edit4, handles.edit5, ...
               handles.edit0, handles.edit1, handles.edit2, ...
               handles.edit6, handles.edit7];
for i = 1:numel(fields)
    set(editHandles(i), 'String', num2str(m.(fields{i})));
end

% --- Outputs from this function are returned to the command line.
function varargout = hardware_parameters_OutputFcn(~, ~, handles)
varargout{1} = handles.output;

% --- Checks that entered data is numeric.
function check_numeric(box)
str = get(box, 'String');
if isnan(str2double(str))
    set(box, 'String', '0');
    warndlg('Input must be numerical');
end

% --- Executes on button press to save changes.
function pushbutton1_Callback(~, ~, handles)
m = matfile('hardware_parameters.mat', 'Writable', true);
fields = {'conp', 'pix1', 'pix2', 'conl', 'lam1', 'lam2', 'row', 'col'};
editHandles = [handles.edit3, handles.edit4, handles.edit5, ...
               handles.edit0, handles.edit1, handles.edit2, ...
               handles.edit6, handles.edit7];
for i = 1:numel(fields)
    m.(fields{i}) = str2double(get(editHandles(i), 'String'));
end
close;

% --- create function for all edit boxes.
function edit0_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject, 'BackgroundColor'), get(0, 'defaultUicontrolBackgroundColor'))
    set(hObject, 'BackgroundColor', 'white');
end

function edit1_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject, 'BackgroundColor'), get(0, 'defaultUicontrolBackgroundColor'))
    set(hObject, 'BackgroundColor', 'white');
end

function edit2_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject, 'BackgroundColor'), get(0, 'defaultUicontrolBackgroundColor'))
    set(hObject, 'BackgroundColor', 'white');
end

function edit3_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject, 'BackgroundColor'), get(0, 'defaultUicontrolBackgroundColor'))
    set(hObject, 'BackgroundColor', 'white');
end

function edit4_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject, 'BackgroundColor'), get(0, 'defaultUicontrolBackgroundColor'))
    set(hObject, 'BackgroundColor', 'white');
end

function edit5_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject, 'BackgroundColor'), get(0, 'defaultUicontrolBackgroundColor'))
    set(hObject, 'BackgroundColor', 'white');
end

function edit6_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject, 'BackgroundColor'), get(0, 'defaultUicontrolBackgroundColor'))
    set(hObject, 'BackgroundColor', 'white');
end

function edit7_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject, 'BackgroundColor'), get(0, 'defaultUicontrolBackgroundColor'))
    set(hObject, 'BackgroundColor', 'white');
end

% --- Callback functions for all edit boxes to check numeric input.
function edit0_Callback(hObject, ~, ~)
check_numeric(hObject);

function edit1_Callback(hObject, ~, ~)
check_numeric(hObject);

function edit2_Callback(hObject, ~, ~)
check_numeric(hObject);

function edit3_Callback(hObject, ~, ~)
check_numeric(hObject);

function edit4_Callback(hObject, ~, ~)
check_numeric(hObject);

function edit5_Callback(hObject, ~, ~)
check_numeric(hObject);

function edit6_Callback(hObject, ~, ~)
check_numeric(hObject);

function edit7_Callback(hObject, ~, ~)
check_numeric(hObject);
