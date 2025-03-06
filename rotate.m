function rotate(handles)
% ROTATE Computes tilt angles of the left and right regions and updates plots.
%
% This function calculates the tilt angles of the left and right regions of an image
% using spline interpolation and linear fitting. The computed angles are saved in 
% 'rotfile.mat' for later use.
%
% Inputs:
%   handles - Structure containing GUI handles for accessing plot elements.
%
% Functionality:
% - Extracts ROI (Region of Interest) boundaries from GUI fields.
% - Loads calibration, hardware parameters, and unknown data from .MAT files.
% - Removes saturated pixels from the image.
% - Performs spline interpolation on left and right ROI pixel columns.
% - Identifies peak intensity positions for both regions.
% - Fits a linear regression to the extracted peaks.
% - Computes tilt angles using the arctangent of the fitted slopes.
% - Saves computed tilt angles to a .MAT file.
% - Updates GUI plots with detected peak positions and fitted slopes.
%
% Output:
% - Saves computed tilt angles ('tilt_L', 'tilt_R') to 'rotfile.mat'.
% - Updates the plots in the GUI for visualization.

% Get GUI box values
[~, ~, ~, ~, mnrowl, mxrowl, mnrowr, mxrowr] = ROI(handles);

% Load MAT files
unkmat = matfile('unknown.mat', 'Writable', true);

% Get current filename and data
unkdata = unkmat.unk;

% Remove saturated pixels
unkdata(unkdata > 64000) = NaN;

% Initialize pixel limits
lpixl = 1;
hpixl = 1024;
lpixr = 1;
hpixr = 1024;

% Initialize variables
peak_l = NaN(1, 1024);
peak_r = NaN(1, 1024);

% Process left pixels
for i = 1:1024
    spline_L = spline(mnrowl:mxrowl, unkdata(i, mnrowl:mxrowl), mnrowl:0.01:mxrowl);
    [~, pos] = max(spline_L);
    peak_l(i) = mnrowl + 0.01 * pos;
end

% Process right pixels
for i = 1:1024
    spline_R = spline(mnrowr:mxrowr, unkdata(i, mnrowr:mxrowr), mnrowr:0.01:mxrowr);
    [~, pos] = max(spline_R);
    peak_r(i) = mnrowr + 0.01 * pos;
end

% Remove peaks outside ROI
peak_l(peak_l < mnrowl) = NaN;
peak_r(peak_r < mnrowr) = NaN;

% Linear fit to determine tilt
strike_L = polyfit(lpixl:hpixl, peak_l(lpixl:hpixl), 1);
strike_R = polyfit(lpixr:hpixr, peak_r(lpixr:hpixr), 1);

% Convert slope to tilt angle
tilt_L = atand(strike_L(1));
tilt_R = atand(strike_R(1));

% Save tilt angles to .MAT file
save('rotfile.mat', 'tilt_L', 'tilt_R');

% Plot left ROI results
axes(handles.plot_emin_left);
plot(lpixl:hpixl, peak_l(lpixl:hpixl), 'bo', 1:1024, polyval(strike_L, 1:1024), 'r-');
update_axes(handles.plot_emin_left, 'pixels', '', 'Slope', 'Right', 1, 1);
ylim([min(peak_l) - 1, max(peak_l) + 1]);
xlim([lpixl, hpixl]);

% Plot right ROI results
axes(handles.plot_emin_right);
plot(lpixr:hpixr, peak_r(lpixr:hpixr), 'bo', 1:1024, polyval(strike_R, 1:1024), 'r-');
update_axes(handles.plot_emin_right, 'pixels', 'pixels', 'Slope', 'Right', 1, 1);
ylim([min(peak_r) - 1, max(peak_r) + 1]);
xlim([lpixr, hpixr]);