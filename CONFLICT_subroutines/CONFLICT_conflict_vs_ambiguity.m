function participant_mean_conflict_ambiguity = CONFLICT_conflict_vs_ambiguity(data)
%% In the following trials, participants were presented with ambigous vs.
%   conflict trials. In each trial, both lotteries had the same rewards 
%   and winning probabilities. 
%   Trials with a CA prefix code participants choices as "conflict" or 
%   "ambgious". Trials with a CR prefix code participants choices as 
%   "risk" or "conflict", but are in fact identical to the ambigous 
%   trials (this is just a mistake in the coding).

CONSTANTS = CONFLICT_constants();
% Centered around 15%
data.CA_c15_r5; %       $5, 10%-20%
data.CA_c15_r20; %      $20, 5%-25%
data.CA_c15_r120; %     $120, 0%-30

% Centered around 50%
data.CA_c50_r5; %       $5, 35%-65%
data.CR_c50_r5; %       $5, 35%-65%, Anotated as risk and conflict
data.CA_c50_r20; %      $20, 40%-60%
data.CR_c50_r20; %      $20, 40%-60%, Anotated as risk and conflict
data.CA_c50_r120; %     $120, 45%-55%
data.CR_c50_r120; %     $120, 45%-55%

% Centered around 85%
data.CA_c85_r5; %       $5, 70%-100%
data.CR_c75_r5; %       $5, 70%-100%, Anotated as risk and conflict
data.CA_c85_r20; %      $20, 80%-90%
data.CR_c75_r20; %      $20, 80%-90%, Anotated as risk and conflict
data.CA_c85_r120; %     $120, 75%-95%
data.CR_c75_r120; %     $120, 75%-95%, Anotated as risk and conflict

%% Plot conflict vs. ambiguity

CONFLICT_15_COLOR = [0 0.4470 0.7410];
CONFLICT_50_COLOR = [0.8500 0.3250 0.0980];
CONFLICT_85_COLOR = [0.9290 0.6940 0.1250];

CONFLICT_15_COLOR = [42,77,105]./255;
CONFLICT_50_COLOR = [75,134,180]./255;
CONFLICT_85_COLOR = [99,172,229]./255;

BIG_BAR_TRANSPARENCY = 0.4;
SMALL_BAR_TRANSPARENCY = 0.6;
SMALL_BAR_WIDTH = 0.05;
SMALL_BAR_DISTANCE = 0.1;
CONFLICT_15_CENTER = 2; CONFLICT_50_CENTER = 3; CONFLICT_85_CENTER = 4;
CONFLICT_15_CENTER = 2; CONFLICT_50_CENTER = 2.5; CONFLICT_85_CENTER = 3;
xlim([CONFLICT_15_CENTER-0.5, CONFLICT_85_CENTER+0.5]);
ylim([0 0.3])

is_conflict = @(choices) double(strcmp('conflict', choices));
cla;hold on;
% Plotting outside the screen for presentation in legend
% CONFLICT_plot_bar_texture(10, 1, [CONSTANTS.SYMBOLS.P_SPREAD_10 CONSTANTS.SYMBOLS.COLOR])
% CONFLICT_plot_bar_texture(10, 1, [CONSTANTS.SYMBOLS.P_SPREAD_20 CONSTANTS.SYMBOLS.COLOR])
% CONFLICT_plot_bar_texture(10, 1, [CONSTANTS.SYMBOLS.P_SPREAD_30 CONSTANTS.SYMBOLS.COLOR])
plot(10, 1, [CONSTANTS.SYMBOLS.P_SPREAD_10 CONSTANTS.SYMBOLS.COLOR], 'MarkerSize',10)
plot(10, 1, [CONSTANTS.SYMBOLS.P_SPREAD_20 CONSTANTS.SYMBOLS.COLOR], 'MarkerSize',10)
plot(10, 1, [CONSTANTS.SYMBOLS.P_SPREAD_30 CONSTANTS.SYMBOLS.COLOR], 'MarkerSize',10)


% bar(10, 0.1, 'FaceColor',CONFLICT_15_COLOR, 'FaceAlpha',SMALL_BAR_TRANSPARENCY, 'LineWidth', 2);
% bar(10, 0.1, 'FaceColor',CONFLICT_50_COLOR, 'FaceAlpha',SMALL_BAR_TRANSPARENCY, 'LineWidth', 2);
% bar(10, 0.1, 'FaceColor',CONFLICT_85_COLOR, 'FaceAlpha',SMALL_BAR_TRANSPARENCY, 'LineWidth', 2);


