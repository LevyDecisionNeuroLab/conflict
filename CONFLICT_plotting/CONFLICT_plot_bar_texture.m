function CONFLICT_plot_bar_texture(x, y, symbol_and_color)
%CONFLICT_PLOT_BAR_TEXTURE Summary of this  goes here
%   Detailed explanation goes here

SYMBOL_SPACING = 0.03;
y_values = 0.01:SYMBOL_SPACING:y;
plot(x.*ones(1, length(y_values)), y_values, symbol_and_color)

end
