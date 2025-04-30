function [mnll,mxll,mnlr,mxlr] = errormin(errorMinType, handles, unkl, unkr, caldata_l, caldata_r, hp, wavelengths, mnll, mxll, mnlr, mxlr,...
    mnrowl, mxrowl, mnrowr, mxrowr)
% ERRORMIN Performs error minimization for spectral fitting and calibration optimization.
%
%   This function calculates temperature and error values for different wavelength
%   windows to minimize fitting errors. If enabled, it also optimizes the calibration
%   file selection. The function updates the GUI with optimal wavelength settings.
%
% Inputs:
%   errorMinType  - Type of error minimization (integer 1-4).
%                   1: Standard error minimization.
%                   2: Single wavelength optimization.
%                   3: 2D optimization (wavelength start & width).
%                   4: Calibration file optimization.
%   handles       - GUI handles structure.
%   unkl, unkr    - Unknown spectral data for left and right regions.
%   caldata_l, caldata_r - Calibration data for left and right regions.
%   hp            - Hardware parameters (e.g., sensor response).
%   wavelengths   - Wavelength array (nm).
%   mnrowl, mxrowl - Min/max row indices for left region.
%   mnrowr, mxrowr - Min/max row indices for right region.
%   nw           - Normalized wavelength array.
%   c1           - Precomputed Planck constant for fitting.
%
% Outputs:
%   - Updates the GUI with optimal wavelength settings.
%   - Plots error minimization results.
%   - Optimizes calibration files if errorMinType == 4.
%
% Example:
%   errormin(3, handles, unkl, unkr, cal_l, cal_r, hp, wavelengths, 50, 200, 60, 210, nw, c1);

% Only proceed if the type is within valid range
if errorMinType < 4
    [spix, epix, sw, ww] = generatePixelData(errorMinType,wavelengths);
    [~, ~, ael, aer] = calculateErrors(spix, epix, mnrowl, mxrowl, mnrowr, mxrowr, wavelengths, unkl, unkr, caldata_l, caldata_r, hp, handles);

    % Remove negative errors
    ael(ael <= 0) = NaN;
    aer(aer <= 0) = NaN;
    
    % Find minimum error indices
    [~, idxl] = min(ael(:));
    [~, idxr] = min(aer(:));

    % Determine optimum wavelength limits
    mnll = round(wavelengths(spix(idxl)));
    mxll = round(wavelengths(epix(idxl)));
    mnlr = round(wavelengths(spix(idxr)));
    mxlr = round(wavelengths(epix(idxr)));
    
    % Set GUI boxes
    set(handles.edit_wavelength_min_left, 'string', mnll);
    set(handles.edit_wavelength_max_left, 'string', mxll);
    set(handles.edit_wavelength_min_right, 'string', mnlr);
    set(handles.edit_wavelength_max_right, 'string', mxlr);

    % Plot error minimisation data
    plotErrorMinimisationData(handles, wavelengths, errorMinType, spix, sw, ww, ael, aer);

    % Update ROI box positions
    ROI(handles);
end

