function [filePaths, fileNames] = findFilesByExtension(extension, searchString)
    % findFilesByExtensionAndString: Finds files with a given extension and containing a specific string in the filename.
    %
    % Inputs:
    %   extension    - File extension (e.g., 'spe', 'sif') without the dot.
    %   searchString - A string that must be present in the filename.
    %
    % Outputs:
    %   filePaths - Cell array of full file paths.
    %   fileNames - Cell array of filenames (without paths).

    % Ask the user to select a folder
    folderPath = uigetdir('', 'Select a folder');
    
    % Check if user canceled
    if folderPath == 0
        disp('No folder selected. Exiting function.');
        filePaths = {};
        fileNames = {};
        return;
    end
    
    % Search for all files with the specified extension in all subdirectories
    filePattern = fullfile(folderPath, '**', strcat('*.', extension));
    files = dir(filePattern);
    
    % Initialize output arrays
    filteredFiles = [];
    
    % Filter files based on the search string
    for i = 1:length(files)
        if contains(files(i).name, searchString, 'IgnoreCase', true)  % Case-insensitive match
            filteredFiles = [filteredFiles; files(i)]; %#ok<AGROW>
        end
    end
    
    % Get the number of matched files
    numFiles = length(filteredFiles);
    filePaths = cell(numFiles, 1);
    fileNames = cell(numFiles, 1);
    
    % Store paths and filenames
    for i = 1:numFiles
        filePaths{i} = fullfile(filteredFiles(i).folder, filteredFiles(i).name);
        fileNames{i} = filteredFiles(i).name;
    end
end