data.CA_c15_r5; %       $5, 10%-20%
data.CA_c15_r20; %      $20, 5%-25%
data.CA_c15_r120; %     $120, 0%-30

bar_x = CONFLICT_15_CENTER-SMALL_BAR_DISTANCE;
bar_y = mean(is_conflict(data.CA_c15_r5));
bar(bar_x , bar_y, 'FaceColor', CONFLICT_15_COLOR, 'FaceAlpha',SMALL_BAR_TRANSPARENCY, "BarWidth", SMALL_BAR_WIDTH);
CONFLICT_plot_bar_texture(bar_x , bar_y, [CONSTANTS.SYMBOLS.P_SPREAD_10 CONSTANTS.SYMBOLS.COLOR])

bar_x = CONFLICT_15_CENTER;
bar_y = mean(is_conflict(data.CA_c15_r20));
bar(bar_x, bar_y, 'FaceColor', CONFLICT_15_COLOR, 'FaceAlpha',SMALL_BAR_TRANSPARENCY, "BarWidth", SMALL_BAR_WIDTH);
CONFLICT_plot_bar_texture(bar_x , bar_y, [CONSTANTS.SYMBOLS.P_SPREAD_20 CONSTANTS.SYMBOLS.COLOR])

bar_x = CONFLICT_15_CENTER+SMALL_BAR_DISTANCE;
bar_y = mean(is_conflict(data.CA_c15_r120));
bar(bar_x, bar_y, 'FaceColor', CONFLICT_15_COLOR, 'FaceAlpha',SMALL_BAR_TRANSPARENCY, "BarWidth", SMALL_BAR_WIDTH);
CONFLICT_plot_bar_texture(bar_x , bar_y, [CONSTANTS.SYMBOLS.P_SPREAD_30 CONSTANTS.SYMBOLS.COLOR])

CONFLICT_plot_bar_and_error_bar(CONFLICT_15_CENTER, mean(is_conflict([data.CA_c15_r5, data.CA_c15_r20, data.CA_c15_r120]),2), CONFLICT_15_COLOR, BIG_BAR_TRANSPARENCY, 0.25);


data.CA_c50_r5; %       $5, 35%-65%
data.CR_c50_r5; %       $5, 35%-65%, Anotated as risk and conflict
data.CA_c50_r20; %      $20, 40%-60%
data.CR_c50_r20; %      $20, 40%-60%, Anotated as risk and conflict
data.CA_c50_r120; %     $120, 45%-55%
data.CR_c50_r120; %     $120, 45%-55%

bar_x = CONFLICT_50_CENTER-SMALL_BAR_DISTANCE;
bar_y = mean(is_conflict([data.CA_c50_r120; data.CR_c50_r120]));
bar(bar_x, bar_y, 'FaceColor', CONFLICT_50_COLOR, 'FaceAlpha',SMALL_BAR_TRANSPARENCY, "BarWidth", SMALL_BAR_WIDTH);
CONFLICT_plot_bar_texture(bar_x , bar_y, [CONSTANTS.SYMBOLS.P_SPREAD_10 CONSTANTS.SYMBOLS.COLOR])

bar_x = CONFLICT_50_CENTER;
bar_y = mean(is_conflict([data.CA_c50_r20; data.CR_c50_r20]));
bar(bar_x, bar_y, 'FaceColor', CONFLICT_50_COLOR, 'FaceAlpha',SMALL_BAR_TRANSPARENCY, "BarWidth", SMALL_BAR_WIDTH);
CONFLICT_plot_bar_texture(bar_x , bar_y, [CONSTANTS.SYMBOLS.P_SPREAD_20 CONSTANTS.SYMBOLS.COLOR])

bar_x = CONFLICT_50_CENTER+SMALL_BAR_DISTANCE;
bar_y = mean(is_conflict([data.CA_c50_r5;data.CR_c50_r5]));
bar(bar_x, bar_y, 'FaceColor', CONFLICT_50_COLOR, 'FaceAlpha',SMALL_BAR_TRANSPARENCY, "BarWidth", SMALL_BAR_WIDTH);
CONFLICT_plot_bar_texture(bar_x , bar_y, [CONSTANTS.SYMBOLS.P_SPREAD_30 CONSTANTS.SYMBOLS.COLOR])

CONFLICT_plot_bar_and_error_bar(CONFLICT_50_CENTER, mean(is_conflict([data.CA_c50_r5, data.CA_c50_r20, data.CA_c50_r120, data.CR_c50_r5, data.CR_c50_r20, data.CR_c50_r120]),2), CONFLICT_50_COLOR, 0.4, 0.25);


