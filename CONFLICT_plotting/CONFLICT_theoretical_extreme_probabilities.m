function CONFLICT_theoretical_extreme_probabilities()
%% Subjective probability
% https://www-jstor-org.yale.idm.oclc.org/stable/2998573
% The probability weighting function
subjective_probability = @(p, alpha) exp(-(-log(p)).^alpha);
%% Subjective probability for conflict and ambiguity
subplot(1, 2, 1)
CONSTANTS = CONFLICT_constants();
hold on

p_0_1 = 0:0.001:1;
plot(p_0_1, subjective_probability(p_0_1, 1), 'k--', 'LineWidth',1)
plot(p_0_1, subjective_probability(p_0_1, .5), 'k-', 'LineWidth',3)


ALPHA = 0.5;
subjective_p_conflict = @(p1, p2) mean(subjective_probability([p1, p2], ALPHA));
subjective_p_ambig = @(p1, p2) mean(subjective_probability([p1:0.001:p2], ALPHA));
p_experiment = [0.15, 0.5, 0.85];
p_diff = 0.15;

% b = bar(p_experiment, [subjective_p_conflict(0, 0.3), subjective_p_ambig(0, 0.3);...
%     subjective_p_conflict(0.35, 0.65), subjective_p_ambig(0.35, 0.65);...
%     subjective_p_conflict(0.7, 1), subjective_p_ambig(0.7, 1)]);
b = bar(p_experiment, ...
    [subjective_p_conflict(p_experiment(1)-p_diff, p_experiment(1)+p_diff), subjective_p_ambig(p_experiment(1)-p_diff, p_experiment(1)+p_diff);...
    subjective_p_conflict(p_experiment(2)-p_diff, p_experiment(2)+p_diff), subjective_p_ambig(p_experiment(2)-p_diff, p_experiment(2)+p_diff);...
    subjective_p_conflict(p_experiment(3)-p_diff, p_experiment(3)+p_diff), subjective_p_ambig(p_experiment(3)-p_diff, p_experiment(3)+p_diff)]);

b(1).FaceColor = CONSTANTS.COLORS.CONFLICT;
b(2).FaceColor = CONSTANTS.COLORS.AMBIGUITY;

set(gca, 'XTick', p_experiment, 'FontSize', 16)
xlabel('P', 'FontSize', 18, 'FontWeight','bold')
ylabel('Subjective Probability', 'FontSize', 18, 'FontWeight','bold')

%% Subjective probability for different spread
% figure
subplot(1, 2, 2)
CONSTANTS = CONFLICT_constants();
resolution = 0.01;

spreads = [0.3, 0.2,0.1];

x_range = 0.15:resolution:0.85;
subjective_probability_diff_in_range = zeros(length(spreads),length(x_range));
SPREAD_PLOTTING_SIGN = {...
    ['k' CONSTANTS.SYMBOLS.P_SPREAD_30], ...
    ['k' CONSTANTS.SYMBOLS.P_SPREAD_20], ...
    ['k' CONSTANTS.SYMBOLS.P_SPREAD_10]};

hold on;

for jj=1:length(spreads)
spread = spreads(jj);
    x1 = 0:resolution:(1-spread);
    x2 = (0 + spread):resolution:1;
    subjective_probability_diff = zeros(size(x1));
    for ii = 1:length(subjective_probability_diff)
        subjective_probability_diff(ii) = subjective_p_conflict(x1(ii), x2(ii)) - subjective_p_ambig(x1(ii), x2(ii));
    end
    index_start = find(mean([x1;x2])>=0.15,1);
    index_end = find(mean([x1;x2])>=0.85,1);
    subjective_probability_diff_in_range(jj,:) = subjective_probability_diff(index_start:index_end);
end


for jj=1:length(spreads) % Plotting for legend
    extra_resolution_indexing = [1:20:length(x_range) length(x_range)];
    extra_resolution_indexing = [find(x_range>=0.15,1) find(x_range>=0.5,1) find(x_range>=0.85,1)];
    plot(x_range(extra_resolution_indexing), subjective_probability_diff_in_range(jj,extra_resolution_indexing), ...
        SPREAD_PLOTTING_SIGN{jj},...
        'MarkerEdgeColor','k', 'MarkerSize',10);
end

for jj=1:length(spreads)
    plot(x_range, subjective_probability_diff_in_range(jj,:), 'LineWidth',3, ...
        'Color', (0.5+0.3*(jj-1))*mean([CONSTANTS.COLORS.CONFLICT; CONSTANTS.COLORS.AMBIGUITY]));
end

for jj=1:length(spreads)
    extra_resolution_indexing = [find(x_range>=0.15,1) find(x_range>=0.5,1) find(x_range>=0.85,1)];
    plot(x_range(extra_resolution_indexing), subjective_probability_diff_in_range(jj,extra_resolution_indexing), ...
        SPREAD_PLOTTING_SIGN{jj},...
        'MarkerEdgeColor','k', 'MarkerSize',10);
end

legend('P_1-P_2=0.3', 'P_1-P_2=0.2', 'P_1-P_2=0.1', 'Location','southeast')
% plot(x_range, subjective_probability_diff_in_range')
xlabel('(P_1 + P_2)/2', 'FontSize',18, 'FontWeight','bold')
ylabel('P_{conflict}-P_{ambiguity}', 'FontSize',18, 'FontWeight','bold')
set(gca, 'FontSize', 16, 'XTick', [0, 0.15, 0.5, 0.85, 1])
end