% Handle calibration file optimisation
if errorMinType == 4
    
    % Get extension of unknown file
    [~, ~, extension] = fileparts(get(handles.edit_filename, 'String'));

    % Ask the user to select a folder to search for calibration files
    folderPath = uigetdir('', 'Select a folder to search for calibration files');

    % Get all files with the same extension as the unknown from the user-selected folder
    [fullPathsLeft, calfileNamesLeft] = listCalibrationFiles(folderPath, extension(2:end), 'Cal_L');
    [fullPathsRight, calfileNamesRight] = listCalibrationFiles(folderPath, extension(2:end), 'Cal_R');
    
    % Extract only the directory paths
    calFilePathsLeft = cellfun(@(x) fileparts(x), fullPathsLeft, 'UniformOutput', false);
    calFilePathsRight = cellfun(@(x) fileparts(x), fullPathsRight, 'UniformOutput', false);
    
    % Get the number of elements in each array
    numLeft = length(calFilePathsLeft);
    numRight = length(calFilePathsRight);
    
    % Find the maximum length to loop over
    maxLength = max(numLeft, numRight);

    [max_el,max_er] = deal(NaN(1,maxLength));
    
    % Loop through the longest array
    for i = 1:maxLength
        % Use the last element if we've run out of elements
        leftIdx = min(i, numLeft);   % If i > numLeft, keep using numLeft
        rightIdx = min(i, numRight); % If i > numRight, keep using numRight

        % Load and update calibration data
        data_load('calibration.mat', 'name_l', 'path', 'cal_l', 'wavelengths', '', handles.edit_calname_left, 'on',...
            true, calFilePathsLeft{leftIdx}, calfileNamesLeft{leftIdx});
        calmat = data_load('calibration.mat', 'name_r', 'path', 'cal_r', 'wavelengths', '', handles.edit_calname_right, 'on',...
            true, calFilePathsRight{rightIdx}, calfileNamesRight{rightIdx});

        % Fit temperature
        [Tl, el] = Temp(unkl, calmat.cal_l, hp.sr, wavelengths, mnll, mxll, mxrowl, mnrowl, handles);
        [Tr, er] = Temp(unkr, calmat.cal_r, hp.sr, wavelengths, mnlr, mxlr, mxrowr, mnrowr, handles);
        
        % get error in maximum T
        [~, max_el(i), ~, ~, ~, ~] = calc_temp_stats(Tl, el);
        [~, max_er(i), ~, ~, ~, ~] = calc_temp_stats(Tr, er);
    end
    
    % Find minimum error indices
    [~, idxl] = min(max_el);
    [~, idxr] = min(max_er);

    % Update GUI and calmat
    data_load('calibration.mat', 'name_l', 'path', 'cal_l', 'wavelengths', '', handles.edit_calname_left, 'on',...
        true, calFilePathsLeft{idxl}, calfileNamesLeft{idxl});
    data_load('calibration.mat', 'name_r', 'path', 'cal_r', 'wavelengths', '', handles.edit_calname_right, 'on',...
        true, calFilePathsRight{idxr}, calfileNamesRight{idxr});
end

% Find optimum rotation angles
if errorMinType == 5
    angles = -.2:.01:.2;  % degrees to try
    mean_el = NaN(1, numel(angles));
    mean_er = NaN(1, numel(angles));
    
    for k = 1:numel(angles)
        angle = angles(k);
        
        % Rotate unknowns
        unkl_rot = imrotate(unkl, angle, 'bilinear', 'crop');
        unkr_rot = imrotate(unkr, angle, 'bilinear', 'crop');

        % Fit temperatures
        [Tl, el] = Temp(unkl_rot, caldata_l, hp.sr, wavelengths, mnll, mxll, mxrowl, mnrowl, handles);
        [Tr, er] = Temp(unkr_rot, caldata_r, hp.sr, wavelengths, mnlr, mxlr, mxrowr, mnrowr, handles);

        [~, ~, ~, ~, ~, mean_el(k)] = calc_temp_stats(Tl, el);
        [~, ~, ~, ~, ~, mean_er(k)] = calc_temp_stats(Tr, er);

    end

    % Find best rotation angle
    [~, bestIdxL] = min(mean_el);
    [~, bestIdxR] = min(mean_er);
    tilt_L = angles(bestIdxL);
    tilt_R = angles(bestIdxR);

    % Save tilt angles to .MAT file
    save('rotfile.mat', 'tilt_L', 'tilt_R');

    % Plot error minimisation data
    plotErrorMinimisationData(handles, angles, errorMinType, [], [], [], mean_el, mean_er);

end

% Reset error minimisation dropdown
set(handles.popupmenu_error_min_type, 'Value', 1);

end

% HELPER FUNCTION: generatePixelData ----------------------------------------------------------------------------------------
function [spix, epix, sw, ww] = generatePixelData(errorMinType, wavelengths)
maxpix = 1024;
lsteps = 25;
min_step = 36;
min_width = 124;

if errorMinType == 2
    lsteps = 0;
    min_width = 700;
end

