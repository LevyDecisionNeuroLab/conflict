function risk_choice = CONFLICT_get_risk_data(data)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% Create a new table 'risk_choice'
risk_choice = table();
CONSTANS = CONFLICT_constants();
RISK_CHOICE = CONSTANS.DATA.CHOICE_VALUE.RISK; %'risk'

    function reward = reward_amount_from_column_name(column_name_str)
        % Find the index of the last '_' sign
        last_underscore_idx = find(column_name_str == '_', 1, 'last');

        % Extract the number substring after the last '_'
        reward_str = column_name_str(last_underscore_idx+2:end);

        % Convert the number string to a numeric value
        reward = str2double(reward_str);
    end

for column_name = CONSTANS.DATA.COLUMN.RISK
    colum_name_str = column_name{1};
    reward = reward_amount_from_column_name(colum_name_str);
    % Get the values from the current column in 'data'
    values = data.(colum_name_str);

    % Create a logical column in 'risk_choice' with true for "risk" values and false otherwise
    risk_choice.(num2str(reward)) = strcmp(values, RISK_CHOICE);

end

end

