function [T,sigT,E,sigE,sr_sample,SSD,y_fit,x,start_column,end_column] = Temp(unkdata,caldata,sr_lamp,wavelengths,mnl,mxl,mxrow,mnrow,handles)
% TEMP Estimates temperature, emissivity, and fit quality from spectral data.
%
% This function processes spectral data to estimate temperature (T) and 
% emissivity (E) by performing a Wien, Wien + Sine, or Planck fit. It also 
% computes confidence intervals, residuals, and fit quality using sum-squared 
% differences (SSD).
%
% INPUT:
%   unkdata    - 2D array, measured spectral data from the unknown sample.
%   caldata    - 2D array, reference calibration data.
%   sr         - 1D array, system response function.
%   w          - 1D array, wavelength values.
%   mnl, mxl   - Scalars, min/max wavelengths for fitting.
%   mxrow, mnrow - Scalars, pixel range for the region of interest.
%   handles    - GUI handles structure (used to determine fit type).
%
% OUTPUT:
%   T          - 1D array, estimated temperatures for each pixel.
%   sigT       - 1D array, uncertainty in estimated temperatures.
%   E          - 1D array, estimated emissivities.
%   sigE       - 1D array, uncertainty in emissivities.
%   J          - 2D array, normalized intensity log values for fitting.
%   SSD        - 1D array, sum-squared differences of the fit residuals.
%   fit        - 2D array, modeled intensity values from the fit.
%   start_pixel, end_pixel - Scalars, pixel indices corresponding to mnl/mxl.
%
% FUNCTIONALITY:
% - Maps unknown and calibration spectra onto the CCD image.
% - Performs system response correction and normalizes intensities.
% - Selects the fit type (Wien, Wien + Sine, or Planck) based on GUI input.
% - Uses linear or nonlinear regression to estimate T and E.
% - Computes fit confidence intervals and residuals.
% - Applies temperature correction if enabled.
%
% EXAMPLE USAGE:
%   [T, sigT, E, sigE, J, SSD, fit, sp, ep] = Temp(unkdata, caldata, sr, w, 500, 700, 256, 128, handles, nw, c1);

% Create arrays for left and right ROIs mapped onto unknown CCD image
unk = unkdata(1:length(wavelengths),mnrow:mxrow);

% Create arrays for left and right ROIs mapped onto calibration CCD image
cal = caldata(1:length(wavelengths),mnrow:mxrow);

% Calculate the pixel limits for fitting
[~,start_column]=min(abs(wavelengths-mnl));
[~,end_column]=min(abs(wavelengths-mxl));

% Calculate the spectral radiance of the sample
sr_lamp = repmat(sr_lamp, size(unk, 2), 1);
sr_sample = (unk./cal).*sr_lamp';

% Constants (in CGS units)
h = 6.6261e-34; % Planck's constant (J·s)
c = 2.9979e8;  % Speed of light (m/s)
k = 1.3807e-23; % Boltzmann's constant (J/K)

% Compute c1 in W·m²
c1 = 2 * h * c^2 * pi * 1e4;

% Compute c2 in nm·K 
c2 = h * c / k * 1e9;

% Preallocate output variables
numRows = size(sr_sample, 2);
[T, sigT, E, sigE, SSD] = deal(zeros(1, numRows));
y_fit = zeros(length(start_column:end_column), numRows);

% If Wien fit is selected from drop-down menu
if get(handles.popupmenu_fit_type,'Value') == 1

    % Normalize wavelengths for Wien fitting
    x = c2./wavelengths';
    
    % Normalise the spectral radiance of the sample for Wien fitting
    sr_sample=log(sr_sample.*wavelengths'.^5/c1);
    sr_sample=real(sr_sample);
    sr_sample(sr_sample==-Inf)=NaN;

    for i=1:numRows

        [T(i), sigT(i), E(i), sigE(i), SSD(i), y_fit(:,i)] = wien(x(start_column:end_column)',sr_sample(start_column:end_column,i));
        
    end
    
% If Wien + Sine is selected from the drop-down menu
elseif get(handles.popupmenu_fit_type,'Value') == 2

    % Normalize wavelengths for Wien fitting
    x = c2./wavelengths';
    
    % Normalise the spectral radiance of the sample for Wien fitting
    sr_sample=log(sr_sample.*wavelengths'.^5/c1);
    sr_sample=real(sr_sample);
    sr_sample(sr_sample==-Inf)=NaN;
    
    for i=1:numRows
        
        [T(i), sigT(i), E(i), sigE(i), SSD(i), y_fit(:,i)] = wien_sine(x(start_column:end_column)',sr_sample(start_column:end_column,i));

    end

% If Planck is selected from the drop-down menu
else
    for i=1:numRows
        
        x = wavelengths';

        [T(i), sigT(i), E(i), sigE(i), SSD(i), y_fit(:,i)] = planck(c1, c2, wavelengths(start_column:end_column)',sr_sample(start_column:end_column,i));

    end
end
    
% If T correction radiobutton selected
if get(handles.radiobutton_T_correction,'Value') == 1

    for i=1:numRows
        % Determine corrected temperature based on Walter & Koga (2004)
        T(i)=T(i) - (-0.0216*(sigT(i)*sigT(i))+17.882*sigT(i)); 
    end
end
end