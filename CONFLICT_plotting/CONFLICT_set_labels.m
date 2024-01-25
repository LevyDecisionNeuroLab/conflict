function CONFLICT_standardize_current_figure(x_label, y_label)
%CONFLICT_STANDARDIZE_CURRENT_FIGURE Summary of this function goes here
%   Detailed explanation goes here
% Get the current figure handle
figure_handle = gcf;

% Set the font size within the figure
fontsize(gcf, 16, "points")

xlabel(x_label, 'FontSize', 20, 'FontWeight', 'bold')
ylabel(y_label, 'FontSize', 20, 'FontWeight', 'bold')

end

