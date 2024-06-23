function [nor_runup,overtopping,nor_robustness,serviceability] = FFF_outputs_box_averaging (wave_poweri,x,Dataset)


Hswi = x(1);
Avi = x(2);
Nvi = x(3);

% Extract columns for easier access
wave_power = Dataset(:, 3);


% 1. Find rows with the closest wave power
[~, idx] = min(abs(wave_power - wave_poweri));
closest_wave_power = wave_power(idx);
feasible_set_indices = wave_power == closest_wave_power;
feasible_set = Dataset(feasible_set_indices, :);

% 2. Select rows with the closest Hsw (64 rows)
[~, Hsw_dist_indices] = sort(abs(feasible_set(:, 4) - Hswi));
selected_Hsw_indices = Hsw_dist_indices(1:64);
selected_Hsw = feasible_set(selected_Hsw_indices, :);

% 3. From those, select rows with the closest Av (16 rows)
[~, Av_dist_indices] = sort(abs(selected_Hsw(:, 6) - Avi));
selected_Av_indices = Av_dist_indices(1:16);
selected_Av = selected_Hsw(selected_Av_indices, :);

% 4. From those, select rows with the closest Nv (4 rows)
[~, Nv_dist_indices] = sort(abs(selected_Av(:, 5) - Nvi));
selected_Nv_indices = Nv_dist_indices(1:4);
selected_Nv = selected_Av(selected_Nv_indices, :);

% 5. Average the inputs and outputs of the 4 selected rows
avg_values = mean(selected_Nv, 1);

nor_runup       = avg_values(7);
overtopping     = avg_values(8);
nor_robustness  = avg_values(9);
serviceability  = avg_values(10);
