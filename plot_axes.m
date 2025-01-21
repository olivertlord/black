function plot_axes(handles,plot_name, xlab, ylab, title_string, yloc, replace, auto, ylim1, ylim2, xlim1, xlim2)
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
axes(handles.(plot_name))
xlabel(xlab, 'FontSize', 12);
ylabel(ylab, 'FontSize', 12);

if strfind(title_string,'Wien') == 1
    ax=gca;
    yticklabels = get(ax, 'YTickLabel');
    yticklabels(1) = ' ';
    set(ax, 'YTickLabel',yticklabels);
end
    
set(gca,'YAxisLocation',yloc)
if replace == 1
    set(gca,'NextPlot','replacechildren') ;
else
    set(gca,'NextPlot','Add') ;
end

% Sets auto limits if required
if auto == 1
    ylim('auto')
    xlim('auto')
elseif auto == 0
    ylim([ylim1 ylim2]);
    xlim([xlim1 xlim2]);
end

if strcmp(title_string,'Cross-sections') == 0 && strcmp(title_string,'Wien fits') == 0
    title(title_string, 'FontSize', 14);
end
%--------------------------------------------------------------------------