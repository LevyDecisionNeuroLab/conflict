function CONFLICT_print_mean_and_sem(x, description)
    x_mean = mean(x);
    x_sem = std(x) / sqrt(length(x)-1);

    fprintf('Overall, participants chose the %s %.2f%% ± %.2f%%\n', description, x_mean*100, x_sem*100);
end

