function CONFLICT_report_correlation(v1,v2, name_1, name_2)
%CONFLICT_REPORT_CORRELATION Summary of this function goes here
%   Detailed explanation goes here
[r1, p1] = corrcoef(v1, v2);

% Print informative messages
fprintf(['Correlation between' name_1 ' and ' name_2 ':\n']);
fprintf('r = %.2f\n', r1(1, 2));
fprintf('p-value = %3f\n\n', p1(1, 2));
end

