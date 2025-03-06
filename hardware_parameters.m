function varargout = hardware_parameters(varargin)
% HARDWARE_PARAMETERS GUI for viewing and modifying hardware settings.
%
% This function initializes a MATLAB GUI for modifying hardware parameters
% stored in 'hardware_parameters.mat'. The GUI allows users to input 
% numerical values, validates the inputs, and saves changes to the file.
%
% Usage:
%   hardware_parameters() - Opens the GUI for hardware parameters.
%
% Outputs:
%   varargout - Handles to the GUI figure.
%
% Example:
%   hardware_parameters;
%
% GUI Elements:
%   - Editable fields for hardware parameters:
%       conp, pix1, pix2, conl, lam1, lam2, row, col
%   - Save button to store modified parameters.
%
% Dependencies:
%   - Requires 'hardware_parameters.mat' to exist in the working directory.
%
% Author:
%   Original Code: [Your Name]  
%   Updated: [Date]

% GUIDE GENERATED INITIALIZATION CODE ---------------------------------------------------------------------------------------
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

% GUIDE GENERATED CREATE FUNCTIONS FOR GUI ELEMENTS -------------------------------------------------------------------------
function edit0_CreateFcn(~, ~, ~)
function edit1_CreateFcn(~, ~, ~)
function edit2_CreateFcn(~, ~, ~)
function edit3_CreateFcn(~, ~, ~)
function edit4_CreateFcn(~, ~, ~)
function edit5_CreateFcn(~, ~, ~)
function edit6_CreateFcn(~, ~, ~)
function edit7_CreateFcn(~, ~, ~)

% OPENING FUNCTION ----------------------------------------------------------------------------------------------------------
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

% OUTPUT FUNCTION -----------------------------------------------------------------------------------------------------------
function varargout = hardware_parameters_OutputFcn(~, ~, handles)
varargout{1} = handles.output;

% EDIT BOX CALLBACKS --------------------------------------------------------------------------------------------------------
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

% PUSHBUTTON SAVE -----------------------------------------------------------------------------------------------------------
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

% HELPER FUNCTION: CHECK_NUMERIC --------------------------------------------------------------------------------------------
function check_numeric(box)
str = get(box, 'String');
if isnan(str2double(str))
    set(box, 'String', '0');
    warndlg('Input must be numerical');
end