function [emin, conl, lam1, lam2, conp, pix1, pix2, row, col, mnll, mxll,...
    mnlr, mxlr, mnrowl, mxrowl, mnrowr, mxrowr, lpixl, hpixl,lpixr, ...
    hpixr] = ROI(handles)
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
%   DATA_PREP Applies user optional data cleaning procedures to the data
%   before fitting. This function opens the raw data file, reads in the
%   data, smooths it, removes saturated pixels, applies W emissivity values
%   and normalises the image for plotting and then plots in axes10. It does
%   not calibrate the data.

%   INPUTS:

%   OUTPUTS:


%--------------------------------------------------------------------------
ROIs = findobj(handles.axes10,'Type', 'hggroup', 'Tag', 'imrect');
delete(ROIs)
% Deletes existing ROI rectangle objects

conl = -2000.817;
lam1 = 3.497;
lam2 = 0.00016;
conp = 557.838;
pix1 = 0.2720;
pix2 = -3.1000e-06;
% Wavelength-pixel calibration parameters

row=256;
col=1024;
% Sets number of columns and rows of CCD chip

emin = get(handles.radiobutton2,'value');
% Determines if error minimisation is switched on or off

mnll = eval(get(handles.edit7,'string'));
mxll = eval(get(handles.edit8,'string'));
% Get min and max wavelengths from the left

mnrowl = eval(get(handles.edit9,'string'));
mxrowl = eval(get(handles.edit10,'string'));
% Get min and max row numbers from the left

mnlr = eval(get(handles.edit15,'string'));
mxlr = eval(get(handles.edit16,'string'));
% Get min and max wavelengths from the right

mnrowr = eval(get(handles.edit17,'string'));
mxrowr = eval(get(handles.edit18,'string'));
% Get min and max row numbers from the right

lpixl = round(conl + lam1.*mnll + lam2.*mnll.^2);
hpixl = round(conl + lam1.*mxll + lam2.*mxll.^2);
lpixr = round(conl + lam1.*mnlr + lam2.*mnlr.^2);
hpixr = round(conl + lam1.*mxlr + lam2.*mxlr.^2);
% Convert wavelength extrema to pixel numbers

ROI_l = imrect(handles.axes10,[lpixl mnrowl hpixl-lpixl mxrowl-mnrowl]);
ROI_r = imrect(handles.axes10,[lpixr mnrowr hpixr-lpixr mxrowr-mnrowr]);
% Draw ROI rectangles

addNewPositionCallback(ROI_l,@update_ROI_pos);
fcn = makeConstrainToRectFcn('imrect',[lpixl hpixl],[128 256]);
setPositionConstraintFcn(ROI_l,fcn);
% Calls update_ROI_pos for left but prevents user changing wavelength

addNewPositionCallback(ROI_r,@update_ROI_pos);
fcn = makeConstrainToRectFcn('imrect',[lpixr hpixr],[1 127]);
setPositionConstraintFcn(ROI_r,fcn);
% Calls update_ROI_pos for right but prevents user changing wavelength
