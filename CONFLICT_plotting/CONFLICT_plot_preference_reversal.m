function CONFLICT_plot_preference_reversal(participant_mean_conflict_ambiguity,participant_conflict_mean, participant_ambig_mean)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% Data preparation
direct_comparison_vs_comparison_with_risk = [participant_mean_conflict_ambiguity,participant_conflict_mean./(participant_conflict_mean+participant_ambig_mean)];
direct_comparison_vs_comparison_with_risk(isnan(direct_comparison_vs_comparison_with_risk)) = 0.5;
conflict_preference_greater_in_direct_comparison = direct_comparison_vs_comparison_with_risk(:, 1) >= direct_comparison_vs_comparison_with_risk(:, 2);
%% Print informative message on preference reversal
fprintf(['%.1f%% of the participatns prefered conflict when indirectly' ...
    'compared with ambiguity but reversed their preference ' ...
    'when the comparison is directly compaed\n'], 100*(1-mean(direct_comparison_vs_comparison_with_risk(:, 1) > direct_comparison_vs_comparison_with_risk(:, 2))));


%% Create the plot
% Create the plot with two colors
cla
hold on;
color_1 = [186, 69, 149]./255;%'#ba4595';
color_2 = [69, 186, 106]./255; %'#45BA6A';

plot(0.5:0.6, 'Color', color_2, 'LineWidth',3)
plot(0.5:0.6, 'Color', color_1, 'LineWidth',3)


plot(direct_comparison_vs_comparison_with_risk(conflict_preference_greater_in_direct_comparison, :)',  '.-', 'Color', color_1, 'LineWidth', 0.1);
plot(direct_comparison_vs_comparison_with_risk(~conflict_preference_greater_in_direct_comparison, :)',  '.-', 'Color', color_2, 'LineWidth', 0.1);

plot([1 2], [0.5 0.5], '--', 'LineWidth', 2, 'Color', [1 1 1]*.3)
errorbar([1 2], mean(direct_comparison_vs_comparison_with_risk), sem(direct_comparison_vs_comparison_with_risk), 'k-', 'LineWidth', 2);

xlim([.5 2.5])
% set(gca, 'XTick', 1:2, ...
%     'XTickLabel',{'$C \leftrightarrow A$', '$\frac{C \leftrightarrow R}{(C \leftrightarrow R)+(A \leftrightarrow R)}$'},...
%     'FontSize', 16, 'TickLabelInterpreter', 'latex');

% set(gca, 'XTick', 1:2, ...
%     'XTickLabel',{'Con↔Amb', 'Con↔Cer/((Con↔Cer)+(Amb↔Cer))'},...
%     'FontSize', 16);

set(gca, 'XTick', 1:2, ...
    'XTickLabel',{'Direct', 'Indirect'},...
    'FontSize', 16, 'YTick',0:0.25:1);

% xlabel('Comparison method', 'FontSize', 18, 'FontWeight','bold')
xlabel('Conflic ambiguity comparison', 'FontSize', 18, 'FontWeight','bold')
ylabel('Conflict attitude', 'FontSize', 18, 'FontWeight','bold')
% legend('Dirct ≥ Indiretc', 'Dirct < Indiretc')

%% Add histogram on the left
[direct_comparison_frequency,direct_comparison_values,direct_comparison_percentage] = groupcounts(direct_comparison_vs_comparison_with_risk(:, 1));
direct_comparison_proportion = direct_comparison_percentage'./100;
% Create the x-axis values based on the deviation from 1 using 'direct_comparison_percentage'
X_RIGHT = 1;
% x_values = [X_RIGHT*ones(1,numel(direct_comparison_proportion)), smooth(fliplr(X_RIGHT - direct_comparison_proportion),5)'];
x_values = [X_RIGHT*ones(1,numel(direct_comparison_proportion)), fliplr(X_RIGHT - direct_comparison_proportion)];

% Create the y-axis values with all values as 1 on the right side
y_values = [direct_comparison_values', fliplr(direct_comparison_values')];
gradient_color_1_2 = [...
    linspace(color_2(1),color_1(1),256)', ...
    linspace(color_2(2),color_1(2),256)',...
    linspace(color_2(3),color_1(3),256)'];

colormap(gradient_color_1_2);
gradient = linspace(0, 1, numel(direct_comparison_frequency));
vertex_color = [gradient fliplr(gradient)] ;
% Plot the filled area
fill(x_values, y_values, vertex_color, 'EdgeColor', 'none', 'FaceAlpha', 0.8, 'LineWidth',0.1);

%% Add histogram on the right
% [indirect_comparison_frequency,indirect_comparison_values,indirect_comparison_percentage] = groupcounts(direct_comparison_vs_comparison_with_risk(:, 2));
% indirect_comparison_proportion = indirect_comparison_percentage'./100;

N_bins = 20;
bins_edges = linspace(min(direct_comparison_vs_comparison_with_risk(:, 2)), max(direct_comparison_vs_comparison_with_risk(:, 2)), N_bins);
[indirect_comparison_proportion,bin_edges] = histcounts(direct_comparison_vs_comparison_with_risk(:, 2), bins_edges,'Normalization', 'Probability');
% Create the x-axis values based on the deviation from 1 using 'indirect_comparison_percentage'
X_RIGHT = 2;
% x_values = [X_RIGHT*ones(1,numel(indirect_comparison_proportion)), smooth(fliplr(X_RIGHT - indirect_comparison_proportion),5)'];
x_values = [X_RIGHT*ones(1,numel(indirect_comparison_proportion)), smooth(fliplr(X_RIGHT + indirect_comparison_proportion),5)'];

% Create the y-axis values with all values as 1 on the right side
indirect_comparison_values = ([0 bin_edges] + [bin_edges 1])./2;
indirect_comparison_values = indirect_comparison_values(2:end);
y_values_left = linspace(min(direct_comparison_vs_comparison_with_risk(:, 2)), max(direct_comparison_vs_comparison_with_risk(:, 2)), N_bins-1);
y_values = [y_values_left, fliplr(y_values_left)];
gradient_color_1_2 = [...
    linspace(color_2(1),color_1(1),256)', ...
    linspace(color_2(2),color_1(2),256)',...
    linspace(color_2(3),color_1(3),256)'];

colormap(gradient_color_1_2);
gradient = linspace(0, 1, numel(indirect_comparison_proportion));
vertex_color = [gradient fliplr(gradient)] ;
% Plot the filled area
fill(x_values, y_values, vertex_color, 'EdgeColor', 'none', 'FaceAlpha', 0.8, 'LineWidth',0.1);


end

