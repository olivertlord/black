function plot_axes(handles, plot_name, xlab, ylab, title_string, yloc, replace, auto, ylim1, ylim2, xlim1, xlim2)
% plot_axes configures axes with specified labels, title, and limits.
%
% Inputs:
%   handles         - Structure of handles (used to select the axes)
%   plot_name       - Name of the plot to modify (string)
%   xlab            - Label for the x-axis (string)
%   ylab            - Label for the y-axis (string)
%   title_string    - Title for the plot (string)
%   yloc            - Position of the y-axis ('left' or 'right')
%   replace         - Boolean (1 to replace, 0 to add to existing plot)
%   auto            - Boolean (1 for auto limits, 0 for manual limits)
%   ylim1, ylim2    - Y-axis limits for manual adjustment (numeric)
%   xlim1, xlim2    - X-axis limits for manual adjustment (numeric)

% Ensure plot_name exists in handles
if ~isfield(handles, plot_name)
    error('Plot name "%s" not found in handles.', plot_name);
end

% Select the axes for plotting
axes(handles.(plot_name));

% Set axis labels with specified font size
xlabel(xlab, 'FontSize', 12);
ylabel(ylab, 'FontSize', 12);

% Special handling for titles containing "Wien"
if startsWith(title_string, 'Wien', 'IgnoreCase', true)
    ax = gca;
    yticklabels = get(ax, 'YTickLabel');  % Get the current y-tick labels
    yticklabels{1} = '';  % Remove the first y-tick label
    set(ax, 'YTickLabel', yticklabels);  % Apply the modified y-tick labels
    set(ax, 'XTickLabel', []);  % Remove all x-tick labels
end

% Set the position of the y-axis (left or right)
set(gca, 'YAxisLocation', yloc);

% Set the 'NextPlot' property (replace or add)
if replace == 1
    set(gca, 'NextPlot', 'replacechildren');
else
    set(gca, 'NextPlot', 'add');
end

% Set axis limits (either auto or manual)
if auto == 1
    ylim('auto');
    xlim('auto');
else
    ylim([ylim1 ylim2]);
    xlim([xlim1 xlim2]);
end

% Only add title if not "Cross-sections" or "Wien fits"
if ~ismember(title_string, {'Cross-sections', 'Wien fits'})
    title(title_string, 'FontSize', 14);
end
end