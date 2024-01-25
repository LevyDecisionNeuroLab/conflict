function CONFLICT_plot_bar_and_error_bar(x_coordinate, v, face_color, alpha, width)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
bar(x_coordinate, mean(v), 'FaceColor',face_color, 'FaceAlpha',alpha, "BarWidth", width, 'LineWidth', 2);
errorbar(x_coordinate, mean(v), sem(v), '.k', 'LineWidth', 2);
end

