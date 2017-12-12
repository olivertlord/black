% --- FILE ENUMERATOR -----------------------------------------------------

function [filelist, filenumber, prefix] = file_enumerator (upath, ufile)

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
