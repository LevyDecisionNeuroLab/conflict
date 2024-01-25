function [r, p] = CONFLICT_plot_corrected_conflict_vs_ambiguity(corrected_conflict,corrected_ambig)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Scatter plot with histograms
% scatterhist(corrected_conflict, corrected_ambig, ...
%     'Marker', 'o',...
%     'Color', 'blue', ...
%     'Kernel','overlay',...
%     'LineWidth', 1, ...
%     'style', 'bar',...
%     'NBins', 30 ...
%     );
% 
% figure
hold on
% Scatter plot
scatter(corrected_conflict, corrected_ambig, 'Marker', 'o', 'MarkerFaceColor', 'b', 'MarkerEdgeColor', 'b', 'MarkerFaceAlpha', 0.3, 'MarkerEdgeAlpha', 0.5);


% scatterhistogram(corrected_conflict{:,:}, corrected_ambig{:,:}, ...
%     'Marker', 'o',...
%     'Color', 'blue', ...
%     'Kernel','overlay',...
%     'LineWidth', 1, ...
%     'style', 'bar',...
%     'NBins', 30 ...
%     );
% Fit a linear regression model
lm = fitlm(corrected_conflict, corrected_ambig);

% Get regression line values
x_fit = linspace(min(corrected_conflict), max(corrected_conflict), 100);
y_fit = predict(lm, x_fit');

% Get confidence interval bounds
[~, CI] = predict(lm, x_fit', 'Prediction', 'observation', 'Alpha', 0.05);

% Plot regression line
plot(x_fit, y_fit, 'Color', [0.2 .2 .9], 'LineWidth', 1.5, 'LineStyle','--');

% Plot confidence interval
fill([x_fit, fliplr(x_fit)], [CI(:, 1)', fliplr(CI(:, 2)')], 'b', 'FaceAlpha', 0.1, 'EdgeColor', 'none');

% Plot dashed black line on 0 for x and y axes
xline(0, 'Color', 'k', 'LineStyle', '--');
yline(0, 'Color', 'k', 'LineStyle', '--');

% Calculate the correlation coefficient and p-value
[r, p] = corr(corrected_conflict, corrected_ambig);

% Set plot title with correlation coefficient and p-value
% title(sprintf('Correlation (r) = %.3f, p-value = %.3f', r, p));

% Add legend with regression formula
% legend(sprintf('Regression: y = %.3f*x + %.3f', lm.Coefficients.Estimate(2), lm.Coefficients.Estimate(1)));

% Set axis labels
CONFLICT_set_labels('Conflict (corrected)', 'Ambiguity (corrected)');
end

