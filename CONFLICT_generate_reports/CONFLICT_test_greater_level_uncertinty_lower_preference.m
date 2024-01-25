function [p_value_bootsrap_ambig, p_value_bootsrap_conflict] = ...
    CONFLICT_test_greater_level_uncertinty_lower_preference(ambig_choice_table, conflict_choice_table)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Function to calculate participant mean (same as before)
ambig_40 = ambig_choice_table(40);
ambig_40 = ambig_40{1};
ambig_40_participant_mean = mean(table2array(ambig_40),2);

ambig_25 = ambig_choice_table(25);
ambig_25 = ambig_25{1};
ambig_25_participant_mean = mean(table2array(ambig_25),2);

ambig_10 = ambig_choice_table(10);
ambig_10 = ambig_10{1};
ambig_10_participant_mean = mean(table2array(ambig_10),2);

conflict_40 = conflict_choice_table(40);
conflict_40 = conflict_40{1};
conflict_40_participant_mean = mean(table2array(conflict_40),2);

conflict_25 = conflict_choice_table(25);
conflict_25 = conflict_25{1};
conflict_25_participant_mean = mean(table2array(conflict_25),2);

conflict_10 = conflict_choice_table(10);
conflict_10 = conflict_10{1};
conflict_10_participant_mean = mean(table2array(conflict_10),2);

p_value_bootsrap_ambig = CONFLICT_bootstrap_differentl_levels_higher_aversion(ambig_40_participant_mean,ambig_25_participant_mean, ambig_10_participant_mean);
p_value_bootsrap_conflict = CONFLICT_bootstrap_differentl_levels_higher_aversion(conflict_40_participant_mean,conflict_25_participant_mean, conflict_10_participant_mean);

fprintf('Ambiguity, bootstrap: p-value = %.4f\n', p_value_bootsrap_ambig);
fprintf('Conflict, bootstrap: p-value = %.4f\n', p_value_bootsrap_conflict);
end
