function [T,J,E,Ee,e,r,SSD,params,fit,lpix,hpix] = Temp(unkdata,caldata,sr,w,mnl,mxl,mxrow,mnrow,handles,nw,c1)
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
%   TEMP

%   INPUTS:

%   OUTPUTS:

%--------------------------------------------------------------------------

% Create arrays for left and right ROIs mapped onto unknown CCD image
unk = unkdata(1:length(w),mnrow:mxrow);

% Create arrays for left and right ROIs mapped onto calibration CCD image
cal = caldata(1:length(w),mnrow:mxrow);

% Calculate the pixel limits for fitting
[~,lpix]=min(abs(w-mnl));
[~,hpix]=min(abs(w-mxl));

w = repmat(w,mxrow-mnrow+1,1);
sr = repmat(sr,mxrow-mnrow+1,1);

% Performs system responce calibration of the raw data and calculates
% normalised intensities
J=log(unk./cal.*sr'.*w'.^5/c1);
J=real(J);
J(J==-Inf)=NaN;

% Creates matrix of X values for fitting
nwf=horzcat(ones(hpix-lpix+1,1),nw(lpix:hpix,1));

% Preallocate arrays for fitting results
[T,E,e,SSD]=deal(zeros(1,length(J(1,:))));
r=zeros(length(J(lpix:hpix,1)),length(J(1,:)));

% If Wien fit is selected from drop-down menu
if get(handles.popupmenu_fit_type,'Value') == 1
    
    for i=1:length(J(1,:))
        
        % Switch off regression warnings
        warning('off','stats:regress:RankDefDesignMat')

        % Fit with Wien approximation to the Planck function
        [params(i,:),bint,r(:,i)]=regress(J(lpix:hpix,i),nwf);
        
        % Determine temperature, emissivity and error from fit
        T(i)=real((-1/params(i,2)));
        E(i)=params(i,1);
        e(i)=abs(T(i))-(-1/(bint(2)));
        Ee(i)=abs(E(i))-(bint(1));
        
        % Determine average mismatch
        SSD(i)=norm(r(i),2)^2;
        
        % Calculate normalised intensities of fit
        fit(:,i)=polyval([params(i,2),params(i,1)],nw);
                
    end
    
% If Wien + Sine is selected from the drop-down menu
elseif get(handles.popupmenu_fit_type,'Value') == 2
    
    for i=1:length(J(1,:))
        
        % Switch off regression warnings
        warning('off','stats:nlinfit:IllConditionedJacobian');
        
        % Define model for fitting
        modelfun = @(b,x)(b(1) + b(2)*x + b(3)*sin(2*pi*(x-b(4))/b(5)));
        
        % Initial guess parameters
        beta0 = [79.5 -.0008 .3 1600 1200];

        % line + sine function
        [params(i,:),r(:,i),Jacobian,CovB] = nlinfit(nwf(:,2),J(lpix:hpix,i),modelfun,beta0);
       
        % Determine cnonfidence intervals on fitted parameters
        ci = nlparci(params(i,:),r(:,i),Jacobian);
        
        % Determine temperature, emissivity and error from fitted
        % parameters
        T(i)=real((-1/params(i,2)));
        E(i)=params(i,1);
        e(i)=T(i)-ci(5,1);
        
        % Determine average mismatch
        SSD(i)=norm(r(i),2)^2;
        
        % Calculate normalised intensities of fit
        fit(:,i)=params(i,1) + params(i,2)*nw + params(i,3)*sin(2*pi*(nw-params(i,4))/params(i,5));

    end
    
% If Planck is selected from the drop-down menu
else
    for i=1:length(J(1,:))
        
        warning('off','stats:nlinfit:IllConditionedJacobian');
        
        % Planck fit
        [x,resids,J(i)] = nlinfit( (w(lpix:hpix))',unir(lpix:hpix,i),...
            'planck', [0.01 3000]);
        
        ci = nlparci(x,resids,J);
        
        % Determine temperature, emissivity and error from fitted
        % parameters
        T(i) = x(:,2); %#ok<AGROW>
        e(i)= x(:,1);
        delta(i)=T(i)-ci(2,1); %#ok<AGROW>
    end
end
    
    % If T correction radiobutton selected
    if get(handles.radiobutton_T_correction,'Value') == 1
          
         % Determine corrected temperature based on Walter & Koga (2004)
         T(i)=T(i) - (-0.0216*(e(i)*e(i))+17.882*e(i)); 
    end

end