function rotate(handles)

[~, ~, ~, ~, mnrowl, mxrowl, mnrowr, mxrowr] = ROI(handles);
% Get GUI box values

% Load MAT files
calmat = matfile('calibration.mat', 'Writable', true);
unkmat = matfile('unknown.mat', 'Writable', true);
hp = matfile('hardware_parameters.mat', 'Writable', true);

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
plot_axes(handles, 'plot_emin_left', 'pixels', 'pixels', 'Slope', 'Right', 1, 1);
ylim([min(peak_l) - 1, max(peak_l) + 1]);
xlim([lpixl, hpixl]);

% Plot right ROI results
axes(handles.plot_emin_right);
plot(lpixr:hpixr, peak_r(lpixr:hpixr), 'bo', 1:1024, polyval(strike_R, 1:1024), 'r-');
plot_axes(handles, 'plot_emin_right', 'pixels', 'pixels', 'Slope', 'Right', 1, 1);
ylim([min(peak_r) - 1, max(peak_r) + 1]);
xlim([lpixr, hpixr]);

% Set "rotate" radiobutton to on
set(handles.radiobutton_auto_rotate, 'Value', 1);

% Pause to allow user to see results
pause(2);

% Run Tcalc with required parameters
Tcalc(handles, unkdata, calmat.cal_l, calmat.cal_r, hp, unkmat.wavelengths, 1);
end