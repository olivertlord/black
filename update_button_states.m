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
buttonHandles = {
    'pushbutton_update_calibration_files', ...
    'pushbutton_unknown_file', ...
    'pushbutton_decrement', ...
    'pushbutton_increment', ...
    'pushbutton_live', ...
    'pushbutton_process', ...
    'pushbutton_rotate', ...
    'pushbutton_clear_figures', ...
    'pushbutton_quit', ...
    'pushbutton_update_hardware_parameters', ...
    'edit_wavelength_min_left', ...
    'edit_wavelength_max_left', ...
    'edit_ROI_min_left', ...
    'edit_ROI_max_left', ...
    'edit_wavelength_min_right', ...
    'edit_wavelength_max_right', ...
    'edit_ROI_min_right', ...
    'edit_ROI_max_right', ...
    'pushbutton_background_file', ...
    'radiobutton_sum', ...
    'radiobutton_subtract_background'
};

% Loop through handle objects and set properties based on flag
for i = 1:numel(buttonHandles)
    field = buttonHandles{i};
    if isfield(handles, field) && isvalid(handles.(field))
        h = handles.(field);
        controlType = get(h, 'Style');
        switch flag{i}
            case 0
                set(h, 'Enable', 'off');
                if ~strcmp(controlType, 'radiobutton')
                    set(h, 'BackgroundColor', [0.8, 0.8, 0.8]);
                end
            case 1
                set(h, 'Enable', 'on');
                if ~strcmp(controlType, 'radiobutton')
                    set(h, 'BackgroundColor', [0, 0.8, 0]);
                end
        end
    end
end