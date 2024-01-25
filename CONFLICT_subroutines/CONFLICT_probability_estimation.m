% function CONFLICT_probability_estimation(data)
%CONFLICT_PROBABILITY_ESTIMATION Summary of this function goes here
%   Detailed explanation goes here
% Assuming you have loaded the 'ambiguity_estimation' and 'conflict_estimation' matrices

%% Data definition
ambiguity_estimation = [data.Q253_1, data.Q255_1, data.Q256_1]; 
conflict_estimation = [data.Q257_1, data.Q258_1, data.Q259_1];

%% Plotting
CONFLICT_SEEKING_COLOR = '#f5e042';
CONFLICT_AVERSION_COLOR = '#ed6ded';
hold on;
cla
plot(conflict_estimation(conflict_estimation(:, 1)<conflict_estimation(:, 3),:)', 'Color', CONFLICT_SEEKING_COLOR)
bar(mean(conflict_estimation(conflict_estimation(:, 1)<conflict_estimation(:, 3),:)), 'FaceColor', CONFLICT_SEEKING_COLOR, FaceAlpha=0.5)
errorbar(1:3, mean(conflict_estimation(conflict_estimation(:, 1)<conflict_estimation(:, 3),:)), sem(conflict_estimation(conflict_estimation(:, 1)<=conflict_estimation(:, 3),:)), 'k', 'LineWidth',2)

plot(conflict_estimation(conflict_estimation(:, 1)==conflict_estimation(:, 3),:)', 'Color', .5*[1 1 1])

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
%% 2-way anova
% Calculate the average and standard error for each column in each matrix
avg_std_ambiguity = [mean(ambiguity_estimation); std(ambiguity_estimation) / sqrt(size(ambiguity_estimation, 1))];
avg_std_conflict = [mean(conflict_estimation); std(conflict_estimation) / sqrt(size(conflict_estimation, 1))];

% Create a table to display the results
column_names = {'40-60%', '25-75%', '10-90%'};
row_names = {'Average', 'Standard Error'};
ambiguity_table = array2table(avg_std_ambiguity, 'VariableNames', column_names, 'RowNames', row_names);
conflict_table = array2table(avg_std_conflict, 'VariableNames', column_names, 'RowNames', row_names);

% Display the tables
disp("Ambiguity Estimation:");
disp(ambiguity_table);

disp("Conflict Estimation:");
disp(conflict_table);

% Perform a 2-way ANOVA
n_participants = height(data);
all_probaility_estimation = [ambiguity_estimation(:); conflict_estimation(:)];
uncertinty_type = [repmat({'Ambiguity'}, numel(ambiguity_estimation), 1); repmat({'Conflict'}, numel(conflict_estimation), 1)];
probability_range = repmat(repelem(column_names, n_participants),1,2);

[p, tbl, stats] = anovan(all_probaility_estimation, {uncertinty_type, probability_range}, 'model', 'interaction', 'varnames', {'Uncertinty type (Amb vs. Conf)', 'Probability Range'}, display='off');

% Display ANOVA results
anova_p = p(1);
anova_df = tbl{2, 3};
interaction_p = p(3);
interaction_df = tbl{4, 3};

% Construct the message
message = sprintf("We found that both in conflict and ambiguity,\n" + ...
    "probability estimation was significantly modulated by \n" + ...
    "probability range (ANOVA, p=%.2f, DF=%d). Ambiguity and conflict\n" + ...
    "were not significantly different in the effect the probability\n" + ...
    " range induced on the estimation (ANOVA, p=%.2f, DF=%d; " + ...
    "interaction: p=%.2f, DF=%d).", ...
    anova_p, anova_df, anova_p, anova_df, interaction_p, interaction_df);

% Display the message
disp(message);
% end

