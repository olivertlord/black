function data_save(filename, file_path, output_folder, nw, Jl, fitl, Jr, fitr, idxl, idxr, mnrowl, mxrowl, microns_l, Tl,...
    el, El, Eel, mnrowr, mxrowr, microns_r, Tr, er, Er, Eer, timestamp, elapsedSec, maxtempl, emaxl, mintempl, eminl,...
    meantempl, emeanl, maxtempr, emaxr, mintempr, eminr, meantempr, emeanr)
% DATA_SAVE Saves spectral data, cross-sections, and summary statistics to disk.
%
%   This function saves computed Wien data, cross-section measurements, and summary
%   statistics into structured text files for further analysis. If a summary file
%   does not exist, it is created and a header is written. On subsequent iterations,
%   the function appends results to the summary.
%
% Inputs:
%   filename     - Name of the processed spectral file.
%   file_path    - Path to the directory containing the spectral file.
%   output_folder - Subdirectory within file_path where results will be stored.
%   nw          - Normalized wavelength array.
%   Jl, Jr      - Measured spectral intensities for left and right sensors.
%   fitl, fitr  - Fitted spectral intensities for left and right sensors.
%   idxl, idxr  - Indices of the best fit parameters for left and right sensors.
%   mnrowl, mxrowl - Min and max row indices for left region of interest.
%   microns_l   - Spatial coordinate (microns) for left sensor.
%   Tl, el, El, Eel - Temperature and error values for left region.
%   mnrowr, mxrowr - Min and max row indices for right region of interest.
%   microns_r   - Spatial coordinate (microns) for right sensor.
%   Tr, er, Er, Eer - Temperature and error values for right region.
%   i           - Iteration index (used to determine if a summary header is needed).
%   timestamp   - File timestamp (numeric format).
%   elapsedSec  - Time elapsed since the first file in the sequence.
%   maxtempl, emaxl - Maximum temperature and associated error (left).
%   mintempl, eminl - Minimum temperature and associated error (left).
%   meantempl, emeanl - Mean temperature and associated error (left).
%   maxtempr, emaxr - Maximum temperature and associated error (right).
%   mintempr, eminr - Minimum temperature and associated error (right).
%   meantempr, emeanr - Mean temperature and associated error (right).
%
% Outputs:
%   - Creates an output directory if it does not exist.
%   - Saves Wien function fit data to a text file.
%   - Saves cross-section temperature data to a text file.
%   - Creates or appends to a summary file containing key statistical metrics.
%
% Example:
%   data_save('sample.sif', 'C:\Data\', 'Results', nw, Jl, fitl, Jr, fitr, ...)

% Prepare output path and base filename
expname = split(filename, '.sif');
expname = expname{1}; % Extract base name
output_path = fullfile(file_path, output_folder, '/');

% Create output directory if it doesn't exist
if ~exist(output_path, 'dir')
    mkdir(output_path);
end

% Save Wien data
wien_file = fullfile(output_path, sprintf('%s_wien.txt', expname));
wiens = double(padcat(nw, Jl(:, idxl), fitl(:, idxl), nw, Jr(:, idxr), fitr(:, idxr)));
save(wien_file, 'wiens', '-ASCII');

% Save cross-section data
section_file = fullfile(output_path, sprintf('%s_x-sections.txt', expname));
sections = double(padcat((mnrowl:mxrowl)', microns_l', Tl', el', El', Eel', ...
    (mnrowr:mxrowr)', microns_r', Tr', er', Er', Eer'));
save(section_file, 'sections', '-ASCII');

% Create or append to the summary file
summary_file = fullfile(output_path, 'SUMMARY.txt');

% Check if file exists and is empty
file_info = dir(summary_file);
if ~isfile(summary_file) || file_info.bytes == 0
    % Write header if file doesn't exist or is empty
    write_summary_header(summary_file);
end

% Write summary data
write_summary_data(summary_file, filename, timestamp, elapsedSec, ...
    maxtempl, emaxl, mintempl, eminl, meantempl, emeanl, ...
    maxtempr, emaxr, mintempr, eminr, meantempr, emeanr);

end

% HELPER FUNCTION: WRITE_SUMMARY_HEADER--------------------------------------------------------------------------------------
function write_summary_header(summary_file)
fid = fopen(summary_file, 'a');
if fid == -1
    error('Unable to open summary file: %s', summary_file);
end

% Prepare and write header
header = sprintf('%-20s%-15s%-10s%-10s%-10s%-10s%-10s%-10s%-10s%-10s%-10s%-10s%-10s%-10s%-10s\n', ...
                      'Filename', 'Timestamp', 'Elapsed', 'Max L', 'E Max L', 'Min L', ...
                      'E Min L', 'Mean L', 'E Mean L', 'Max R', 'E Max R', ...
                      'Min R', 'E Min R', 'Mean R', 'E Mean R');
fprintf(fid, header);
fprintf('\n');
fprintf(header);
fclose(fid);
end

% HELPER FUNCTION: WRITE_SUMMARY_DATA ---------------------------------------------------------------------------------------
function write_summary_data(summary_file, filename, timestamp, elapsedSec, ...
    maxtempl, emaxl, mintempl, eminl, meantempl, emeanl, ...
    maxtempr, emaxr, mintempr, eminr, meantempr, emeanr)
fid = fopen(summary_file, 'a');
if fid == -1
    error('Unable to open summary file: %s', summary_file);
end

% Convert timestamp to numeric if it's a datetime
if isa(timestamp, 'datetime')
    timestamp = posixtime(timestamp);
end

% Extract string content
filename = char(filename);

% Trim filename to 20 characters
if length(filename) > 20
    filename = [filename(1:16), '...'];
end

% Prepare data row
data_row = sprintf('%-20s%-15.0f%-10.0f%-10.0f%-10.0f%-10.0f%-10.0f%-10.0f%-10.0f%-10.0f%-10.0f%-10.0f%-10.0f%-10.0f%-10.0f\n', ...
    filename, timestamp, elapsedSec, maxtempl, emaxl, mintempl, eminl, meantempl, emeanl, maxtempr,...
    emaxr, mintempr, eminr, meantempr, emeanr);

% Write to file and display in workspace
fprintf(fid, data_row);
fprintf(data_row); % Display in command window
fclose(fid);
end