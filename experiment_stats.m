function experiment_stats(filepath)
    % EXPERIMENT_STATS - Processes statistical data from experiment file
    %   experiment_stats(filepath) reads data from the specified file and
    %   calculates summary statistics for left, right, and combined values.
    %
    % Inputs:
    %   filepath - String, path to the input data file
    %
    % The function reads a formatted data file, calculates statistics
    % and appends statistical summaries to the file. Results are also
    % printed to the MATLAB command line.

    % Check if the file exists
    if ~exist(filepath, 'file')
        error('File not found: %s', filepath);
    end
    
    % Read all data at once with readtable
    data_table = readtable(filepath, 'HeaderLines', 1, 'Format', '%s%d%d%d%d%d%d%d%d%d%d%d%d%d%d');
    data = table2array(data_table(:, 3:end));

    % Initialize statistics arrays
    statsLR = NaN(1, 13);
    stats = NaN(1, 6);

    % calculate duration of experiment
    duration = max(data(:,1))-min(data(:,1));
    
    % calculate minimum, maximum and mean for whole experiment on left side
    [statsLR(2), statsLR(3), ~, ~, ~, ~] = calc_temp_stats(data(:,2),data(:,3));
    [~, ~, statsLR(4), statsLR(5), ~, ~] = calc_temp_stats(data(:,4),data(:,5));
    [~, ~, ~, ~, statsLR(6), statsLR(7)] = calc_temp_stats(data(:,6),data(:,7));

    % calculate minimum, maximum and mean for whole experiment on right side
    [statsLR(8), statsLR(9), ~, ~, ~, ~] = calc_temp_stats(data(:,8),data(:,9));
    [~, ~, statsLR(10), statsLR(11), ~, ~] = calc_temp_stats(data(:,10),data(:,11));
    [~, ~, ~, ~, statsLR(12), statsLR(13)] = calc_temp_stats(data(:,12),data(:,13));

    % Prepare headers and data for experimental stats: left and right
    left_right_header_line = sprintf('%-35s%-10s',' ','Experimental stats: left and right');
    left_right_stats = sprintf('%-35s%-10d%-10d%-10d%-10d%-10d%-10d%-10d%-10d%-10d%-10d%-10d%-10d%-10d', ...
        ' ', round(duration), round(statsLR(2)), round(statsLR(3)), round(statsLR(4)), ...
        round(statsLR(5)), round(statsLR(6)), round(statsLR(7)), round(statsLR(8)), ...
        round(statsLR(9)), round(statsLR(10)), round(statsLR(11)), ...
        round(statsLR(12)), round(statsLR(13)));

    % calculate minimum, maximum and mean for whole experiment combined
    [stats(2), stats(3), ~, ~, ~, ~] = calc_temp_stats([statsLR(2),statsLR(8)],[statsLR(3),statsLR(9)]);
    [~, ~, stats(4), stats(5), ~, ~] = calc_temp_stats([statsLR(4),statsLR(10)],[statsLR(5),statsLR(11)]);
    [~, ~, ~, ~, stats(6), stats(7)] = calc_temp_stats([statsLR(6),statsLR(12)],[statsLR(7),statsLR(13)]);
    
    % Prepare headers and data for experimental stats: combined
    combined_header_line = sprintf('%-35s%-10s',' ','Experimental stats: combined');
    combined_column_header = sprintf('%-35s%-10s%-10s%-10s%-10s%-10s%-10s%-10s%-10s%-10s', ...
        ' ', 'Duration', 'Max', 'E Max', 'Min', 'E Min', 'Mean', 'E Mean', '+error', '-error');
    stats_line = sprintf('%-35s%-10d%-10d%-10d%-10d%-10d%-10d%-10d%-10d%-10d', ...
        ' ', round(duration), round(stats(2)), round(stats(3)), ...
        round(stats(4)), round(stats(5)), ...
        round(stats(6)), round(stats(7)), round(stats(2)-stats(6)), round(stats(6)-stats(4)));
    
% Create array of strings to print
output_strings = {
    '', 
    left_right_header_line, 
    left_right_stats, 
    '', 
    combined_header_line, 
    combined_column_header, 
    stats_line
};

% Print to command line all at once
fprintf('%s\n', output_strings{:});

% Open the file for appending and write all strings at once
fid = fopen(filepath, 'a');
if fid == -1
    error('Cannot open file for writing: %s', filepath);
end

fprintf(fid, '%s\n', output_strings{:});
fclose(fid);
end