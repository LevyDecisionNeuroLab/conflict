function CONFLICT_plot_proportion_by_conflict_magnitude(conflict_choice_table, ambig_choice_table)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%%
CONSTANTS = CONFLICT_constants();
cla

    function [plot_x, mean_participants] = scatter_and_bar(X_VALUE, specific_level, choice_table, color, bar_shift, scatter_shift)
        specific_levle_choices = choice_table(specific_level);
        specific_levle_choices = specific_levle_choices{1};
        participants_means = mean(table2array(specific_levle_choices), 2);
        [choice_means_count, choice_means_value] = groupcounts(participants_means);
        plot_x = X_VALUE + 0.8*bar_shift;
        hold on
        for ii=1:length(choice_means_value)
            scatter_x = (plot_x+bar_shift)*ones(1, choice_means_count(ii)) + scatter_shift * (1:choice_means_count(ii));
            scatter_y = choice_means_value(ii)* ones(1, choice_means_count(ii));
            scatter(scatter_x, scatter_y,'Marker', 'o', ...
                'MarkerFaceColor', color, ...
                'MarkerEdgeColor','k', ...
                'MarkerEdgeAlpha',0.7);
        end
        mean_participants = mean(participants_means);
        bar(plot_x, mean(participants_means), 'FaceColor', color, 'EdgeColor','none','BarWidth',0.3, 'FaceAlpha', 0.5)
        errorbar(plot_x, mean(participants_means), sem(participants_means), '.k')
    end

BAR_SHIFT = 0.2;
SCATTER_SHIFT = 0.015;
specific_levels = [10, 25, 40];
cla
X_VALUES = [1:3].*2;
ambiguity_means = zeros(2, 3);
conflict_means = zeros(2, 3);
for jj = 1:3
    X_VALUE = X_VALUES(jj);
    specific_level = specific_levels(jj);
    % Ambiguity
    [ambiguity_means(1,jj), ambiguity_means(2,jj)] = ...
        scatter_and_bar(X_VALUE, specific_level, ambig_choice_table, CONSTANTS.COLORS.AMBIGUITY, -BAR_SHIFT, -SCATTER_SHIFT);
    % Conflict
    [conflict_means(1,jj), conflict_means(2,jj)] = scatter_and_bar(X_VALUE, specific_level, conflict_choice_table, CONSTANTS.COLORS.CONFLICT, BAR_SHIFT, SCATTER_SHIFT);
end

% plot(ambiguity_means(1,:), ambiguity_means(2,:), '--', 'Color', 0.8*CONSTANTS.COLORS.AMBIGUITY, 'LineWidth', 1.5)
% plot(conflict_means(1,:), conflict_means(2,:), '--', 'Color', 0.8*CONSTANTS.COLORS.CONFLICT, 'LineWidth', 1.5)
plot(ambiguity_means(1,:), ambiguity_means(2,:),  'Color', 0.8*CONSTANTS.COLORS.AMBIGUITY, 'LineWidth', 1.5)
plot(conflict_means(1,:), conflict_means(2,:), 'Color', 0.8*CONSTANTS.COLORS.CONFLICT, 'LineWidth', 1.5)

set(gca, 'XTick', X_VALUES, 'XTickLabel', {'10%..90%', '25%..75%','40%..60%'}, 'FontSize', 16)
ylabel('Proporion Conflict/Ambiguity', 'FontSize', 18, 'FontWeight','bold')
xlabel('Conflict/Ambiguity level', 'FontSize', 18, 'FontWeight','bold')


end

