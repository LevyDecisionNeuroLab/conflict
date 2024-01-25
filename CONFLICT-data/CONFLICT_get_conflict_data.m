function [conflict_choice_table, participant_conflict_mean] = CONFLICT_get_conflict_data(data)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% Create a new table 'risk_choice'

CONSTANS = CONFLICT_constants();
CONFLICT_CHOICE = CONSTANS.DATA.CHOICE_VALUE.CONFLICT; %'conflict'


conflict_choice_40 = CONFLICT_uncertinty_choice_table(CONSTANS.DATA.COLUMN.CONF_40, CONFLICT_CHOICE, data);
conflict_choice_25 = CONFLICT_uncertinty_choice_table(CONSTANS.DATA.COLUMN.CONF_25, CONFLICT_CHOICE, data);
conflict_choice_10 = CONFLICT_uncertinty_choice_table(CONSTANS.DATA.COLUMN.CONF_10, CONFLICT_CHOICE, data);

conflict_choice_table = dictionary([40, 25, 10], {conflict_choice_40, conflict_choice_25, conflict_choice_10});
participant_conflict_mean = mean([table2array(conflict_choice_40), table2array(conflict_choice_25), table2array(conflict_choice_10)],2);

end

