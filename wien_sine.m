function [T, sigT, E, sigE, SSD, y_fit] = wien_sine(wavelengths, intensities)
% ESTIMATE_TEMP_EMISSIVITY estimates temperature and emissivity from spectral data.
%
% INPUTS:
%   wavelengths - Vector of wavelengths in nanometers (nm)
%   intensities - Vector of measured spectral intensities (same size as wavelengths)
%
% OUTPUTS:
%   T    - Estimated temperature (Kelvin)
%   sigT - Uncertainty in temperature (Kelvin)
%   E    - Estimated emissivity
%   sigE - Uncertainty in emissivity


% First do a standard Wien fit
[~, ~, ~, ~, ~, y_fit] = wien(wavelengths, intensities);

% Determine the residuals
residuals = intensities(:) - y_fit(:);

% Smooth the residuals
residuals_smoothed = sgolayfilt(double(residuals), 3, 51);

% Remove the low frequency noise from the data
intensities = intensities - residuals_smoothed;

% Repeat the Wien fit
[T, sigT, E, sigE, SSD, y_fit] = wien(wavelengths, intensities);

y_fit = y_fit + residuals_smoothed';

%y_fit = y_fit + residuals_smoothed

end