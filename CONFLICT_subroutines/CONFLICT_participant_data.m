function [A_ambig, v_ambig, choice_ambig, ...
    A_conflict, v_conflict, choice_conflict, ...
    A_risk, v_risk, choice_risk] = ...
    CONFLICT_participant_data(...
    participant_id, ambig_choice_table, conflict_choice_table, risk_choice)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
A_ambig = [];
v_ambig = [];
choice_ambig = [];

ambiguity_coded_values = [10, 25, 40];
A_values = [0.9, 0.5, 0.2];

for i = 1:numel(ambiguity_coded_values)
    [is_ambig_choice, current_v] = CONFLICT_participant_choices(ambig_choice_table, ambiguity_coded_values(i), participant_id);
    current_A = A_values(i) * ones(size(current_v));
    v_ambig = [v_ambig current_v];
    A_ambig = [A_ambig current_A];
    choice_ambig = [choice_ambig is_ambig_choice];
end
choice_ambig = logical(choice_ambig);
%% Participant data - conflict
A_conflict = [];
v_conflict = [];
choice_conflict = [];

conflict_coded_values = [10, 25, 40];
A_values = [0.9, 0.5, 0.2];

for i = 1:numel(conflict_coded_values)
    [is_conflict_choice, current_v] = CONFLICT_participant_choices(conflict_choice_table, ambiguity_coded_values(i), participant_id);
    current_A = A_values(i) * ones(size(current_v));
    v_conflict = [v_conflict current_v];
    A_conflict = [A_conflict current_A];
    choice_conflict = [choice_conflict is_conflict_choice];
end

choice_conflict = logical(choice_conflict);
%% Participant data - risk
v_risk = table_numerical_col_name(risk_choice);
A_risk = 0 * ones(size(current_v));
choice_risk = table2array(risk_choice(participant_id, :));
choice_risk = logical(choice_risk);

end

