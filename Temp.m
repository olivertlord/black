function [temp,j,etemp,delta] = Temp(nin,divby,omega,w,lamp,conl,lam1,...
    lam2,mxlam,mnlam,mxrow,mnrow,col,unkdata,handles)
%--------------------------------------------------------------------------
% TEMP
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
omx=[ones(col,1),omega'];
% Preallocate array

x0=[0.01 3000];

for i=mnrow:mxrow
    % For each CCD row
     
    unir(1:col,i) = nin(1:col,i) .* rot90(lamp(1:col),3); %#ok<AGROW>
    assignin('base','unir',unir);
    j(1:col,i) = log(unir(1:col,i) .* divby(1:col)); %#ok<AGROW>
    % Calculate unknown radiance for Wien's Law fit
    % Determine the best linear fit for a over selected wavelength range
        
    lpix=round(conl + lam1.*mnlam + lam2.*mnlam.^2);
    hpix=round(conl + lam1.*mxlam + lam2.*mxlam.^2);
    % Convert minimum and maximum wavelengths to pixel values
    
    if hpix>1024
        hpix=1024;
    end
    % Ensure rounding errors dont produce pixel numbers > 1024
    
    if numel(find(isnan(unkdata(:,i)))) < length(unkdata(:,i))/100
    % If less than 1% of pixels are NaN
        
        if get(handles.popupmenu1,'Value') == 1
        % If Wien fit is selected from drop-down menu
            
            [b,bint,~]=regress(j(lpix:hpix,i),omx(lpix:hpix,:));
            % Wien fit
            
            temp(i)=-1/b(2); %#ok<AGROW>
            etemp(i)=-1/(bint(2)); %#ok<AGROW>
            delta(i)=temp(i)-etemp(i); %#ok<AGROW>
            % Determine temperature, emissivity and error
            
        else
            
            warning('off','stats:nlinfit:IllConditionedJacobian');
            
            [x,resids,J] = nlinfit( (w(lpix:hpix))',unir(lpix:hpix,i), 'planck', x0);
            % Planck fit
            
            ci = nlparci(x,resids,J);
            
            temp(i) = x(:,2); %#ok<AGROW>
            etemp(i)= x(:,1); %#ok<AGROW>
            delta(i)=temp(i)-ci(2,1); %#ok<AGROW>
            % Determine temperature, emissivity and error

        end
        
        if get(handles.radiobutton34,'Value') == 1
        % If T correction radiobutton selected
            
            deltecx(i)=delta(i)-2.; %#ok<AGROW>
            temp(i)=temp(i) - (-0.0216*(deltecx(i)*deltecx(i))+17.882*deltecx(i)); %#ok<AGROW>
            % Determine corrected temperature based on Walter & Koga (2004)
        end
        
        if delta(i) > 50
        % If error is more than 50K
            
            [temp(i),etemp(i),delta(i),j(lpix:hpix,i),omega(lpix:hpix,i)] = deal(NaN); %#ok<AGROW>
            % Convert to NaN
            
        end
        
    else
    % If more than 1% of pixels are NaN (saturated)
    
        [temp(i),etemp(i),delta(i),j(lpix:hpix,i),omega(lpix:hpix,i)] = deal(NaN); %#ok<AGROW>
        % Convert to NaN
        
    end
end