function [filelist, filenumber, prefix] = file_enumerator (upath, ufile)
%--------------------------------------------------------------------------
% FILE_ENUMERATOR
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
dir_content = dir(strcat(upath,'*.SPE'));

[~,idx] = sort([dir_content.datenum]);
dir_content = dir_content(idx);
% Collect date sorted list of filenames

filelist = zeros(length(idx));
% Pre-allocate filelist array

for i = 1:length(dir_content)

    digit_str = '';
    counter_1 = 0;
    % Set counters
    
    dir_content(i).name;
    length(dir_content(i).name);
    for j = 5:length(dir_content(i).name)
        
        digit = dir_content(i).name(end+1-j:end+1-j);
        % Extract element of filename
        
        if isstrprop(digit,'digit')
        % Determine if it is a number
        
            digit_str = strcat(digit,digit_str);
            counter_1 = counter_1 + 1;
            % If it is, add it to previous digits & increment counter
            
        else
            
            filelist(i) = str2double(digit_str);
            % If it isn't a digit, save current run of digits to filelist
            % converted to numbers
            
            if strcmp(dir_content(i).name,ufile) == 1
            % If Current  filename (i) is the same as the string in the GUI
            % unknown file box, set filenumber to i
                
                filenumber = filelist(i);
                prefix = dir_content(i).name(1:end-(4+counter_1));
                % Determine prefix for saving files later
                
            end
           
            break
            % Exit loop
        
        end
        
    end
    % Extract number from end of file or arbitrary length with any 
    % preceding or subsequent non-numeric character

end
