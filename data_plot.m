function data_plot(handles, nw, fitl, fitr, Jl, Jr, idxl, idxr, lpixl, hpixl, lpixr, hpixr, ...
    mnrowl, mxrowl, mnrowr, mxrowr, microns_l, microns_r, Tl, Tr, el, er, maxtempl, mintempl, meantempl, ...
    maxtempr, mintempr, meantempr, emaxl, eminl, emeanl, emaxr, eminr, emeanr, ...
    elapsedSec)
% DATA_PLOT Plots various temperature-related data visualizations.
%
%   This function generates and updates multiple plots, including Wien fits, residuals,
%   temperature cross-sections, and temperature history. It takes input data related to 
%   fitted curves, residuals, temperature distributions, and elapsed time, then updates 
%   the corresponding GUI plots.
%
% Inputs:
%   handles     - Structure containing handles to GUI components.
%   nw          - Normalized wavelength values.
%   fitl, fitr  - Fitted Wien functions for left and right sides.
%   Jl, Jr      - Measured intensity values for left and right sides.
%   idxl, idxr  - Indices corresponding to the selected fits.
%   lpixl, hpixl - Lower and upper pixel bounds for the left ROI.
%   lpixr, hpixr - Lower and upper pixel bounds for the right ROI.
%   mnrowl, mxrowl - Minimum and maximum pixel rows for left temperature cross-section.
%   mnrowr, mxrowr - Minimum and maximum pixel rows for right temperature cross-section.
%   microns_l, microns_r - Micron values for left and right cross-sections.
%   Tl, Tr      - Temperature values for left and right sides.
%   el, er      - Temperature error values for left and right sides.
%   maxtempl, mintempl, meantempl - Max, min, and mean temperature values (left).
%   maxtempr, mintempr, meantempr - Max, min, and mean temperature values (right).
%   emaxl, eminl, emeanl - Errors corresponding to max, min, and mean temperatures (left).
%   emaxr, eminr, emeanr - Errors corresponding to max, min, and mean temperatures (right).
%   elapsedSec  - Time elapsed for each measurement (used for history plot).
%
% Outputs:
%   None. The function directly modifies the GUI plots.
%
% Example:
%   data_plot(handles, nw, fitl, fitr, Jl, Jr, idxl, idxr, lpixl, hpixl, lpixr, hpixr, ...
%       mnrowl, mxrowl, mnrowr, mxrowr, microns_l, microns_r, Tl, Tr, el, er, ...
%       maxtempl, mintempl, meantempl, maxtempr, mintempr, meantempr, ...
%       emaxl, eminl, emeanl, emaxr, eminr, emeanr, elapsedSec);

% Plot Wien left data
plot_wien(handles.plot_wien_left, nw, fitl(:, idxl), Jl(:, idxl), lpixl, hpixl, 'r');

% Plot Wien right data
plot_wien(handles.plot_wien_right, nw, fitr(:, idxr), Jr(:, idxr), lpixr, hpixr, 'g');

% Plot Residuals left
plot_residuals(handles.plot_residuals_left, nw, fitl(:, idxl), Jl(:, idxl), lpixl, hpixl, 'r');

% Plot Residuals right
plot_residuals(handles.plot_residuals_right, nw, fitr(:, idxr), Jr(:, idxr), lpixr, hpixr, 'g');

% Plot Section left
plot_section(handles.plot_section_left, handles.plot_section_pixels_left, handles.text_max_left, handles.text_min_left,...
    handles.text_average_left, ...
    mnrowl, mxrowl, microns_l, Tl, el, maxtempl, mintempl, meantempl, emaxl, eminl, emeanl, 'r');

% Plot Section right
plot_section(handles.plot_section_right, handles.plot_section_pixels_right, handles.text_max_right,...
    handles.text_min_right, handles.text_average_right, ...
    mnrowr, mxrowr, microns_r, Tr, er, maxtempr, mintempr, meantempr, emaxr, eminr, emeanr, 'g');

% Plot History
plot_history(handles.plot_history, elapsedSec, ...
    meantempl, emeanl, maxtempl, emaxl, ...
    meantempr, emeanr, maxtempr, emaxr);

drawnow;
end

% HELPER FUNCTION: PLOT WIEN ------------------------------------------------------------------------------------------------
function plot_wien(ax, x, fit, J, lpix, hpix, color)
% Clear the current axes
cla(ax)

% Plot fit curve
plot(ax, x(lpix:hpix), fit, '-', 'Color', color, 'LineWidth', 2);
hold(ax, "on");

% Plot all data points
plot(ax, x, J, 'o', 'Color', [0.5 0.5 0.5], 'MarkerFaceColor', [0.5 0.5 0.5], 'MarkerSize', 1);

% Plot selected range points
plot(ax, x(lpix:hpix), J(lpix:hpix), 'o', 'Color', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 1);

% Update tick format
ytickformat(ax, '%.0f')

% Set y-limits to auto
ylim(ax, 'auto');
end

% HELPER FUNCTION: PLOT_RESIDUALS -------------------------------------------------------------------------------------------
function plot_residuals(ax, x, fit, J, lpix, hpix, color)
cla(ax)

% Plot baseline
plot(ax, x, zeros(1, length(x)), '-', 'Color', color, 'LineWidth', 2); 
hold(ax, "on");

% Plot residuals
plot(ax, x(lpix:hpix), J(lpix:hpix) - fit, 'o', 'Color', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 1);

% Update tick format
ytickformat(ax, '%.2f')
ylim(ax, 'padded')

end

% HELPER FUNCTION: PLOT_SECTIONS --------------------------------------------------------------------------------------------
function plot_section(ax_microns, ax_pixels, text_max, text_min, text_avg, mnrow, mxrow, microns, T, e, maxT, minT,...
    meanT, emax, emin, emean, color)

% Plot data with error bars
errorbar(ax_microns, microns, T, e, 'Color', color);

% Set stats text
set(text_max, 'string', sprintf('Max = %.0f±%.0f', maxT, emax));
set(text_min, 'string', sprintf('Min = %.0f±%.0f', minT, emin));
set(text_avg, 'string', sprintf('Average = %.0f±%.0f', meanT, emean));

% Set limits and formats
xlim(ax_microns, [microns(1) microns(end)]);
xlim(ax_pixels, [mnrow, mxrow])
ytickformat(ax_microns,'%.0f')
end

% HELPER FUNCTION: PLOT_HISTORY ---------------------------------------------------------------------------------------------
function plot_history(ax, elapsedSec, meanTl, emeansl, maxTl, emaxl, meanTr, emeanr, maxTr, emaxr)
errorbar(ax, elapsedSec, meanTl, emeansl, '-o', 'Color', 'r', 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r');
hold(ax, "on");
errorbar(ax, elapsedSec, maxTl, emaxl, '-s', 'Color', 'r', 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r');
errorbar(ax, elapsedSec, meanTr, emeanr, '-o', 'Color', 'g', 'MarkerEdgeColor', 'g', 'MarkerFaceColor', 'g');
errorbar(ax, elapsedSec, maxTr, emaxr, '-s', 'Color', 'g', 'MarkerEdgeColor', 'g', 'MarkerFaceColor', 'g');
end