function plot_axes(xlab, ylab, title_string, yloc, replace)

xlabel(xlab, 'FontSize', 12);
ylabel(ylab, 'FontSize', 12);
title(title_string, 'FontSize', 14);
set(gca,'YAxisLocation',yloc)
if replace == 1
    set(gca,'NextPlot','replacechildren') ;
else
    set(gca,'NextPlot','Add') ;
end

% Sets plot attributes and is called whenever data is plotted