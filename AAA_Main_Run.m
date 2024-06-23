% NSGA-II
clc
clear all
close all
%% Initialization
pop         = 150; % population , min = 20 % best : 150
gen         = 300; % generations, min = 5 % best : 1000
M           = 3;  % number of objective, min = 2;
V           = 3;  % number of descision variables
lb          = [0.2 1 8]; % lower bounds
ub          = [1.29 36 500]; % upper bounds
wave_sce_max= 50; % number of wave scenarios
load('ZZZ_Dataset_noCost.mat','Dataset')

for wave_sce = 1:wave_sce_max
    disp(['> Processing the ',num2str(wave_sce), ' th', ' wave scenario ...'])
    Hs = Dataset(wave_sce,1);
    Tp = Dataset(wave_sce,2);
    wave_power = Dataset(wave_sce,3);
    %% Optimization core
    chromosome = nsga_2(pop, gen, M, V, lb, ub, wave_power,Dataset);

    chromosome(:, [V + M + 1, V + M + 2]) = []; % remove external data
    Results(wave_sce).result(:, 1) = transpose(Hs*ones(size(chromosome,1),1));          % Hs
    Results(wave_sce).result(:, 2) = transpose(Tp*ones(size(chromosome,1),1));          % Tp
    Results(wave_sce).result(:, 3) = transpose(wave_power*ones(size(chromosome,1),1));  % Wave power
    Results(wave_sce).result(:, 4) = round(chromosome(:, 1),1);                         % Hsw
    Results(wave_sce).result(:, 5) = round(chromosome(:, 2),1);                         % Av
    Results(wave_sce).result(:, 6) = round(chromosome(:, 3));                           % Nv
    Results(wave_sce).result(:, 7) = -chromosome(:, V + 1); % GEP Robustness
    Results(wave_sce).result(:, 8) = -chromosome(:, V + 2); % Serviceability - from my data
    Results(wave_sce).result(:, 9) = chromosome(:, V + 3); % Cost

    ZZZ_optimized_solutions(1).Results = Results;
end

save('ZZZ_Optimization_output.mat','Results')

disp('-------- Done! --------')
