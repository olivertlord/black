function [] = fit_prep(handles, file_path, output_folder, unkdata, caldata_l, caldata_r, hp, wavelengths, elapsedSec, filename, timestamp)
% FIT_PREP Prepares and processes spectral data for fitting and analysis.
%
%   This function performs image rotation (if enabled), applies error minimization,
%   and calculates temperature and emissivity fits using Planck's law. It then 
%   updates plots and optionally saves the processed data.
%
% Inputs:
%   handles        - Structure of GUI handles.
%   file_path      - Path to the input data file.
%   output_folder  - Directory where processed data will be saved.
%   unkdata        - Measured spectral data from the unknown sample.
%   caldata_l      - Calibration data for the left region.
%   caldata_r      - Calibration data for the right region.
%   hp             - Hardware parameters, including sensor response.
%   wavelengths    - Array of wavelengths (nm).
%   i              - Current file index in the processing sequence.
%   elapsedSec     - Elapsed time in seconds since first file.
%   filename       - Name of the input data file.
%   timestamp      - Timestamp of data acquisition.
%
% Outputs:
%   - Updates the GUI with plots of spectral fits and residuals.
%   - Saves processed data if the "Save Output" option is enabled.
%
% Example:
%   fit_prep(handles, 'C:\data\', 'results', unkdata, cal_l, cal_r, hp, wavelengths, 1, 3600, 'sample.sif', now);

% Call ROI function to get values from GUI boxes
[mnll, mxll, mnlr, mxlr, mnrowl, mxrowl, mnrowr, mxrowr] = ROI(handles);

% If Auto rotate radiobutton selected, rotate image by angles saved in
% rotfile.mat
if get(handles.radiobutton_auto_rotate,'Value') == 1
            
    rots = load('rotfile.mat');
    unkl = imrotate(unkdata,-rots.tilt_L,'bicubic');
    unkr = imrotate(unkdata,-rots.tilt_R,'bicubic');
else
    [unkl,unkr]=deal(unkdata);
end

% Run error minimisation if selected
errorMinType = get(handles.popupmenu_error_min_type, 'Value');
if errorMinType > 1
    [mnll,mxll,mnlr, mxlr] = errormin(errorMinType,handles,unkl,unkr,caldata_l,caldata_r,hp,wavelengths,mnll,mxll,mnlr,mxlr,mnrowl,mxrowl,mnrowr,mxrowr);
end

% Calculate temperature Left and Right
[T_left,sigT_left,E_left,sigE_left,sr_sample_left,SSD_left,y_fit_left,~,start_pixel_left,end_pixel_left] = Temp(unkl,caldata_l,hp.sr,...
    wavelengths,mnll,mxll,mxrowl,mnrowl,handles);

[T_right,sigT_right,E_right,sigE_right,sr_sample_right,SSD_right,y_fit_right,x_fit,start_pixel_right,end_pixel_right] = Temp(unkr,caldata_r,hp.sr,...
    wavelengths,mnlr,mxlr,mxrowr,mnrowr,handles);

% Determine fit with minimum SSD left and right
[~,idxl] = min(SSD_left(:));
[~,idxr] = min(SSD_right(:));

% Convert Pixels to Microns
hp = matfile('hardware_parameters.mat','Writable',true);
resolution = hp.pixel_width / hp.magnification;

num_pixels = length(T_left); % Get the number of pixels
half_length = (num_pixels - 1) / 2; % Centered range
microns_l = (-half_length:half_length) * resolution;

num_pixels = length(T_right); % Get the number of pixels
half_length = (num_pixels - 1) / 2; % Centered range
microns_r = (-half_length:half_length) * resolution;

% Calculate stats
[maxtempl, emaxl, mintempl, eminl, meantempl, emeanl] = calc_temp_stats(T_left, sigT_left);
[maxtempr, emaxr, mintempr, eminr, meantempr, emeanr] = calc_temp_stats(T_right, sigT_right);

% Update plots
data_plot(handles, x_fit, y_fit_left, y_fit_right, sr_sample_left, sr_sample_right, idxl, idxr, start_pixel_left, end_pixel_left, start_pixel_right, end_pixel_right, ...
    mnrowl, mxrowl, mnrowr, mxrowr, microns_l, microns_r, T_left, T_right, sigT_left, sigT_right, maxtempl, mintempl, meantempl, ...
    maxtempr, mintempr, meantempr, emaxl, eminl, emeanl, emaxr, eminr, emeanr, ...
    elapsedSec)

% Save data
if get(handles.radiobutton_save_output, 'Value') == 1
data_save(filename, file_path, output_folder, x_fit, sr_sample_left, y_fit_left, sr_sample_right, y_fit_right, ...
    idxl, idxr, mnrowl, mxrowl, microns_l, T_left, sigT_left, E_left, sigE_left, ...
    mnrowr, mxrowr, microns_r, T_right, sigT_right, E_right, sigE_right, timestamp, ...
    elapsedSec, maxtempl, emaxl, mintempl, eminl, meantempl, ...
    emeanl, maxtempr, emaxr, mintempr, eminr, meantempr, emeanr)
end
end