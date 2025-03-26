function [unkdata, skip] = data_prep(handles, upath, filename)
% DATA_PREP Reads, processes, and prepares spectral data for analysis.
%
%   This function reads an unknown data file (.sif or .spe), processes it by handling
%   background subtraction, saturation correction, binning, emissivity correction, and
%   smoothing. The processed data is then visualized in the GUI.
%
% Inputs:
%   handles   - Structure containing handles to GUI components.
%   upath     - Path to the directory containing the unknown data file.
%   filename  - Name of the file to be processed.
%
% Outputs:
%   unkdata   - Processed 2D data matrix containing spectral intensity values.
%   skip      - Boolean flag (true if the data is empty after processing, false otherwise).
%
% Processing Steps:
%   1. **Read File**: Determines file type (.sif or .spe) and reads data accordingly.
%   2. **Saturation Correction**: Replaces saturated pixels with NaN.
%   3. **Edge Artefact Removal** (for .spe files): Discards pixels in the first and last 5 columns.
%   4. **Binned Data Handling**: Expands binned data to match expected dimensions.
%   5. **Background Subtraction** (if enabled): Loads and subtracts background data.
%   6. **Emissivity Correction** (if enabled): Applies W emissivity correction to spectral data.
%   7. **Smoothing**: Applies convolution-based smoothing to reduce noise.
%   8. **Visualization**: Updates GUI and plots the processed image.
%
% Example:
%   [data, skip] = data_prep(handles, 'C:\Data\', 'measurement.sif');

% Load hardware parameters
hp = matfile('hardware_parameters.mat', 'Writable', true);

% Set GUI filename display
set(handles.edit_filename, 'string', filename);

% Initialize wavelengths
wavelengths = [];

% Determine file type and read data
if contains(filename, 'sif')

    [unkdata, wavelengths] = sifreader(char(fullfile(upath, filename)));

    % Remove saturated pixels
    unkdata(unkdata > 64000) = NaN;

elseif contains(filename, 'spe')

    fid = fopen(fullfile(upath, filename), 'r');
    unkdata = fread(fid, [hp.col, hp.row], 'real*4', 'l');
    fclose(fid);
    
    % Remove saturated pixels
    unkdata(unkdata > 8.4077e-41) = NaN;

    % Remove edge artefacts
    unkdata([1:5, hp.col-4:hp.col], :) = NaN;
end

% Handle binned data workaround
if size(unkdata, 2) < 256
    binned = unkdata(:, contains(filename, 'sif') + 1);
    unkdata = padarray(binned, [0, 255], 'replicate', 'post');
end

% Subtract background if radiobutton is enabled
if get(handles.radiobutton_subtract_background, 'value')
    
    % Load background data into memory
    bakmat = matfile('background.mat', 'Writable', true);
    backgroundData = bakmat.background; % Load the variable
    
    % Apply thresholding
    backgroundData(backgroundData > 64000) = NaN; 

    % Scale background
    backgroundData(1,256)
    unkdata(1,256)
    background_scaling = unkdata(1,256) / backgroundData(1,256)
    backgroundData = backgroundData .* background_scaling;
    backgroundData(1,256)
    
    % Save modified data back to the .mat file
    bakmat.background = backgroundData;
    
    if size(bakmat.background, 2) < 256
        binned = bakmat.background(:, 1);
        bakmat.background = padarray(binned, [0, 255], 'replicate', 'post');
    end

    unkdata = unkdata - bakmat.background;

    unkdata(1,256)

end

% Apply W emissivity correction if radiobutton is enabled
if get(handles.radiobutton_W_emissivity, 'value')
    col = size(unkdata, 1);
    w = linspace(wavelengths(1), wavelengths(end), col);
    E = 0.53003 - 0.000136 * w;
    unkdata = bsxfun(@rdivide, unkdata, E(:));
end

% Flip image if radiobutton enabled
if get(handles.radiobutton_flip_image, 'value')
    unkdata = fliplr(unkdata);
end

% Check if data is empty after desaturation
skip = isnan(max(unkdata(:)));

% Apply smoothing
smooth = ceil(get(handles.slider_smooth, 'Value'));
unkdata = conv2(unkdata, ones(smooth, 1), 'same');
set(handles.text_smooth, 'String', num2str(smooth));

% Compute color limits safely
maxVal = max(unkdata(:));
if maxVal == 0 || isnan(maxVal) % Prevents invalid CLim range
    clim = [0 1]; % Default safe range
else
    clim = [0 maxVal];
end

% Plot raw image
update_axes(handles.plot_raw, 'wavelength (nm)', 'pixels', ...
    sprintf('IMAGE: %s', filename), 'Right', 1, 0, 1, ...
    size(unkdata, 2), wavelengths(1), wavelengths(end));

% Use the safe color range
imagesc(handles.plot_raw, wavelengths, 1:256, unkdata(1:1024, 1:256)', clim);
end