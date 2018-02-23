function plot_axes(xlab, ylab, title_string, yloc, replace)
%--------------------------------------------------------------------------
% PLOT_AXES
%--------------------------------------------------------------------------
% Version 6.0
% Written and tested on Matlab R2014a (Windows 7) & R2017a (OS X 10.13)

% Copyright 2018 Oliver Lord, Mike Walter
% email: oliver.lord@bristol.ac.uk
 
% This file is part of black.
 
% black is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
 
% black is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
 
% You should have received a copy of the GNU General Public License
% along with black.  If not, see <http://www.gnu.org/licenses/>.
%--------------------------------------------------------------------------
%   DATA_PREP Applies user optional data cleaning procedures to the data
%   before fitting. This function opens the raw data file, reads in the
%   data, smooths it, removes saturated pixels, applies W emissivity values
%   and normalises the image for plotting and then plots in axes10. It does
%   not calibrate the data.

%   INPUTS:

%   OUTPUTS:


%--------------------------------------------------------------------------
xlabel(xlab, 'FontSize', 12);
ylabel(ylab, 'FontSize', 12);
title(title_string, 'FontSize', 14);
set(gca,'YAxisLocation',yloc)
if replace == 1
    set(gca,'NextPlot','replacechildren') ;
else
    set(gca,'NextPlot','Add') ;
end

% Sets plot attributes and is called whenever data is plotted