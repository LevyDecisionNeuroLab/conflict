function choice_table = CONFLICT_uncertinty_choice_table(column_names, uncertain_choice, data)

    function reward = reward_amount_from_column_name(column_name_str)
        % Find the index of the last '_' sign
        last_underscore_idx = find(column_name_str == '_', 1, 'last');

        % Extract the number substring after the last '_'
        reward_str = column_name_str(last_underscore_idx+1:end);

        if reward_str(1)=='r' % Some columns are 'amb_c40_r7', and some are 'amb_c40_7'
            reward_str = reward_str(2:end);
        end
        % Convert the number string to a numeric value
        reward = str2double(reward_str);
    end


% Initialize the choice table
choice_table = table();
% Loop over each column name
for i = 1:numel(column_names)
    column_name_str = column_names{i};
    reward = reward_amount_from_column_name(column_name_str);
    values = data.(column_name_str);
    choice_table.(num2str(reward)) = strcmp(values, uncertain_choice);
end
end