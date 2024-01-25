function CONFLICT_correlation_matrix(data, variableNames)
%CONFLICT_CORRELATION_MATRIX Summary of this function goes here
%   Detailed explanation goes here
% Determine the size of the matrix
[~, nCols] = size(data);

% Create a figure with n x n subplots
figure;
for i = 1:nCols
    for j = 1:nCols
        subplot(nCols, nCols, (i-1)*nCols + j);

        if i == j
            % Plot normalized histogram on diagonal
            histogram(data(:, i), 'Normalization', 'probability');
            xlabel(variableNames{i});
        elseif i<j
            % Plot scatter plot and line on off-diagonal subplots
            scatter(data(:, i), data(:, j), 'filled', 'MarkerFaceAlpha', 0.5);
            xlabel(variableNames{i}, 'FontWeight', 'Bold');
            ylabel(variableNames{j}, 'FontWeight', 'Bold');
            % Calculate correlation and p-value
            [R, PValue] = corrcoef(data(:, i), data(:, j));
            correlation = R(1, 2);
            pValue = PValue(1, 2);

            % Add title with correlation and p-value
            titleStr = sprintf('r= %.2f, (p: %.3f )', correlation, pValue);
            title(titleStr, 'FontSize', 12, 'FontWeight', 'bold');

            % Add regression line
            hold on;
            fit = polyfit(data(:, i), data(:, j), 1);
            xRange = xlim;
            yRange = fit(1) * xRange + fit(2);
            plot(xRange, yRange, 'r-', 'LineWidth', 1);
            hold off;
        else
            plot([data(:, i), data(:, j)]', 'Color', 0.4.*[1 1 1]);
            xlim([.5 2.5])
            set(gca, 'Xtick', 1:2, 'XTickLabel', {variableNames{i}, variableNames{j}});
        end
    end
end

end


