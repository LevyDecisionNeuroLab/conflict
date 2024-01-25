function [big_5, big_5_values, big_5_trait_names] = ...
    CONFLICT_big_5(data, participant_conflict_mean, participant_ambig_mean,...
    participant_mean_conflict_ambiguity, corrected_conflict)
%CONFLICT_BIG_5 Summary of this function goes here
%   Detailed explanation goes here
BIG_5_Q_PREFIX = 'Q14_';

    function q_sum = big_5_q_sum(data, q_indices)
        quesion_names = strcat(BIG_5_Q_PREFIX, arrayfun(@num2str, q_indices, 'UniformOutput', false));
        relevant_answers = data(:, quesion_names);
        q_sum = sum(relevant_answers{:,:},2);
    end

    function score = big_5_score_calculation(data, dimension_questions, added_constant)
        positive_questions_indices = dimension_questions(dimension_questions > 0);
        negative_questions_indices = -dimension_questions(dimension_questions < 0);
        score = added_constant + big_5_q_sum(data, positive_questions_indices) - big_5_q_sum(data, negative_questions_indices);
    end

big_5_questions = struct(...
    'extroversion', struct('constant', 20, 'questions_index', [1, -6, 11, -16, 21, -26, 31, -36, 41, -46]), ...
    'agreablness', struct('constant', 14, 'questions_index', [-2, 7, -12, 17, -22, 27, -32, 37, 42, 47]), ...
    'conscientiousness', struct('constant', 14, 'questions_index', [3, -8, 13, -18, 23, -28, 33, -38, 43, 48]), ...
    'neuroticism', struct('constant', 38, 'questions_index', [-4, 9, -14, 19, -24, -29, -34, -39, -44, -49]), ...
    'openness', struct('constant', 8, 'questions_index', [5, -10, 15, -20, 25, -30, 35, 40, 45, 50])...
    );


extroversion = big_5_score_calculation(data, big_5_questions.extroversion.questions_index, big_5_questions.extroversion.constant);
agreablness = big_5_score_calculation(data, big_5_questions.agreablness.questions_index, big_5_questions.agreablness.constant);
conscientiousness = big_5_score_calculation(data, big_5_questions.conscientiousness.questions_index, big_5_questions.conscientiousness.constant);
neuroticism = big_5_score_calculation(data, big_5_questions.neuroticism.questions_index, big_5_questions.neuroticism.constant);
openness = big_5_score_calculation(data, big_5_questions.openness.questions_index, big_5_questions.openness.constant);

big_5_values = [extroversion, agreablness, conscientiousness, neuroticism, openness];
big_5_trait_names = {'Extroversion', 'Agreablness', 'Conscientiousness', 'Neuroticism', 'Openness'};
big_5 = struct();
for ii=1:5
    big_5.(big_5_trait_names{ii}) = big_5_values(:,ii);
end

%% Plot correlation matrix
% correlationMatrix = corr(big_5_values);
% heatmap(big_5_trait_names, big_5_trait_names, correlationMatrix,...
%     'ColorMethod', 'none', 'XLabel', 'Big 5', 'YLabel', 'Big 5', 'Title', 'Correlation Matrix');
indirect_comparison = participant_conflict_mean./(participant_conflict_mean+participant_ambig_mean);
indirect_comparison(isnan(indirect_comparison)) = 0.5;
[correlationMatrix, correlationMatrix_p] = corr([big_5_values corrected_conflict participant_mean_conflict_ambiguity indirect_comparison]);
for ii=1:length(correlationMatrix)
    correlationMatrix(ii, ii) = NaN;
end
p_value_big_5_and_conflict = correlationMatrix_p(6:8, 1:5);
p_value_big_5_and_conflict(3,3) = 1;
second_smallest_p_value = min(p_value_big_5_and_conflict,[],'all');
big_5_and_conflict_labels = [big_5_trait_names, 'Corrected conflict', 'Conf vs. Amb', 'Conf/(Conf+Amb)'];
heatmap(big_5_and_conflict_labels, big_5_and_conflict_labels, round(correlationMatrix, 2))

%% Print correlation report
[cons_corrected_conflict_r, cons_corrected_conflict_p] = corrcoef(conscientiousness, corrected_conflict);
[cons_indirect_r, cons_indirect_p] = corrcoef(conscientiousness, indirect_comparison);
fprintf(['We did not find a significant correlation between trait \n' ...
    'Agreeableness and the corrected conflict score (r=%.2f, p=%.2f). We\n' ...
    'did find a weak significant correaltion (r=%.2f, p=%.2f) between the indirect score comparing ' ...
    'conflict and ambiguity (Fig. 3, Methods)' ...
    '(r=%.2f, p=%.2f)\n'],...
    cons_corrected_conflict_r(2), cons_corrected_conflict_p(2),...
    cons_indirect_r(2), cons_indirect_p(2));


[agreablness_corrected_conflict_r, agreablness_corrected_conflict_p] = corrcoef(agreablness, corrected_conflict);
[agreablness_conflict_ambig_r, agreablness_conflict_ambig_p] = corrcoef(agreablness, participant_mean_conflict_ambiguity);
fprintf(['We did not find a significant correlation between trait \n' ...
    'Agreeableness and the corrected conflict score (r=%.2f, p=%.2f), nor with\n' ...
    'the proportion of choices in conflict when contrasted with ambiguity ' ...
    '(r=%.2f, p=%.2f)\n'],...
    agreablness_corrected_conflict_r(2), agreablness_corrected_conflict_p(2),...
    agreablness_conflict_ambig_r(2), agreablness_conflict_ambig_p(2));


[cons_corrected_conflict_r, cons_corrected_conflict_p] = corrcoef(conscientiousness, indirect_comparison);
fprintf(['Fig. S1.: The correlation between conscientiousness and the indirect \n' ...
    'ambiguity and conflict measure is significant (r=%.2f, p=%.3f). \n' ...
    'Other than this measure, all other correlations in the red \n' ...
    'highlighted rectangle are insignificant (p>%.2f).\n\n'],...
    cons_corrected_conflict_r(2), cons_corrected_conflict_p(2), second_smallest_p_value...
    );
end