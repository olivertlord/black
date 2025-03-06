function update_button_states(flag, handles)
% UPDATE_BUTTON_STATES Updates the enabled state and appearance of UI controls.
%
% This function modifies the state (enabled/disabled) and background color 
% of a set of buttons and controls in a MATLAB GUI based on the provided flags.
%
% INPUTS:
%   flag    - Cell array, specifies the state for each control in `buttonHandles`.
%             Expected values:
%             * 0: Disable the control (set 'Enable' to 'off', gray out background if applicable).
%             * 1: Enable the control (set 'Enable' to 'on', color background green if applicable).
%   handles - Struct, contains GUI handles for various UI elements.
%
% FUNCTIONALITY:
% - Defines a list of UI elements to be updated.
% - Iterates over the elements and applies the corresponding properties.
% - Prevents errors by checking if each UI element is valid.
% - Ensures that radio buttons do not change background color.
%
% EXAMPLE USAGE:
%   update_button_states({1, 0, 1, 1, 0, 1, 0, 1, 0, 1}, handles);

% List of handle objects to be controlled
buttonHandles = [
    handles.pushbutton_update_calibration_files, ...
    handles.pushbutton_unknown_file, ...
    handles.pushbutton_decrement, ...
    handles.pushbutton_increment, ...
    handles.pushbutton_live, ...
    handles.pushbutton_process, ...
    handles.pushbutton_rotate, ...
    handles.pushbutton_clear_figures, ...
    handles.pushbutton_quit, ...
    handles.pushbutton_update_hardware_parameters, ...
    handles.edit_wavelength_min_left, ...
    handles.edit_wavelength_max_left, ...
    handles.edit_ROI_min_left, ...
    handles.edit_ROI_max_left, ...
    handles.edit_wavelength_min_right, ...
    handles.edit_wavelength_max_right, ...
    handles.edit_ROI_min_right, ...
    handles.edit_ROI_max_right, ...
    handles.pushbutton_background_file, ...
    handles.radiobutton_sum, ...
    handles.radiobutton_subtract_background
];

% Loop through handle objects and set properties based on flag
for i = 1:numel(buttonHandles)
    % Check if the handle is valid (prevents crashes)
    if isvalid(buttonHandles(i))
        % Get the type of UI control
        controlType = get(buttonHandles(i), 'Style');
        
        % Set properties based on flag
        switch flag{i}
            case 0
                set(buttonHandles(i), 'Enable', 'off');
                if ~strcmp(controlType, 'radiobutton')
                    set(buttonHandles(i), 'BackgroundColor', [0.8, 0.8, 0.8]);
                end
            case 1
                set(buttonHandles(i), 'Enable', 'on');
                if ~strcmp(controlType, 'radiobutton')
                    set(buttonHandles(i), 'BackgroundColor', [0, 0.8, 0]);
                end
        end
    end
end