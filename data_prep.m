function [unkdata,skip] = data_prep(handles,upath,filename,i)
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
%   DATA_PREP 

%   INPUTS:

%   OUTPUTS:

%--------------------------------------------------------------------------

% Read in hardware parameters
hp = matfile('hardware_parameters.mat','Writable',true);

% Set GUI box to file name
set(handles.edit_filename,'string',filename);

% Read .sif files from iDus detector using Andor sifreader
if isempty(strfind(filename, 'sif')) == false
    
    [unkdata,wavelengths] = sifreader(strcat(upath,filename));
    
    % Remove saturated pixels
    unkdata(unkdata> 64000) = NaN;
    
% Read .spe files from PIXIS detector
elseif isempty(strfind(filename, 'spe')) == false
    
    fid=fopen(strcat(upath,filename),'r');
    unkdata=fread(fid,[hp.col,hp.row],'real*4','l');
    fclose(fid);
    
    % Remove the first a last columns due to artefacts
    unkdata(1:5,:)=NaN;
    unkdata(hp.col-5:hp.col,:)=NaN;
    
    % Remove saturated pixels
    unkdata(unkdata> 8.4077e-41) = NaN;
end

% WPRKAROUND FOR SVEN FRIEDEMANN'S GROUP
% If raw data is binned, copy single row to all rows 
if length(unkdata(1,:)) < 256
    if isempty(strfind(filename, 'sif')) == false
        binned = unkdata(:,1);
    elseif isempty(strfind(filename, 'spe')) == false
        binned = unkdata(:,2);
    end
    unkdata = padarray(binned,[0 255],'replicate','post');
end

% If the subtract radiobutton is switched on
if get(handles.radiobutton_subtract_background,'value') == 1
    
    % Get backgorund data from AppData
    backdata = getappdata(0,'backdata');
    
    % Remove saturated pixels
    backdata(backdata> 64000) = NaN;
    
    % If raw data is binned, copy single row to all rows
    if length(backdata(1,:)) < 256
        binned = backdata(:,1);
        backdata = padarray(binned,[0 255],'replicate','post');
    end
        unkdata = unkdata-backdata;
        
end    

% Use W emissivity if radiobutton selected
if get(handles.radiobutton_W_emissivity,'value') == 1
    for i=1:col
        E(i) = 0.53003 - 0.000136*w(i); %#ok<AGROW>
    end
    for i=1:row
        for j=1:col
            unkdata(j,i) = unkdata(j,i)./E(j);
        end
    end
end

% Skips data if blank after desaturation
if isnan(max(unkdata(:)))
    skip = 1;
else
    skip = 0;
end

% Smooth data
smooth = ceil(get(handles.slider_smooth,'Value'));
unkdata = conv2(unkdata,ones(smooth,1),'same');
set(handles.text_smooth,'String',num2str(smooth));

% Sum multiple data files
if get(handles.radiobutton_sum,'value') == 1 
    sum_store = getappdata(0,'sum_store');
    sum_store(:,:,i) = unkdata;
    setappdata(0,'sum_store',sum_store);
    unkdata = sum(sum_store,3);   
end

% Plot Raw Image
axes(handles.plot_raw)
imagesc(wavelengths,1:256,unkdata(1:1024,1:256)',[0 max(max(unkdata))]);
plot_axes(handles,'plot_raw','wavelength (nm)','pixels',...
    strcat('RAW CCD IMAGE:',filename), 'Right',1,0,1,length(unkdata(1,:)),wavelengths(:,1),wavelengths(:,end));

end