function [p_probability, p_spread, p_interaction] = anova_2_way_anova_conflict_vs_ambiguity_spread(data)
%% Organize the data
is_conflict = @(choices) double(strcmp('conflict', choices));
p_15_spread_10 = is_conflict(data.CA_c15_r5); % $5, 10%-20%
p_15_spread_20 = is_conflict(data.CA_c15_r20); % $20, 5%-25%
p_15_spread_30 = is_conflict(data.CA_c15_r120); % $120, 0%-30

p_50_spread_10 = mean(is_conflict([data.CA_c50_r120, data.CR_c50_r120]), 2);
p_50_spread_20 = mean(is_conflict([data.CA_c50_r20, data.CR_c50_r20]), 2);
p_50_spread_30 = mean(is_conflict([data.CA_c50_r5, data.CR_c50_r5]), 2);

p_85_spread_10 = mean(is_conflict([data.CA_c50_r120, data.CR_c50_r120]), 2);
p_85_spread_20 = mean(is_conflict([data.CA_c50_r20, data.CR_c50_r20]), 2);
p_85_spread_30 = mean(is_conflict([data.CA_c50_r5, data.CR_c50_r5]), 2);


% Combine all your data into a single matrix
dataMatrix = [p_15_spread_10', p_15_spread_20', p_15_spread_30', ...
    p_50_spread_10', p_50_spread_20', p_50_spread_30', ...
    p_85_spread_10', p_85_spread_20', p_85_spread_30'];

% Create factor variables with correct lengths
p_values = [15 50 85];
spread_values = [10, 20, 30];
%% 2-way-anova

n_participants = length(p_15_spread_10);
pLevels = [...
    repelem(p_values(1), n_participants*length(spread_values)), ...
    repelem(p_values(2), n_participants*length(spread_values)), ...
    repelem(p_values(3), n_participants*length(spread_values))];

spreadFactor = repmat([...
    repelem(spread_values(1), n_participants)...
    repelem(spread_values(2), n_participants)...
    repelem(spread_values(3), n_participants)...
    ],1,length(p_values));


% Perform repeated measures 2-way ANOVA
[pAnova, tbl, stats] = anovan(dataMatrix(:), {pLevels, spreadFactor}, ...
    'model', 'interaction', 'varnames', {'Probability', 'Spread'},'display','off');

% % Display ANOVA results
% disp(tbl);
%% Repeated meausre anova (pariticipant as random factor)
participant_id = repmat(1:n_participants, 1,9);
[pAnova, tbl, stats] = anovan(dataMatrix(:), {pLevels, spreadFactor, participant_id}, ...
    'model', 'interaction', 'random', 3, 'varnames', {'Probability', 'Spread', 'Participant'},'display','off');

p_probability = pAnova(1);
p_spread = pAnova(2);
p_interaction = pAnova(4);

df = tbl(2,3);

fprintf(['Both the probability spread, and the center of probabilities had' ...
    ' significant effects on participants'' choice in the conflicted ' ...
    'option (2-way ANOVA, p=%.3f and DF=%d for both; interaction p=%.2f).\n'], ...
    max(p_probability, p_spread), df{1}, p_interaction);
%% Proper repeated measure anova whose results don't make sense
if false
    dataTable = table(dataMatrix', repmat(1:n_participants, 1,9)', categorical(pLevels)', categorical(spreadFactor)', ...
        'VariableNames', {'choice', 'subject', 'p', 'spread'});

    rm = fitrm(dataTable, 'choice, subject ~ p*spread - 1','WithinDesign', {'p','spread'}, 'WithinModel', 'orthogonalcontrasts');

    % Perform the repeated measures ANOVA using the 'ranova' function
    ranovaResults = ranova(rm,'display','off');
end

end
