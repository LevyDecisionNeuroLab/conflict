function risk_col_name = CONFLICT_get_risk_col_names(data)
%CONFLICT_GET_RISK_COL_NAMES Summary of this function goes here
%   Detailed explanation goes here
risk_col_name = {};
for col_name = data.Properties.VariableNames
    if startsWith(col_name{1}, 'risk_c')
        risk_col_name{end+1} = col_name{1};
    end
end
end

