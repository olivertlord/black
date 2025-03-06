function matFileData = data_load(matFileName, field_1, field_2, field_3, field_4, dialog_title, text_box, MultiSelect,...
    skipDialog, path, file)
% DATA_LOAD Loads and processes data from a .MAT file, prompting the user to select files if needed.
%
%   matFileData = DATA_LOAD(matFileName, field_1, field_2, field_3, field_4, 
%                            dialog_title, text_box, MultiSelect, skipDialog, path)
% 
%   This function loads an existing .MAT file and optionally prompts the user 
%   to select files with a given extension (.SPE or .SIF). It processes the selected 
%   file based on its extension, extracts relevant data, and updates a specified text box.
%   The processed data is then saved back to the .MAT file.
%
%   INPUTS:
%   - matFileName  : String, name of the .MAT file to load and save data.
%   - field_1      : String, name of the field storing selected filenames.
%   - field_2      : String, name of the field storing the selected file path.
%   - field_3      : String, name of the field for storing extracted data.
%   - field_4      : String, name of the field for storing additional extracted info.
%   - dialog_title : String, title for the file selection dialog.
%   - text_box     : Handle to a text box UI component to display the selected filename.
%   - MultiSelect  : Boolean, allows multiple file selection if true.
%   - skipDialog   : Boolean, if true, bypasses the file selection dialog and uses 'path'.
%   - path         : String, file path used when 'skipDialog' is true.
%
%   OUTPUT:
%   - matFileData  : Struct containing loaded and updated data.
%
%   FUNCTIONALITY:
%   1. Loads the specified .MAT file into a struct.
%   2. If 'skipDialog' is false, prompts the user to select files with a '.SPE' or '.SIF' extension.
%   3. Ensures filenames are stored as a cell array.
%   4. Updates the specified text box with the first selected filename.
%   5. Reads the selected file:
%      - If the file is '.sif', it uses `sifreader()`.
%      - If the file is '.spe', it reads binary data using `fread()`.
%   6. Saves the updated data back into the .MAT file.
%
%   EXAMPLE USAGE:
%   matFileData = data_load('data.mat', 'filenames', 'filepath', 'imageData', 'metadata', ...
%                            'Select a file', textBoxHandle, false, false, '');

% Load data from .MAT file
matFileData = load(matFileName); 

% Prompt user to select files
if ~skipDialog
    [matFileData.(field_1), matFileData.(field_2)] = uigetfile(fullfile(matFileData.path, '*.SPE;*.sif'), dialog_title,...
        'MultiSelect', MultiSelect);
else
    matFileData.(field_1) = file;
    matFileData.(field_2) = path;
end

% Ensure filenames is a cell array
%filenames = matFileData.(field_1);
if ischar(matFileData.(field_1))  % If single file, convert to cell array
    matFileData.(field_1) = {matFileData.(field_1)};
end

% Update text box with the first filename
set(text_box, 'string', matFileData.(field_1){1});

% Open files depending on whether they are .sif or .spe
filename = fullfile(matFileData.(field_2), matFileData.(field_1){1});

if endsWith(filename, '.sif', 'IgnoreCase', true)
    [matFileData.(field_3), matFileData.(field_4)] = sifreader(filename);
elseif endsWith(filename, '.spe', 'IgnoreCase', true)
    fid = fopen(filename, 'r');
    matFileData.(field_3) = fread(fid, [1024, 256], 'real*4', 'l');
    fclose(fid);

end

% Save matfile
save(matFileName, '-struct', 'matFileData', '-v7.3');