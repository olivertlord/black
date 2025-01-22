function [unkdata, skip] = data_prep(handles, upath, filename, i)
% Prepare data for analysis by reading and processing unknown data files.

% Load hardware parameters
hp = matfile('hardware_parameters.mat', 'Writable', true);

% Set GUI filename display
set(handles.edit_filename, 'string', filename);

% Initialize wavelengths
wavelengths = [];

% Determine file type and read data
if contains(filename, 'sif')
    [unkdata, wavelengths] = sifreader(fullfile(upath, filename));
    % Remove saturated pixels
    unkdata(unkdata > 64000) = NaN;
elseif contains(filename, 'spe')
    fid = fopen(fullfile(upath, filename), 'r');
    unkdata = fread(fid, [hp.col, hp.row], 'real*4', 'l');
    fclose(fid);
    
    % Remove edge artifacts and saturated pixels
    unkdata([1:5, hp.col-4:hp.col], :) = NaN;
    unkdata(unkdata > 8.4077e-41) = NaN;
end

% Handle binned data workaround
if size(unkdata, 2) < 256
    binned = unkdata(:, contains(filename, 'sif') + 1);
    unkdata = padarray(binned, [0, 255], 'replicate', 'post');
end

% Subtract background if radiobutton is enabled
if get(handles.radiobutton_subtract_background, 'value')
    backdata = getappdata(0, 'backdata');
    backdata(backdata > 64000) = NaN;
    
    if size(backdata, 2) < 256
        binned = backdata(:, 1);
        backdata = padarray(binned, [0, 255], 'replicate', 'post');
    end
    unkdata = unkdata - backdata;
end

% Apply W emissivity correction if radiobutton is enabled
if get(handles.radiobutton_W_emissivity, 'value')
    col = size(unkdata, 1);
    w = linspace(wavelengths(1), wavelengths(end), col); % Assuming wavelengths are provided
    E = 0.53003 - 0.000136 * w;
    unkdata = bsxfun(@rdivide, unkdata, E(:));
end

% Check if data is empty after desaturation
skip = isnan(max(unkdata(:)));

% Apply smoothing
smooth = ceil(get(handles.slider_smooth, 'Value'));
unkdata = conv2(unkdata, ones(smooth, 1), 'same');
set(handles.text_smooth, 'String', num2str(smooth));

% Sum multiple data files if enabled
if get(handles.radiobutton_sum, 'value')
    sum_store = getappdata(0, 'sum_store');
    sum_store(:, :, i) = unkdata;
    setappdata(0, 'sum_store', sum_store);
    unkdata = sum(sum_store, 3);
end

% Plot raw image
axes(handles.plot_raw);
imagesc(wavelengths, 1:256, unkdata(1:1024, 1:256)', [0 max(unkdata(:))]);
plot_axes(handles, 'plot_raw', 'wavelength (nm)', 'pixels', ...
    sprintf('RAW CCD IMAGE: %s', filename), 'Right', 1, 0, 1, ...
    size(unkdata, 2), wavelengths(1), wavelengths(end));

end