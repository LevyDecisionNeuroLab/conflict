function CONFLICT_plot_risk_proportion(risk_choice)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
CONSTANS = CONFLICT_constants();
n = size(risk_choice,2);
risk_mean = mean(risk_choice{:,:});
risk_sem = sem(risk_choice{:,:});
hold on
bar(1:n, risk_mean, 'FaceColor', CONSTANS.COLORS.RISK);
errorbar(1:n, risk_mean, risk_sem, 'k.');
risk_reward_amount = risk_choice.Properties.VariableNames;
% tick_indices = 1:length(risk_reward_amount);
% set(gca, 'XTick', tick_indices, 'XTickLabel', risk_reward_amount(tick_indices));
tick_indices = 1:2:length(risk_reward_amount);
set(gca, 'XTick', tick_indices, 'XTickLabel', risk_reward_amount(tick_indices), 'FontSize', 16);
CONFLICT_set_labels('Reward ($)', 'P(risk)');
end

