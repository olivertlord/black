function plot_axes(xlab, ylab, title_string, yloc)

xlabel(xlab, 'FontSize', 12);
ylabel(ylab, 'FontSize', 12);
title(title_string, 'FontSize', 14);
set(gca,'YAxisLocation',yloc)
% Sets plot attributes and is called whenever data is plotted