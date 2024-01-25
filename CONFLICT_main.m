CONSTANTS = CONFLICT_constants();
addpath('CONFLICT-data\')
addpath('CONFLICT_helper_functions\')
addpath('CONFLICT_plotting')
addpath('CONFLICT_subroutines')
addpath('CONFLICT_parameter_fitting\')
addpath('CONFLICT_generate_reports\')
%% Exclude invalid participants
CONFLICT_print_section_seperator("Participants - number, exclusion, participation time")
[data, n_initial_participants, n_valid] = CONFLICT_return_valid_participants(false);

%% Proportion of choices in risk
figure('Position', [470 647.6667 1.7157e+03 590.3333], 'Name', 'Fig. 2 - proportion of choices')
risk_choice = CONFLICT_get_risk_data(data);
subplot(1, 3, 1)
CONFLICT_plot_risk_proportion(risk_choice);

% Choices in ambiguity and conflict
[ambig_choice_table, participant_ambig_mean] = CONFLICT_get_ambig_data(data);
[conflict_choice_table, participant_conflict_mean] = CONFLICT_get_conflict_data(data);

subplot(1, 3, [2 3])
CONFLICT_plot_proportion_by_conflict_magnitude(conflict_choice_table, ambig_choice_table);

%% Two ways ANOVA - (conflict vs. ambig) <-> (10, 25, 40)
CONFLICT_print_section_seperator("Compare conflict and ambiguity")
CONFLICT_ambig_conflict_anova(ambig_choice_table, conflict_choice_table)

% Permutation test - greater levels of conflit are associated with greater aversion
[p_value_bootstrap_ambig, p_value_bootsrap_conflict] = ...
    CONFLICT_test_greater_level_uncertinty_lower_preference(ambig_choice_table, conflict_choice_table);

%% Estimate participants' model-based parameters
participants = CONFLICT_fit_all_participants(data, ambig_choice_table, conflict_choice_table, risk_choice);

% Correlation between risk, and ambiguity and conflict attitude
CONFLICT_report_correlation([participants.mean_risk],[participants.mean_ambig_corrected], 'Mean risk', 'Mean ambiguity (corrected)');
CONFLICT_report_correlation([participants.mean_risk],[participants.mean_conflict_corrected], 'Mean risk', 'Mean conflict (corrected)');
% CONFLICT_plot_correlation_between_behavioral_params(participants)

%% Compare conflict and ambiguity
figure('Position', [712 380 977 893], 'Name', 'Fig. 3 - Conflict vs. Ambiguity')
CONFLICT_print_section_seperator('Compare conflict and ambiguity')

participant_mean_risk = mean(table2array(risk_choice),2);
corrected_conflict = participant_conflict_mean - participant_mean_risk;
corrected_ambig = participant_ambig_mean - participant_mean_risk;
subplot(2,2,1); % Figure 3.a
[r_conflict_ambig, p_conflict_ambig] = CONFLICT_plot_corrected_conflict_vs_ambiguity(corrected_conflict,corrected_ambig);
CONFLICT_report_conflict_vs_ambiguity_participants_preference(corrected_conflict, corrected_ambig)

% Conflict vs. Ambiguity -  bar graph
subplot(2,2,2); % Figure 3.b
participant_mean_conflict_ambiguity = CONFLICT_conflict_vs_ambiguity(data);
CONFLICT_print_mean_and_sem(participant_mean_conflict_ambiguity, 'conflicted option')

% Explicit preference reversal
subplot(2,2,[3 4]); % Figure 3.c

CONFLICT_plot_preference_reversal(participant_mean_conflict_ambiguity,participant_conflict_mean, participant_ambig_mean);

fprintf(['Per participant, %.1f%% of the participants chose the' ...
    ' ambiguous alternative more often than the conflicted one\n'], ...
    100*mean(participant_mean_conflict_ambiguity<=0.5));

% Conflict vs. Ambiguity - anova
[p_probability, p_spread, p_interaction] = anova_2_way_anova_conflict_vs_ambiguity_spread(data);

%% Indirect comparison (conflict vs. certain) vs. (ambiguity vs. certain)
indirect_comparison = participant_conflict_mean./(participant_conflict_mean+participant_ambig_mean);
indirect_comparison(isnan(indirect_comparison)) = 0.5;

%% Subjective probaiblity
figure('Position', [484 681 1463 587], 'Name', 'Fig. 4 - subjective probability')
CONFLICT_theoretical_extreme_probabilities();

%% Big 5 correaltion with attitudes
figure('Name', 'Fig. S1 - subjective probability')
CONFLICT_print_section_seperator('Big 5')
[big_5, big_5_values, big_5_trait_names] = CONFLICT_big_5(data, ...
    participant_conflict_mean, participant_ambig_mean, ...
    participant_mean_conflict_ambiguity, corrected_conflict);

%% Anticipatory regret
CONFLICT_print_section_seperator('Regret analysis')
CONFLICT_regret_analysis(data, participant_mean_conflict_ambiguity, corrected_conflict, indirect_comparison, big_5_values);

%% Probability estimation

figure
%           40-60,      , 25-75      , 10-90 
ambiguity_estimation = [data.Q253_1, data.Q255_1, data.Q256_1]; 
conflict_estimation = [data.Q257_1, data.Q258_1, data.Q259_1];
CONFLICT_SEEKING_COLOR = '#f5e042';
CONFLICT_AVERSION_COLOR = '#ed6ded';
hold on;
cla
plot(conflict_estimation(conflict_estimation(:, 1)<=conflict_estimation(:, 3),:)', 'Color', CONFLICT_SEEKING_COLOR)
bar(mean(conflict_estimation(conflict_estimation(:, 1)<=conflict_estimation(:, 3),:)), 'FaceColor', CONFLICT_SEEKING_COLOR, FaceAlpha=0.5)
errorbar(1:3, mean(conflict_estimation(conflict_estimation(:, 1)<=conflict_estimation(:, 3),:)), sem(conflict_estimation(conflict_estimation(:, 1)<=conflict_estimation(:, 3),:)), 'k', 'LineWidth',2)

indices_estimation_decreases_with_range = conflict_estimation(:, 1)>conflict_estimation(:, 3);
plot(conflict_estimation(conflict_estimation(:, 1)>conflict_estimation(:, 3),:)', 'Color', CONFLICT_AVERSION_COLOR)
bar(mean(conflict_estimation(conflict_estimation(:, 1)>conflict_estimation(:, 3),:)), 'FaceColor', CONFLICT_AVERSION_COLOR, FaceAlpha=0.5)
errorbar(1:3, mean(conflict_estimation(conflict_estimation(:, 1)>conflict_estimation(:, 3),:)), sem(conflict_estimation(conflict_estimation(:, 1)>conflict_estimation(:, 3),:)), 'k', 'LineWidth',2)

yline(50,'k--', 'LineWidth', 1)

set(gca, 'XTick', 1:3, 'XTickLabel',{'40%-60%', '25%-75%', '10%-90%'})
b = bar(1:3, [mean(conflict_estimation); mean(ambiguity_estimation)]);
b(1).FaceColor = CONSTANTS.COLORS.CONFLICT;
b(2).FaceColor = CONSTANTS.COLORS.AMBIGUITY;
yline(50, 'k--')
xlabel('Probability range', 'FontSize',18,'FontWeight','bold')
ylabel('Estimated probability', 'FontSize',18,'FontWeight','bold')
set(gca,'FontSize', 16)
