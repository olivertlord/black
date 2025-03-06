function [mnll, mxll, mnlr, mxlr, mnrowl, mxrowl, mnrowr, mxrowr] = ROI(handles)
% ROI Creates and manages ROI (Region of Interest) rectangles on a plot.
%
% This function removes any existing ROI rectangles on the specified plot and 
% creates new ones based on the wavelength and pixel boundaries defined by the GUI.
% It also sets up event listeners to update the GUI when the user moves an ROI.
%
% Inputs:
%   handles - Structure containing GUI handles, including the axes for plotting.
%
% Outputs:
%   mnll  - Minimum wavelength for the left ROI.
%   mxll  - Maximum wavelength for the left ROI.
%   mnlr  - Minimum wavelength for the right ROI.
%   mxlr  - Maximum wavelength for the right ROI.
%   mnrowl - Minimum row (pixel) for the left ROI.
%   mxrowl - Maximum row (pixel) for the left ROI.
%   mnrowr - Minimum row (pixel) for the right ROI.
%   mxrowr - Maximum row (pixel) for the right ROI.
%
% Functionality:
% - Loads wavelength data from 'unknown.mat' or 'hardware_parameters.mat'.
% - Retrieves min/max wavelength and pixel values from the GUI input fields.
% - Creates and positions two ROI rectangles (left and right) on the plot.
% - Adds event listeners to update ROI positions dynamically when moved.
% - Constrains ROIs to predefined drawing areas.

% Remove existing ROI rectangles
existingROIs = findobj(handles.plot_raw, 'Type', 'images.roi.Rectangle');
delete(existingROIs);

% Load the unknown matfile
unkmat = matfile('unknown.mat', 'Writable', true);

% Get wavelengths from 'unknown.mat' or 'hardware_parameters.mat'
if any(contains(cellstr(unkmat.queue(1, :)), 'sif'))
    wavelengths = unkmat.wavelengths;
elseif any(contains(cellstr(unkmat.queue(1, :)), 'spe'))
    hp = matfile('hardware_parameters.mat', 'Writable', true);
    wavelengths = hp.w;
end

% Get values from UI controls and convert to numbers
mnll = str2double(get(handles.edit_wavelength_min_left, 'string'));
mxll = str2double(get(handles.edit_wavelength_max_left, 'string'));
mnrowl = str2double(get(handles.edit_ROI_min_left, 'string'));
mxrowl = str2double(get(handles.edit_ROI_max_left, 'string'));

mnlr = str2double(get(handles.edit_wavelength_min_right, 'string'));
mxlr = str2double(get(handles.edit_wavelength_max_right, 'string'));
mnrowr = str2double(get(handles.edit_ROI_min_right, 'string'));
mxrowr = str2double(get(handles.edit_ROI_max_right, 'string'));

% Create ROIs
ROI_l = drawrectangle(handles.plot_raw, 'Position', [mnll, mnrowl, mxll - mnll, mxrowl - mnrowl], ...
    'Color', 'r');
ROI_r = drawrectangle(handles.plot_raw, 'Position', [mnlr, mnrowr, mxlr - mnlr, mxrowr - mnrowr], ...
    'Color', 'g');

% Define position callback function for ROIs
addlistener(ROI_l, 'MovingROI', @(src, evt) update_ROI_pos(src.Position, handles));
addlistener(ROI_r, 'MovingROI', @(src, evt) update_ROI_pos(src.Position, handles));

% Set position constraints for ROIs
ROI_l.DrawingArea = [wavelengths(1), 128, wavelengths(end) - wavelengths(1), 256 - 128];
ROI_r.DrawingArea = [wavelengths(1), 1, wavelengths(end) - wavelengths(1), 127 - 1];

end

function update_ROI_pos(ROI_pos, handles)
% UPDATE_ROI_POS Updates the GUI text boxes with the new ROI position values.
%
% This function is triggered when the user moves an ROI (Region of Interest) 
% rectangle. It determines whether the ROI belongs to the left or right 
% region based on the y-coordinate and updates the corresponding GUI fields.
%
% Inputs:
%   ROI_pos - A 1x4 numeric array representing the ROI position:
%             [xMin, yMin, width, height].
%   handles - Structure containing GUI handles for updating the UI elements.
%
% Functionality:
% - Determines whether the ROI is in the left or right section based on the y-coordinate.
% - Rounds the new ROI position values.
% - Updates the corresponding text boxes for min/max wavelength and pixel positions.

% Determine if the ROI is on the left or right based on the y-coordinate
isLeft = ROI_pos(2) > 127;

% Select appropriate handle suffixes for left or right ROI
side = 'left';
if ~isLeft
    side = 'right';
end

% Precompute rounded ROI position values
yMin = round(ROI_pos(2));
yMax = yMin + round(ROI_pos(4));
xMin = round(ROI_pos(1));
xMax = xMin + round(ROI_pos(3));

% Update ROI min/max text boxes
set(handles.(['edit_ROI_min_' side]), 'string', num2str(yMin));
set(handles.(['edit_ROI_max_' side]), 'string', num2str(yMax));

% Update wavelength min/max text boxes
set(handles.(['edit_wavelength_min_' side]), 'string', num2str(xMin));
set(handles.(['edit_wavelength_max_' side]), 'string', num2str(xMax));

end