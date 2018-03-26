function rotate(handles,upath)
%--------------------------------------------------------------------------
% ROTATE
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
clear unkdata unkdatab caldata maxtemp maxtemp1 aveerr1 mnlam1 mxlam1
% Clear variables

[~, ~, ~, ~, ~, ~, ~, row, col, ~, ~, ~, ~, mnrowl, mxrowl, mnrowr,...
    mxrowr, lpixl, hpixl, lpixr, hpixr] = ROI(handles);
% Get GUI box values

fid=fopen(strcat(getappdata(0,'calpath'),get(handles.edit2,'string')),'r');
cal_l=fread(fid,[col row],'real*4','l');
fclose(fid);
% Open thermal calibration file: left

fid = fopen(strcat(getappdata(0,'calpath'),get(handles.edit12,'string')),'r');
cal_r = fread(fid,[col row],'real*4','l');
fclose(fid);
% Open thermal calibration file: right

filename = get(handles.edit20,'String');
fid=fopen(strcat(upath,filename),'r');
% Get current filename

unkdata=fread(fid,[col row],'real*4','l');
% Reads in unknown file

unkdata(unkdata> 8.4077e-41)=NaN;
% Removes saturated pixels

ninl = unkdata./cal_l;
ninr = unkdata./cal_r;
% Normalize unknown data to calibration data

for i = lpixl:hpixl    
    % For every column of pixels within the ROI on the left
    
    spline_L = spline([mnrowl:mxrowl],ninl(i,mnrowl:mxrowl),[mnrowl:0.01:mxrowl]); %#ok<NBRAK>
    % Do spline fit to interpolate peak in intensity data at 0.01 pixel
    % resolution
    
    [~,pos] = max(spline_L);
    % Determine position of peak wihtin spline fit output array
    
    peak_l(i) = mnrowl + 0.01*pos; %#ok<AGROW>
    %Determine pixel value of peak position
    
end

for i = lpixr:hpixr
    % For every column of pixels within the ROI on the right

    spline_R = spline([mnrowr:mxrowr],ninr(i,mnrowr:mxrowr),[mnrowr:0.01:mxrowr]);  %#ok<NBRAK>
    % Do spline fit to interpolate peak in intensity data at 0.01 pixel
    % resolution    
    
    [~,pos] = max(spline_R);
    % Determine position of peak wihtin spline fit output array
    
    peak_r(i) = mnrowr + 0.01*pos; %#ok<AGROW>
    % Determine pixel value of peak position    
end

peak_l(peak_l < mnrowl) = NaN;
peak_r(peak_r < mnrowr) = NaN;
% Convert zeros to NaN at start of array outside ROI

strike_L = polyfit([lpixl:hpixl]',peak_l(lpixl:hpixl)',1); %#ok<NBRAK>
strike_R = polyfit([lpixr:hpixr]',peak_r(lpixr:hpixr)',1); %#ok<NBRAK>
% Determine slope of peak on the CCD using a linear fit

tilt_L = atand(strike_L(1)/1); %#ok<NASGU>
tilt_R = atand(strike_R(1)/1); %#ok<NASGU>
% Convert slope to tilt angle in degrees

save('rotfile.mat','tilt_L','tilt_R')
% Save tilt angles in .MAT file

axes(handles.axes6)
plot([1:hpixl],peak_l,'bo',[1:1024],polyval(strike_L,1:1:1024),'r-'); %#ok<NBRAK>
plot_axes('pixels', 'pixels', 'Slope', 'Right',1)
ylim([min(peak_l)-1 max(peak_l)+1]);
xlim([lpixl hpixl])
% Plot spline fit resilte left

axes(handles.axes7)
plot([1:hpixr],peak_r,'bo',[1:1024],polyval(strike_R,1:1:1024),'r-'); %#ok<NBRAK>
plot_axes('pixels', 'pixels', 'Slope', 'Right',1)
ylim([min(peak_r)-1 max(peak_r)+1]);
xlim([lpixr hpixr])
% Plot spline fit resilte right

set(handles.radiobutton8,'Value',1);
% Set "rotate" radiobutton to on

pause(5);
% Pause to allow user to see results

Tcalc(handles, eval(get(handles.edit22,'string')), eval(get(handles.edit21,'string')), eval(get(handles.edit22,'string')), upath, filename((1:end-(4+length(get(handles.edit21,'string'))))),getappdata(0,'calpath'))
% Run Tcalc