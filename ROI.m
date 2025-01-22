function [mnll, mxll, mnlr, mxlr, mnrowl, mxrowl, mnrowr, mxrowr] = ROI(handles)

% Remove existing ROI rectangles
ROIs = findobj(handles.plot_raw, 'Type', 'hggroup', 'Tag', 'imrect');
delete(ROIs);

% Load the unknown matfile
unkmat = matfile('unknown.mat', 'Writable', true);

% Get wavelengths from 'unknown.mat' or 'hardware_parameters.mat'
if any(contains(cellstr(unkmat.names(1, :)), 'sif'))
    wavelengths = unkmat.wavelengths;
elseif any(contains(cellstr(unkmat.names(1, :)), 'spe'))
    hp = matfile('hardware_parameters.mat', 'Writable', true);
    wavelengths = hp.w;
else
    error('Unable to find valid wavelength data in both files.');
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

% Create ROIs on the plot
ROI_l = imrect(handles.plot_raw, [mnll mnrowl mxll - mnll mxrowl - mnrowl]);
ROI_r = imrect(handles.plot_raw, [mnlr mnrowr mxlr - mnlr mxrowr - mnrowr]);

% Define position callback function for ROIs
addNewPositionCallback(ROI_l, @update_ROI_pos);
fcn_l = makeConstrainToRectFcn('imrect', [wavelengths(1) wavelengths(end)], [128 256]);
setPositionConstraintFcn(ROI_l, fcn_l);

addNewPositionCallback(ROI_r, @update_ROI_pos);
fcn_r = makeConstrainToRectFcn('imrect', [wavelengths(1) wavelengths(end)], [1 127]);
setPositionConstraintFcn(ROI_r, fcn_r);

end