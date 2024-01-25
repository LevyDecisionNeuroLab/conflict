function v = table_numerical_col_name(t)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
values = t.Properties.VariableNames;
v = zeros(size(values));
for ii = 1:length(values)
    v(ii) = str2double(values{ii});
end
end

