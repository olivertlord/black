function update_ROI_pos(ROI_pos)
%--------------------------------------------------------------------------
% UPDATE_ROI_POS
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

handles = getappdata(0,'handles');
% Get handles structure from appdata

if ROI_pos(2) > 127
    set(handles.edit9,'string',num2str(round(ROI_pos(2))))
    set(handles.edit10,'string',num2str(round(ROI_pos(2))+round(ROI_pos(4))))
else
    set(handles.edit17,'string',num2str(round(ROI_pos(2))))
    set(handles.edit18,'string',num2str(round(ROI_pos(2))+round(ROI_pos(4))))
end
% Determines whether function has been called by the left or right ROI box
% based on the x-pixel position (right nor left cannot extend beyond
% 256/2). Updates values in text boxes based on ROI position.

