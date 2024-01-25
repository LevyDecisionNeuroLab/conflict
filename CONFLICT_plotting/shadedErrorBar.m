function shadedErrorBar(x, y, err, color, alpha)
    % Function to plot shaded error bars
    fill([x, fliplr(x)], [y - err, fliplr(y + err)], color, 'EdgeColor', 'none', 'FaceAlpha', alpha);
end