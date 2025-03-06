function [T, sigT, E, sigE, SSD, y_fit] = planck(c1, c2, wavelengths, intensities)
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

% Convert wavelengths from nm to m
wavelengths_cm = wavelengths * 1e-7;

% Define Planck's Law for fitting
planck_model = @(x, l) (l.^-5 * c1 *x(1)) ./(exp(c2*1e-7 ./(l *x(2)) ) -1);

% Initial guess: [Emissivity ~ 0.9, Temperature ~ 2000K]
beta0 = [0.01, 3000];

% Fitting options
options = optimoptions('lsqcurvefit', 'DiffMinChange', 1e-10, 'DiffMaxChange', 1e-2, 'StepTolerance', 1e-8, 'Display', 'off');      

% Perform nonlinear least squares fitting
[params, resnorm, resids, ~, ~, ~, jacobian] = lsqcurvefit(planck_model, beta0, wavelengths_cm, double(intensities), [], [], [],...
    [], [], [], [], options);

% Extract fitted parameters
E = params(1);  % Emissivity
T = params(2);  % Temperature (K)

% Compute the covariance matrix
J = full(jacobian);  % Ensure it's not sparse
cov_matrix = inv(J' * J) * resnorm / (length(double(intensities)) - length(params));

% Compute confidence intervals for uncertainties
param_uncertainties = sqrt(diag(cov_matrix));
sigE = param_uncertainties(1);  % Uncertainty in emissivity
sigT = param_uncertainties(2);  % Uncertainty in temperature

% Determine average mismatch
SSD=norm(resids,2)^2;

% Compute fitted intensities using optimized parameters
y_fit = planck_model(params, wavelengths_cm);

end