function [ambig_choice_table, participant_ambig_mean] = CONFLICT_get_ambig_data(data)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% Create a new table 'risk_choice'

CONSTANS = CONFLICT_constants();
AMBIG_CHOICE = CONSTANS.DATA.CHOICE_VALUE.AMBIG; % 'ambiguous'

ambig_choice_40 = CONFLICT_uncertinty_choice_table(CONSTANS.DATA.COLUMN.AMB_40, AMBIG_CHOICE, data);
ambig_choice_25 = CONFLICT_uncertinty_choice_table(CONSTANS.DATA.COLUMN.AMB_25, AMBIG_CHOICE, data);
ambig_choice_10 = CONFLICT_uncertinty_choice_table(CONSTANS.DATA.COLUMN.AMB_10, AMBIG_CHOICE, data);

ambig_choice_table = dictionary([40, 25, 10], {ambig_choice_40, ambig_choice_25, ambig_choice_10});
participant_ambig_mean = mean([table2array(ambig_choice_40), table2array(ambig_choice_25), table2array(ambig_choice_10)],2);

end

