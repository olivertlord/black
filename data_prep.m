function [unkdata] = data_prep(handles,filenumber,prefix,m,col,row)
%--------------------------------------------------------------------------
% DATA_PREP
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
fid=fopen(strcat(getappdata(0,'upath'),strcat(prefix,num2str(m),'.SPE')),'r');
set(handles.edit20,'string',strcat(prefix,num2str(m),'.SPE'));
% Open file and set GUI box to file name

unkdata=fread(fid,[col row],'real*4','l');
% Read in unknown file

fclose(fid);

if get(handles.radiobutton6,'value') == 1
    unkdata = conv2(unkdata,ones(4,1),'same');
end
% Smooth data if option selected

% unkdata(unkdata> 8.4077e-41)=NaN;
% Removes saturated pixels

if get(handles.radiobutton1,'value') == 1
    for i=1:col
        E(i) = 0.53003 - 0.000136*w(i); %#ok<AGROW>
    end
    for i=1:row
        for j=1:col
            unkdata(j,i) = unkdata(j,i)./E(j);
        end
    end
end
% Use W emissivity data if selected by user

unkdata_norm = unkdata./max(unkdata(:));
% Normalises unkdata such that max = 1 for plotting

axes(handles.axes10)
imagesc(unkdata_norm(1:1024,3:256)',[0 max(max(unkdata_norm(1:1024,3:256)))]);
plot_axes('pixels', 'pixels', strcat('RAW CCD IMAGE:',num2str(filenumber)), 'Right',1);
% Plot Raw Image

end

