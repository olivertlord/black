function experiment_stats(filepath, handles)
% EXPERIMENT_STATS - Processes statistical data from experiment file
%   experiment_stats(filepath) reads data from the specified file and
%   calculates summary statistics for left, right, and combined values.

if ~exist(filepath, 'file')
    error('File not found: %s', filepath);
end

data_table = readtable(filepath, 'HeaderLines', 3, 'Format', '%s%d%d%d%d%d%d%d%d%d%d%d%d%d%d');
data = table2array(data_table(:, 3:end));

statsLR = NaN(1, 13);
stats = NaN(1, 6);

duration = max(data(:,1)) - min(data(:,1));

[statsLR(2), statsLR(3), ~, ~, ~, ~] = calc_temp_stats(data(:,2), data(:,3));
[~, ~, statsLR(4), statsLR(5), ~, ~] = calc_temp_stats(data(:,4), data(:,5));
[~, ~, ~, ~, statsLR(6), statsLR(7)] = calc_temp_stats(data(:,6), data(:,7));
[statsLR(8), statsLR(9), ~, ~, ~, ~] = calc_temp_stats(data(:,8), data(:,9));
[~, ~, statsLR(10), statsLR(11), ~, ~] = calc_temp_stats(data(:,10), data(:,11));
[~, ~, ~, ~, statsLR(12), statsLR(13)] = calc_temp_stats(data(:,12), data(:,13));

left_right_header = 'Experimental stats: left and right';
left_right_header_line = sprintf('%-35s%-10s', ' ', left_right_header);
left_right_underline = sprintf('%-35s%s', ' ', repmat('-', 1, length(left_right_header)));

left_right_stats = sprintf('%-35s%-10d%-10d%-10d%-10d%-10d%-10d%-10d%-10d%-10d%-10d%-10d%-10d%-10d', ...
    ' ', round(duration), round(statsLR(2)), round(statsLR(3)), round(statsLR(4)), ...
    round(statsLR(5)), round(statsLR(6)), round(statsLR(7)), round(statsLR(8)), ...
    round(statsLR(9)), round(statsLR(10)), round(statsLR(11)), round(statsLR(12)), round(statsLR(13)));

[stats(2), stats(3), ~, ~, ~, ~] = calc_temp_stats([statsLR(2),statsLR(8)], [statsLR(3),statsLR(9)]);
[~, ~, stats(4), stats(5), ~, ~] = calc_temp_stats([statsLR(4),statsLR(10)], [statsLR(5),statsLR(11)]);
[~, ~, ~, ~, stats(6), stats(7)] = calc_temp_stats([statsLR(6),statsLR(12)], [statsLR(7),statsLR(13)]);

combined_header = 'Experimental stats: combined';
combined_header_line = sprintf('%-35s%-10s', ' ', combined_header);
combined_underline = sprintf('%-35s%s', ' ', repmat('-', 1, length(combined_header)));

combined_column_header = sprintf('%-35s%-10s%-10s%-10s%-10s%-10s%-10s%-10s%-10s%-10s', ...
    ' ', 'Duration', 'Max', 'E Max', 'Min', 'E Min', 'Mean', 'E Mean', '+error', '-error');

stats_line = sprintf('%-35s%-10d%-10d%-10d%-10d%-10d%-10d%-10d%-10d%-10d', ...
    ' ', round(duration), round(stats(2)), round(stats(3)), ...
    round(stats(4)), round(stats(5)), round(stats(6)), round(stats(7)), ...
    round(stats(2)-stats(6)), round(stats(6)-stats(4)));

exp_details_header = sprintf('%-35s%-10s', ' ', 'Experimental details');
exp_details_underline = sprintf('%-35s%s', ' ', repmat('-', 1, length('Experimental details')));

exp_details_lines = {
    sprintf('%-35s%s', ' ', ['Calibration file (L): ', char(get(handles.edit_calname_left,'string'))]);
    sprintf('%-35s%s', ' ', ['Calibration file (R): ', char(get(handles.edit_calname_right,'string'))]);
    sprintf('%-35s%s', ' ', ['Background file:      ', char(get(handles.edit_Background_File,'string'))]);
    sprintf('%-35s%s', ' ', ['Left ROI:             ', char(get(handles.edit_ROI_min_left,'string')), ' - ', char(get(handles.edit_ROI_max_left,'string'))]);
    sprintf('%-35s%s', ' ', ['Right ROI:            ', char(get(handles.edit_ROI_min_right,'string')), ' - ', char(get(handles.edit_ROI_max_right,'string'))]);
    sprintf('%-35s%s', ' ', ['auto_rotate:          ', onoff(get(handles.radiobutton_auto_rotate,'value'))]);
    sprintf('%-35s%s', ' ', ['t_correction:         ', onoff(get(handles.radiobutton_T_correction,'value'))]);
    sprintf('%-35s%s', ' ', ['w_emissivity:         ', onoff(get(handles.radiobutton_W_emissivity,'value'))]);
    sprintf('%-35s%s', ' ', ['sum_data:             ', onoff(get(handles.radiobutton_sum,'value'))]);
    sprintf('%-35s%s', ' ', ['subtract_background:  ', onoff(get(handles.radiobutton_subtract_background,'value'))]);
    sprintf('%-35s%s', ' ', ['smoothing:            ', num2str(get(handles.slider_smooth,'value'))]);
    sprintf('%-35s%s', ' ', ['trim_error:           ', num2str(get(handles.slider_error_trim,'value'))]);
    sprintf('%-35s%s', ' ', ['trim_snr:             ', num2str(get(handles.slider_sn_trim,'value'))]);
    };

output_strings = [
    {''; ...
     left_right_header_line; left_right_underline; left_right_stats; ''; ...
     combined_header_line; combined_underline; combined_column_header; stats_line; ''; ...
     exp_details_header; exp_details_underline};
    exp_details_lines
];

% Print to command line
fprintf('%s\n', output_strings{:});

% Append to file
fid = fopen(filepath, 'a');
if fid == -1
    error('Cannot open file for writing: %s', filepath);
end

fprintf(fid, '%s\n', output_strings{:});
fclose(fid);
end

function buttonstate = onoff(buttonvalue)
if buttonvalue == 1
    buttonstate = 'ON';
else
    buttonstate = 'OFF';
end
end