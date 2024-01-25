function CONFLICT_ambig_conflict_anova(ambig_choice_table, conflict_choice_table)
%CONFLICT_COMPARE_AMGIG_CONFLICT_PROPORTIONS Summary of this function goes here
%   Detailed explanation goes here

specific_levels = [10, 25, 40];

ambig_participant_mean = cell(1, numel(specific_levels));
conflict_participant_mean = cell(1, numel(specific_levels));

for i = 1:numel(specific_levels)
    specific_level = specific_levels(i);
    
    % Ambiguity
    ambig_table = ambig_choice_table(specific_level);
    ambig_table = ambig_table{1};
    ambig_participant_mean{i} = mean(table2array(ambig_table), 2);
    
    % Conflict
    conflict_table = conflict_choice_table(specific_level);
    conflict_table = conflict_table{1};
    conflict_participant_mean{i} = mean(table2array(conflict_table), 2);
end


% Assuming you have 'ambig_participant_mean' and 'conflict_participant_mean' cell arrays defined.

% Combine the data and create grouping variables
data = [vertcat(ambig_participant_mean{:}); vertcat(conflict_participant_mean{:})];

num_participants = size(ambig_participant_mean{1}, 1);
num_levels = numel(specific_levels);

% Create grouping variables
group_dec_type = [repmat({'Ambiguity'}, num_participants*num_levels, 1); repmat({'Conflict'}, num_participants*num_levels, 1)];
group_levels = repmat(cellstr(num2str(specific_levels')), num_participants*2, 1);

% Reshape data and grouping variables to fit the ANOVA function
data_reshaped = reshape(data', [], 1);
group_dec_type_reshaped = reshape(group_dec_type, [], 1);
group_levels_reshaped = reshape(group_levels, [], 1);

% Perform the two-way ANOVA
[anova_p, tbl, stats] = anovan(data_reshaped, {group_dec_type_reshaped, group_levels_reshaped}, 'model', 'interaction', 'varnames', {'Decision Type', 'Levels'});

% Assuming you have the mean_conflict and sem_conflict as mean and standard error for conflict choices
% and mean_ambig and sem_ambig as mean and standard error for ambiguous choices, and p_value as the p-value from the two-way ANOVA.
participant_mean_conflict_over_levels = mean([conflict_participant_mean{:}],2);
mean_conflict = mean(participant_mean_conflict_over_levels);
sem_conflict = sem(participant_mean_conflict_over_levels);
participant_mean_ambiguity_over_levels = mean([ambig_participant_mean{:}],2);
mean_ambig = mean(participant_mean_ambiguity_over_levels);
sem_ambig = sem(participant_mean_ambiguity_over_levels);

fprintf(['Overall, participants chose the conflicted alternatives in %.1f%%±%.1f%% of the trials\n ' ...
    'significantly more frequently than the choices in the ambiguous alternative %.1f%%±%.1f%% (2-ways ANOVA, p=%.3f, DF = %d). \n\n'], ...
   mean_conflict*100, sem_conflict*100,  mean_ambig*100, sem_ambig*100, anova_p(1), tbl{2, 3});
%%
% Print the results
fprintf('Results of Two-Way ANOVA:\n');

fprintf('\tEffect of Decision Type (Ambiguity vs. Conflict):\n');
fprintf('\t\tF-Value: %.4f\n', tbl{2, 6});
fprintf('\t\tp-Value: %.4f\n', anova_p(1));
fprintf('\t\tDegrees of Freedom (DF): %d\n', tbl{2, 3});

fprintf('\tEffect of Levels (10, 25, 40):\n');
fprintf('\t\tF-Value: %.4f\n', tbl{3, 6});
fprintf('\t\tp-Value: %.4f\n', anova_p(2));
fprintf('\t\tDegrees of Freedom (DF): %d\n', tbl{3, 3});

fprintf('\tInteraction Effect (Decision Type x Levels):\n');
fprintf('\t\tF-Value: %.4f\n', tbl{4, 6});
fprintf('\t\tp-Value: %.4f\n', anova_p(3));
fprintf('\t\tDegrees of Freedom (DF): %d\n', tbl{4, 3});




end

