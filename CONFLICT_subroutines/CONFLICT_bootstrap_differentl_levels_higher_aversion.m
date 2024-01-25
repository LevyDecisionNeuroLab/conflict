function p_value = CONFLICT_bootstrap_differentl_levels_higher_aversion(level_40_participant_mean,level_25_participant_mean, level_10_participant_mean)
%CONFLICT_BOOTSTRAP_DIFFERENTL_LEVELS_HIGHER_AVERSION Summary of this function goes here
%   Detailed explanation goes here
true_population_diff_over_levels = sum((level_40_participant_mean - level_25_participant_mean)+(level_25_participant_mean-level_10_participant_mean));

participant_mean_over_all_levels = mean([level_40_participant_mean,  level_25_participant_mean, level_10_participant_mean], 2);
N_TRIALS = length(level_40_participant_mean);
N_SIMULATION_REPETITION = 1e3;
simulated_population_diff_over_levels = zeros(1, N_SIMULATION_REPETITION);
for ii=1:N_SIMULATION_REPETITION
    simulated_10 = binornd(N_TRIALS, participant_mean_over_all_levels)./N_TRIALS;
    simulated_25 = binornd(N_TRIALS, participant_mean_over_all_levels)./N_TRIALS;
    simulated_40 = binornd(N_TRIALS, participant_mean_over_all_levels)./N_TRIALS;
    simulated_population_diff_over_levels(ii) = sum((simulated_40 - simulated_25)+(simulated_25-simulated_10));
end

p_value = mean(true_population_diff_over_levels < simulated_population_diff_over_levels);
end

