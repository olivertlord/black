function lamp = lampcal(w, lam, E)
% LAMPCAL calculates the lamp spectral radiance for wavelengths w using
% interpolation from reference wavelengths lam and spectral radiance values E.
%
% Inputs:
%   w   - Vector of wavelengths where radiance is needed (size: 1x1024)
%   lam - Vector of reference wavelengths (size: 1x58)
%   E   - Vector of spectral radiance at reference wavelengths (size: 1x58)
%
% Output:
%   lamp - Interpolated spectral radiance at wavelengths w

% Preallocate lamp array for efficiency
lamp = zeros(size(w));

% Loop over each wavelength in w
for i = 1:length(w)
    % Find the index of the nearest lower reference wavelength in lam
    j0 = find(lam <= w(i), 1, 'last');
    if j0 > length(lam) - 3  % Prevent out-of-bounds error
        j0 = length(lam) - 3;
    end
    
    % Lagrange interpolation over 4 points
    D = 0;
    for k = 0:3
        xk = lam(j0) + k * 10;
        pt = 1;
        for l = 0:3
            xl = lam(j0) + l * 10;
            if l ~= k
                pt = pt * (w(i) - xl) / (xk - xl);
            end
        end
        D = D + pt * E(j0 + k);
    end
    
    % Store interpolated value
    lamp(i) = D;
end