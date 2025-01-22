function update_ROI_pos(ROI_pos)
% Updates the ROI position values in the appropriate text boxes
% based on the input ROI position. Determines left or right ROI
% based on y-pixel threshold (127).

handles = getappdata(0, 'handles');  % Retrieve handles structure from appdata

% Determine if the ROI is on the left or right based on the y-coordinate
isLeft = ROI_pos(2) > 127;

% Select appropriate handle suffixes for left or right ROI
side = 'left';
if ~isLeft
    side = 'right';
end

% Precompute rounded ROI position values
yMin = round(ROI_pos(2));
yMax = yMin + round(ROI_pos(4));
xMin = round(ROI_pos(1));
xMax = xMin + round(ROI_pos(3));

% Update ROI min/max text boxes
set(handles.(['edit_ROI_min_' side]), 'string', num2str(yMin));
set(handles.(['edit_ROI_max_' side]), 'string', num2str(yMax));

% Update wavelength min/max text boxes
set(handles.(['edit_wavelength_min_' side]), 'string', num2str(xMin));
set(handles.(['edit_wavelength_max_' side]), 'string', num2str(xMax));
