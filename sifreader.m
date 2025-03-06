function [newdata, calibvals] = sifreader(filename)
% SIFREADER Reads SIF files from Andor cameras and extracts pixel data and calibration values.
%
% This function loads an Andor SIF file, extracts pixel data, and retrieves calibration 
% values if applicable. It supports both spectral and image readout patterns.
%
% INPUT:
%   filename    - String, full path to the SIF file.
%
% OUTPUT:
%   newdata     - 2D array of pixel data (empty if the file does not contain image data).
%   calibvals   - Array of calibration values for each pixel (empty if not applicable).
%
% FUNCTIONALITY:
% - Reads an Andor SIF file using Andor SDK functions.
% - Checks if the file contains valid data.
% - Determines the readout pattern (spectral or image).
% - Extracts and reshapes image data if applicable.
% - Retrieves pixel calibration values when available.
% - Closes the file after reading.
%
% EXAMPLE USAGE:
%   [imageData, calibrationValues] = sifreader('sample.sif');

% Initialize outputs
newdata = [];
calibvals = [];

% Attempt to read the file
rc = atsif_readfromfile(filename);

% Check if the file was successfully read
if rc ~= 22002
    disp('Could not load file. ERROR - ');
    disp(rc);
    return;
end

% Check if the signal source is present
signal = 0; % Assuming signal = 0 represents the source
[~, present] = atsif_isdatasourcepresent(signal);
if ~present
    disp('No data source present in the file.');
    atsif_closefile;
    return;
end

% Get the number of frames in the file
[~, no_frames] = atsif_getnumberframes(signal);
if no_frames <= 0
    disp('No frames available in the file.');
    atsif_closefile;
    return;
end

% Get the size of each frame
[~, size] = atsif_getframesize(signal);

% Extract sub-image information
[~, left, bottom, right, top, hBin, vBin] = atsif_getsubimageinfo(signal, 0);

% Read the first frame
[~, data] = atsif_getframe(signal, 0, size);

% Check the readout pattern
[~, pattern] = atsif_getpropertyvalue(signal, 'ReadPattern');

if pattern == '0' % Spectrum data
    % Extract axis information
    [~, xtype] = atsif_getpropertyvalue(signal, 'XAxisType');
    [~, xunit] = atsif_getpropertyvalue(signal, 'XAxisUnit');
    [~, ytype] = atsif_getpropertyvalue(signal, 'YAxisType');
    [~, yunit] = atsif_getpropertyvalue(signal, 'YAxisUnit');
    
    % Label axes (assumes this is for plotting)
    xlabel({xtype; xunit});
    ylabel({ytype; yunit});
    
elseif pattern == '4' % Image data
    % Compute image dimensions
    width = ((right - left) + 1) / hBin;
    height = ((top - bottom) + 1) / vBin;
    
    % Reshape data into a 2D image
    newdata = reshape(data, width, height);
    
    % Preallocate calibration values
    calibvals = zeros(1, width);
    
    % Calculate calibration values for each pixel
    for i = 1:width
        [~, calibvals(i)] = atsif_getpixelcalibration(signal, 0, i);
    end
else
    disp('Unsupported readout pattern.');
end

% Close the file
atsif_closefile;
end