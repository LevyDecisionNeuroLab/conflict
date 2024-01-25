function risk_col_name = CONFLICT_get_risk_col_names(data, conflict_level)
%CONFLICT_GET_RISK_COL_NAMES Summary of this function goes here
%   Detailed explanation goes here
% Get the column names of the table
column_names = data.Properties.VariableNames;
if nargin==1
    conflict_level = 40;
end

% Filter the column names based on the desired prefix
selected_columns = column_names(startsWith(column_names, ['amb_c' num2str(conflict_level)]));

% Display the selected column names
disp(selected_columns);

% Extract the numerical values following '_r'
numeric_values = cellfun(@(x) str2double(extractAfter(x, '_r')), selected_columns);

% Sort the selected columns based on the numerical values
[sorted_values, sorted_indices] = sort(numeric_values);

% Sort the selected columns accordingly
sorted_columns = selected_columns(sorted_indices);

disp(sorted_columns);
end