spix = repmat((0:min_step:maxpix-min_width)', [1, lsteps + 1]);
epix = spix + repmat((min_width:(maxpix-min_width)/lsteps:maxpix), [lsteps + 1, 1]);

spix(spix == 0) = 1;
epix(epix > maxpix) = NaN;
spix(isnan(epix)) = NaN;

sw = wavelengths(spix(:, 1));
ww = wavelengths(epix(1, :)) - wavelengths(spix(1, :));
end

% HELPER FUNCTION: calculateErrors ------------------------------------------------------------------------------------------
function [aTl, aTr, ael, aer] = calculateErrors(spix, epix, mnrowl, mxrowl, mnrowr, mxrowr, wavelengths, unkl, unkr,...
    caldata_l, caldata_r, hp, handles)
inner_length = size(epix);
aTl = NaN(size(spix));
aTr = NaN(size(spix));
ael = NaN(size(spix));
aer = NaN(size(spix));

for i = 1:size(spix, 1)
    for j = 1:inner_length(2)
        if ~isnan(spix(i, j)) && ~isnan(epix(i, j))
            mnl = wavelengths(spix(i, j));
            mxl = wavelengths(epix(i, j));

            [Tl, el] = Temp(unkl, caldata_l, hp.sr, wavelengths, mnl, mxl, mxrowl, mnrowl, handles);
            [Tr, er] = Temp(unkr, caldata_r, hp.sr, wavelengths, mnl, mxl, mxrowr, mnrowr, handles);
            
            aTl(i, j) = mean(Tl, 'omitnan');
            aTr(i, j) = mean(Tr, 'omitnan');
            ael(i, j) = mean(el, 'omitnan');
            aer(i, j) = mean(er, 'omitnan');
        end
    end
end
end

% HELPER FUNCTION: plotErrorMinimisationData --------------------------------------------------------------------------------
function plotErrorMinimisationData(handles, x, errorMinType, spix, sw, ww, yl, yr)
if errorMinType == 2
    plot(handles.plot_emin_left, x(spix), yl, 'Color', 'r', 'LineWidth', 2);
    update_axes(handles.plot_emin_left, 'Start Wavelength (nm)', 'Average Error (K)', 'Error Min Left', 'Right', 1, 1);

    plot(handles.plot_emin_right, x(spix), yr, 'Color', 'g', 'LineWidth', 2);
    update_axes(handles.plot_emin_right, 'Start Wavelength (nm)', 'Average Error (K)', 'Error Min Right', 'Right', 1, 1);

elseif errorMinType == 3
    imagesc(handles.plot_emin_left, ww, sw, 1 ./ yl);
    update_axes(handles.plot_emin_left, 'Start Wavelength (nm)', '', 'Error Min Left', 'Right', 1, 0, sw(1), sw(end), ww(1), ww(end));

    imagesc(handles.plot_emin_right, ww, sw, 1 ./ yr);
    update_axes(handles.plot_emin_right, 'Start Wavelength (nm)', 'Window Width (nm)', 'Error Min Right', 'Right', 1, 0, sw(1), sw(end), ww(1), ww(end));

elseif errorMinType == 5
    plot(handles.plot_emin_left, x, yl, 'Color', 'r', 'LineWidth', 2);
    update_axes(handles.plot_emin_left, 'Angle', 'Average Error (K)', 'Error Min Left', 'Right', 1, 1);

    plot(handles.plot_emin_right, x, yr, 'Color', 'g', 'LineWidth', 2);
    update_axes(handles.plot_emin_right, 'Angle', 'Average Error (K)', 'Error Min Right', 'Right', 1, 1);
end
end

% HELPER FUNCTION: listCalibrationFiles -------------------------------------------------------------------------------------
function [filePaths, fileNames] = listCalibrationFiles(folderPath, extension, searchString)
    % findFilesByExtensionAndString: Finds files with a given extension and containing a specific string in the filename.
    %
    % Inputs:
    %   extension    - File extension (e.g., 'spe', 'sif') without the dot.
    %   searchString - A string that must be present in the filename.
    %
    % Outputs:
    %   filePaths - Cell array of full file paths.
    %   fileNames - Cell array of filenames (without paths).
    
    % Search for all files with the specified extension in all subdirectories
    filePattern = fullfile(folderPath, '**', strcat('*.', extension));
    files = dir(filePattern);

    % Count matching files to preallocate
    matchCount = sum(contains({files.name}, searchString, 'IgnoreCase', true));
    
    % Preallocate the filteredFiles struct array with empty fields
    filteredFiles(matchCount) = struct('name', '', 'folder', '', 'date', '', ...
                                   'bytes', [], 'isdir', [], 'datenum', []);
    
    % Filter files based on the search string
    matchIdx = 0;
    for i = 1:length(files)
        if contains(files(i).name, searchString, 'IgnoreCase', true)
            matchIdx = matchIdx + 1;
            filteredFiles(matchIdx) = files(i);  % Assign directly to preallocated array
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