data.CA_c85_r5; %       $5, 70%-100%
data.CR_c75_r5; %       $5, 70%-100%, Anotated as risk and conflict
data.CA_c85_r20; %      $20, 80%-90%
data.CR_c75_r20; %      $20, 80%-90%, Anotated as risk and conflict
data.CA_c85_r120; %     $120, 75%-95%
data.CR_c75_r120; %     $120, 75%-95%, Anotated as risk and conflict

bar_x = CONFLICT_85_CENTER-SMALL_BAR_DISTANCE;
bar_y = mean(is_conflict([data.CA_c85_r20; data.CR_c75_r20]));
bar(bar_x, bar_y, 'FaceColor', CONFLICT_85_COLOR, 'FaceAlpha',SMALL_BAR_TRANSPARENCY, "BarWidth", SMALL_BAR_WIDTH);
CONFLICT_plot_bar_texture(bar_x , bar_y, [CONSTANTS.SYMBOLS.P_SPREAD_10 CONSTANTS.SYMBOLS.COLOR]);

bar_x = CONFLICT_85_CENTER;
bar_y = mean(is_conflict([data.CA_c85_r120; data.CR_c75_r120]));
bar(bar_x, bar_y, 'FaceColor', CONFLICT_85_COLOR, 'FaceAlpha',SMALL_BAR_TRANSPARENCY, "BarWidth", SMALL_BAR_WIDTH);
CONFLICT_plot_bar_texture(bar_x , bar_y, [CONSTANTS.SYMBOLS.P_SPREAD_20 CONSTANTS.SYMBOLS.COLOR]);

bar_x = CONFLICT_85_CENTER+SMALL_BAR_DISTANCE;
bar_y = mean(is_conflict([data.CA_c85_r5; data.CR_c75_r5]));
bar(bar_x, bar_y, 'FaceColor', CONFLICT_85_COLOR, 'FaceAlpha',SMALL_BAR_TRANSPARENCY, "BarWidth", SMALL_BAR_WIDTH);
CONFLICT_plot_bar_texture(bar_x , bar_y, [CONSTANTS.SYMBOLS.P_SPREAD_30 CONSTANTS.SYMBOLS.COLOR]);

CONFLICT_plot_bar_and_error_bar(CONFLICT_85_CENTER, mean(is_conflict([data.CA_c85_r5, data.CA_c85_r20, data.CA_c85_r120, data.CR_c75_r5, data.CR_c75_r20, data.CR_c75_r120]),2), CONFLICT_85_COLOR, 0.4, 0.25);

% set(gca, 'XTick', ...
%     [CONFLICT_15_CENTER-SMALL_BAR_DISTANCE, CONFLICT_15_CENTER, CONFLICT_15_CENTER+SMALL_BAR_DISTANCE,...
%     CONFLICT_50_CENTER-SMALL_BAR_DISTANCE, CONFLICT_50_CENTER, CONFLICT_50_CENTER+SMALL_BAR_DISTANCE,...
%     CONFLICT_85_CENTER-SMALL_BAR_DISTANCE, CONFLICT_85_CENTER, CONFLICT_85_CENTER+SMALL_BAR_DISTANCE] ,...
%     'XTickLabel',...
%     {'$5, 10%-20%', '$20, 5%-25%', '$120, 0%-30',...
%     '$5, 35%-65%', '$20, 40%-60%', '$120, 45%-55%',...
%     '$5, 70%-100%', '$20, 80%-90%', '$120, 75%-95%'},...
%     'XTickLabelRotation',90);
set(gca, 'XTick', [CONFLICT_15_CENTER, CONFLICT_50_CENTER, CONFLICT_85_CENTER],...
    'XTickLabel',[0.15, 0.5, 0.85])

set(gca, 'FontSize', 16)
% legend('$\frac{p_1+p_2}{2}=15\%$', '$\frac{p_1+p_2}{2}=50\%$', '$\frac{p_1+p_2}{2}=85\%$', ...
%     'Interpreter', 'latex', 'FontSize', 20)
% legend('~15%', '~50%', '~85%', 'FontSize', 16)
legend('p_1-p_2=10%', 'p_1-p_2=20%', 'p_1-p_2=30%', 'FontSize', 14)
xlabel('(p_1+p_2)/2', 'FontSize', 18, 'FontWeight', 'bold')
ylabel('Proportion of Conflict Choices', 'FontSize', 18, 'FontWeight', 'bold')
% xtickangle(45)
ylim([0 .5])

%% Conflict vs. Ambiguity statistical analysis

