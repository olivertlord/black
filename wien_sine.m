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

% Define model for fitting
wien_sine_model = @(b,x)(b(1) + b(2)*x + b(3)*sin(2*pi*(x-b(4))/b(5)));

% Initial guess parameters
beta0 = [79.5 -.0008 .3 1600 1200];

% Perform nonlinear least squares fitting
[x_fit, resids, J] = nlinfit(wavelengths, intensities, wien_sine_model, beta0);

% Extract fitted parameters
E = x_fit(1);  % Emissivity
T = x_fit(2);  % Temperature (K)

% Compute confidence intervals for uncertainties
ci = nlparci(x_fit, resids, J);
sigE = (ci(1,2) - ci(1,1)) / 2;  % Uncertainty in emissivity
sigT = (ci(2,2) - ci(2,1)) / 2;  % Uncertainty in temperature

% Determine average mismatch
SSD=norm(resids,2)^2;

% Compute fitted intensities using optimized parameters
y_fit = planck_model(x_fit, wavelengths_m);
end