function [T, sigT, E, sigE, SSD, y_fit] = wien(nw, sr_sample_normalised)
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

% Creates matrix of X values for fitting
nwf=vertcat(nw,ones(size(nw)))';

% Perform fit
[params,bint,resids]=regress(sr_sample_normalised,nwf);

% Extract fitted parameters
E = params(2);  % Emissivity
T = real((-1/params(1)));  % Temperature (K)

% Compute confidence intervals for uncertainties
sigE=abs(E-bint(2));
sigT=abs(T-(-1/(bint(1))));

% Determine average mismatch
SSD=norm(resids,2)^2;

% Calculate normalised intensities of fit
y_fit=polyval([params(1),params(2)],nw);

end