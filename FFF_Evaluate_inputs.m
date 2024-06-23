function ZZZ_AvgOutput = FFF_Evaluate_inputs(data, wave_power, Hsw, Av, Nv, lb, ub)

% User input for ranges
Hsw_range = [lb(1) ub(1)];
Av_range = [lb(2) ub(2)];
Nv_range = [lb(3) ub(3)];

% Divide ranges into four equal intervals
Av_intervals = linspace(Av_range(1), Av_range(2), 5);
Nv_intervals = linspace(Nv_range(1), Nv_range(2), 5);
Hsw_intervals = linspace(Hsw_range(1), Hsw_range(2), 5);

% Find closest wave power
[~, idx] = min(abs(data(:,3) - wave_power));
closest_wave_power = data(idx,3);

% Select feasible set
feasibleSet = data(data(:,3) == closest_wave_power, :);

% Find input intervals
Av_bin = find(Av >= Av_intervals, 1, 'last');
Nv_bin = find(Nv >= Nv_intervals, 1, 'last');
Hsw_bin = find(Hsw >= Hsw_intervals, 1, 'last');

% Filter data points in the same interval
filteredData = feasibleSet(feasibleSet(:,4) >= Av_intervals(Av_bin) & feasibleSet(:,4) < Av_intervals(Av_bin + 1) & ...
                           feasibleSet(:,5) >= Nv_intervals(Nv_bin) & feasibleSet(:,5) < Nv_intervals(Nv_bin + 1) & ...
                           feasibleSet(:,6) >= Hsw_intervals(Hsw_bin) & feasibleSet(:,6) < Hsw_intervals(Hsw_bin + 1), :);


if isempty(filteredData)
    disp('No data found in the specified intervals.');
else
    ZZZ_AvgOutput(1) = mean(filteredData(:,5));            % Runup
    ZZZ_AvgOutput(2) = mean(filteredData(:,6));      % Overtopping
    ZZZ_AvgOutput(3) = mean(filteredData(:,7));       % Robustness
    ZZZ_AvgOutput(4) = mean(filteredData(:,8));   % Serviceability
end

end
