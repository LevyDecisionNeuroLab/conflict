function [is_uncertinty_choice, v] = CONFLICT_participant_choices(uncertinty_choice_table, uncertinty_level, participant_id)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
choices_in_uncertinty_level = uncertinty_choice_table(uncertinty_level);
choices_in_uncertinty_level = choices_in_uncertinty_level{1};
participant_choice_table = choices_in_uncertinty_level(participant_id,:);
v = table_numerical_col_name(participant_choice_table);
is_uncertinty_choice = table2array(participant_choice_table);
end

