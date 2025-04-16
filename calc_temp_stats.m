function [maximum, maximum_err, minimum, minimum_err, weighted_mean, weighted_mean_err] = calc_temp_stats(value, error)

% Convert to double to prevent integer overflow and division issues
value = double(value);
error = double(error);

% Compute minima and maxima
[maximum, idx] = max(value);
maximum_err = error(idx);
[minimum, idx] = min(value);
minimum_err = error(idx);

% Compute weighted mean and uncertainty
weights = 1 ./ (error.^2);
weighted_mean = sum(value .* weights, 'omitnan') / sum(weights, 'omitnan');
%weighted_mean_err = ((1 / sum(weights, 'omitnan')) * sqrt(sum((weights .* error).^2, 'omitnan'))) + mean(error, 'omitnan');
weighted_mean_err = std(value,'omitnan')*2;
end