function [newdata,calibvals] = sifreader(filename)
%--------------------------------------------------------------------------
% SIFREADER
%--------------------------------------------------------------------------
% Version 1.0
% Written and tested on Matlab R2014a (Windows 7)

% Copyright: Andor
 
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
rc=atsif_setfileaccessmode(0);
rc=atsif_readfromfile(filename);
if (rc == 22002)
  signal=0;
  [~,present]=atsif_isdatasourcepresent(signal);
  if present
    [~,no_frames]=atsif_getnumberframes(signal);
    if (no_frames > 0)
        [~,size]=atsif_getframesize(signal);
        [~,left,bottom,right,top,hBin,vBin]=atsif_getsubimageinfo(signal,0);
        xaxis=0;
        [~,data]=atsif_getframe(signal,0,size);
        [~,pattern]=atsif_getpropertyvalue(signal,'ReadPattern');
        if(pattern == '0')
           [~,xtype]=atsif_getpropertyvalue(signal,'XAxisType');
           [~,xunit]=atsif_getpropertyvalue(signal,'XAxisUnit');
           [~,ytype]=atsif_getpropertyvalue(signal,'YAxisType');
           [~,yunit]=atsif_getpropertyvalue(signal,'YAxisUnit');
           xlabel({xtype;xunit});
           ylabel({ytype;yunit});
        elseif(pattern == '4')
           width = ((right - left)+1)/hBin;
           height = ((top-bottom)+1)/vBin;
           newdata=reshape(data,width,height);
           calibvals = zeros(1,width);
           for i=1:width,[~,calibvals(i)]=atsif_getpixelcalibration(signal,xaxis,(i)); 
           end
        end
    end    
  end
  atsif_closefile;
else
  disp('Could not load file.  ERROR - ');
  disp(rc);
end
