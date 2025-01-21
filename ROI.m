function [mnll, mxll, mnlr, mxlr, mnrowl, mxrowl, mnrowr, mxrowr] = ROI(handles)
%--------------------------------------------------------------------------
% ROI
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
%   ROI

%   INPUTS:

%   OUTPUTS:


%--------------------------------------------------------------------------
ROIs = findobj(handles.plot_raw,'Type', 'hggroup', 'Tag', 'imrect');
delete(ROIs)
% Deletes existing ROI rectangle objects

% Load unknown matfile
unkmat = matfile('unknown.mat','Writable',true);

% Get wavelengths
if isempty(strfind(cellstr(unkmat.names(1,:)), 'sif')) == false %#ok<AGROW>
    wavelengths = unkmat.wavelengths;
elseif isempty(strfind(cellstr(unkmat.names(1,:)), 'spe')) == false %#ok<AGROW>
    hp = matfile('hardware_parameters.mat','Writable',true);
    wavelengths = hp.w;
end

mnll = eval(get(handles.edit_wavelength_min_left,'string'));
mxll = eval(get(handles.edit_wavelength_max_left,'string'));
mnrowl = eval(get(handles.edit_ROI_min_left,'string'));
mxrowl = eval(get(handles.edit_ROI_max_left,'string'));
 
mnlr = eval(get(handles.edit_wavelength_min_right,'string'));
mxlr = eval(get(handles.edit_wavelength_max_right,'string'));
mnrowr = eval(get(handles.edit_ROI_min_right,'string'));
mxrowr = eval(get(handles.edit_ROI_max_right,'string'));

ROI_l = imrect(handles.plot_raw,[mnll mnrowl mxll-mnll mxrowl-mnrowl]);
ROI_r = imrect(handles.plot_raw,[mnlr mnrowr mxlr-mnlr mxrowr-mnrowr]);

addNewPositionCallback(ROI_l,@update_ROI_pos);
fcn = makeConstrainToRectFcn('imrect',[wavelengths(1) wavelengths(end)],[128 256]);
setPositionConstraintFcn(ROI_l,fcn);
% Calls update_ROI_pos for left

addNewPositionCallback(ROI_r,@update_ROI_pos);
fcn = makeConstrainToRectFcn('imrect',[wavelengths(1) wavelengths(end)],[1 127]);
setPositionConstraintFcn(ROI_r,fcn);
% Calls update_ROI_pos for right
