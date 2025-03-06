function update_axes(ax, xlab, ylab, title_string, yloc, replace, auto, ylim1, ylim2, xlim1, xlim2)
% UPDATE_AXES Configures plot axes with specified labels, title, and limits.
%
% This function updates the properties of a given axes object within a GUI, 
% setting labels, titles, axis locations, limits, and plot behavior based on 
% user-defined inputs.
%
% INPUTS:
%   handles      - Struct, contains GUI handle elements.
%   plot_name    - String, name of the target plot (corresponding to a field in handles).
%   xlab         - String, label for the x-axis.
%   ylab         - String, label for the y-axis.
%   title_string - String, title for the plot.
%   yloc         - String, position of the y-axis ('left' or 'right').
%   replace      - Boolean (1 to replace existing plot, 0 to add to the current plot).
%   auto         - Boolean (1 for automatic axis limits, 0 for manual limits).
%   ylim1, ylim2 - Numeric, manual y-axis limits (ignored if auto = 1).
%   xlim1, xlim2 - Numeric, manual x-axis limits (ignored if auto = 1).
%
% FUNCTIONALITY:
% - Retrieves the axes object from handles.
% - Updates axis labels and font size.
% - Special handling for plots containing "Wien" in the name:
%   - Removes the first y-tick label (if applicable).
%   - Removes all x-tick labels.
% - Adjusts y-axis location (left or right).
% - Sets plot mode (replace or add).
% - Applies either auto-scaling or manual axis limits.
% - Ensures the title does not interpret underscores as subscripts.
%
% EXAMPLE USAGE:
%   update_axes(handles, 'plot_example', 'Wavelength (nm)', 'Intensity (a.u.)', ...
%               'Spectrum Plot', 'left', 1, 0, 0, 100, 400, 700);

% Get name of plot
plot_name = get(ax, 'Tag');

% Set axis labels with specified font size
xlabel(ax, xlab, 'FontSize', 12);
ylabel(ax, ylab, 'FontSize', 12);

% Special handling for titles containing "Wien"
if contains(plot_name, 'Wien', 'IgnoreCase', true)
    yticklabels = get(ax, 'YTickLabel');  % Get the current y-tick labels
    if ~isempty(yticklabels) && iscell(yticklabels)
        yticklabels{1} = '';  % Remove the first y-tick label
        set(ax, 'YTickLabel', yticklabels);  % Apply the modified y-tick labels
    end
    set(ax, 'XTickLabel', []);  % Remove all x-tick labels
end

% Set the position of the y-axis (left or right)
set(ax, 'YAxisLocation', yloc);

% Set the 'NextPlot' property (replace or add)
if replace == 1
    set(ax, 'NextPlot', 'replacechildren');
else
    set(ax, 'NextPlot', 'add');
end

% Set axis limits (either auto or manual)
if auto == 1
    ylim(ax, 'auto');
    xlim(ax, 'auto');
else
    ylim(ax, [ylim1 ylim2]);
    xlim(ax, [xlim1 xlim2]);
end

% Set title without LaTeX interpretation to prevent underscores from making subscripts
title(ax, title_string, 'Interpreter', 'none');

end