function update_ROI_pos(ROI_pos)
%UNTITLED Updates the values in the text boxes based on the user draggable
%ROI boxes

handles = getappdata(0,'handles');
% Get handles structure from appdata

if ROI_pos(2) > 127
    set(handles.edit9,'string',num2str(round(ROI_pos(2))))
    set(handles.edit10,'string',num2str(round(ROI_pos(2))+round(ROI_pos(4))))
else
    set(handles.edit17,'string',num2str(round(ROI_pos(2))))
    set(handles.edit18,'string',num2str(round(ROI_pos(2))+round(ROI_pos(4))))
end
% Determines whether function has been called by the left or right ROI box
% based on the x-pixel position (right nor left cannot extend beyond
% 256/2). Updates values in text boxes based on ROI position.