% Overall propotion of choices conflict
is_conflict_p_15 = strcmp([data.CA_c15_r5, data.CA_c15_r20, data.CA_c15_r120],'conflict');
is_conflict_p_50 = strcmp([data.CA_c50_r5, data.CR_c50_r5, data.CA_c50_r20,...
                            data.CR_c50_r20, data.CA_c50_r120, data.CR_c50_r120],'conflict');
is_conflict_p_85 = strcmp([data.CA_c85_r5, data.CR_c75_r5, data.CA_c85_r20,...
                            data.CR_c75_r20, data.CA_c85_r120, data.CR_c75_r120],'conflict');
is_conflict_all_p = [is_conflict_p_15, is_conflict_p_50, is_conflict_p_85];

overall_proportion_conflict_vs_amb = mean(is_conflict_all_p, 'all');
fprintf('The overall proportion of conflict versus ambiguity is: %.1f%%\n', 100*overall_proportion_conflict_vs_amb );


% ttest (is significantly more choices in one of the options")
[~, p_value_is_conflict_propotion_different_than_chance] = ttest(mean(is_conflict_all_p, 2)-0.5);
% bootstrap Binomial simulation test is more appropriate than a t-test
SIMULATION_REPETITIONS = 1e3;
NULL_HYPOTHESIS_CONFLICT_CHOICE = 0.5;
n_participants = size(is_conflict_all_p, 1);
n_choices = size(is_conflict_all_p, 2);
distribution_of_conflict_choices_assuming_no_preference = sort(mean(...
    binornd(n_choices, NULL_HYPOTHESIS_CONFLICT_CHOICE, n_participants, SIMULATION_REPETITIONS)...
    ),'ascend');
population_mean_conflict_choice = mean(sum(is_conflict_all_p,2));
p_value_is_conflict_propotion_different_than_chance = mean(population_mean_conflict_choice>=distribution_of_conflict_choices_assuming_no_preference);

% p_value_is_conflict_propotion_different_than_chance = is_conflict_all_p
fprintf('P-value: P(conflict)=P(Ambiguity) %.3f\n', p_value_is_conflict_propotion_different_than_chance);

PLOT_BLUE_BARS_WITH_PROPORTIONS_ONLY = false;
if PLOT_BLUE_BARS_WITH_PROPORTIONS_ONLY
    % Plot - propotion of choices in conflict as a function of conflict level
    figure();
    hold on
    conflict_vs_ambig_participants_means = ...
        [mean(is_conflict_p_15, 2), mean(is_conflict_p_50, 2), mean(is_conflict_p_85, 2)];
    bar(1:3, mean(conflict_vs_ambig_participants_means))
    errorbar(1:3, mean(conflict_vs_ambig_participants_means), sem(conflict_vs_ambig_participants_means), '.k')
    set(gca, 'XTick', 1:3, 'XTickLabel' ,{'15%', '50%', '85%'});
    ylim([0 1])
end
participant_mean_conflict_ambiguity = mean(is_conflict_all_p, 2);

%% Report ttest of decisions centered around 15 and 85
participant_mean_conflict_15 = mean(is_conflict_p_15,2);
participant_mean_conflict_85 = mean(is_conflict_p_85,2);
[~,p_conflict_15_greater_85, ~, stats_conflict_15_greater_85] = ttest(participant_mean_conflict_15, mean(participant_mean_conflict_85,2),'Tail','right');
fprintf(['The overall proportion of choices in the conflicted option ' ...
    'centered around 15%% winning chance (%.1f%%±%.1f%%) was not ' ...
    'significantly greater than the same choices centered around 85%% ' ...
    '(%.1f%%±%.1f%%; one-tailed t-test: p=%.2f, DF=%d)\n'], ...
    100*mean(participant_mean_conflict_15), 100*sem(participant_mean_conflict_15), ...
    100*mean(participant_mean_conflict_85), 100*sem(participant_mean_conflict_85),...
    p_conflict_15_greater_85, stats_conflict_15_greater_85.df);

p_conflict_15_percent_spread_30 = strcmp(data.CA_c15_r120,'conflict');
p_conflict_85_percent_spread_30 = mean(strcmp([data.CA_c85_r5, data.CR_c75_r5],'conflict'),2);
[~,p_conflict_15_85_spread_30, ~, stats_conflict_15_85_spread_30] = ttest(p_conflict_15_percent_spread_30, p_conflict_85_percent_spread_30,'Tail','right');
fprintf(['These differences remained insignificant even when considering ' ...
    'only the widest probability spread, 30%%, where the effect is hypothesized ' ...
    'to be the largest (one-tailed t-test: p=%.2f, DF=%d)\n'], ...
    p_conflict_15_85_spread_30, stats_conflict_15_85_spread_30.df);
end

