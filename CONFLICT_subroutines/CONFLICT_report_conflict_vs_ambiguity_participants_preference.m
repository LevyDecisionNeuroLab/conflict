function CONFLICT_report_conflict_vs_ambiguity_participants_preference(corrected_conflict,corrected_ambig)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    percent_gt = mean(corrected_conflict > corrected_ambig) * 100;
    percent_eq = mean(corrected_conflict == corrected_ambig) * 100;
    percent_lt = mean(corrected_conflict < corrected_ambig) * 100;

    % Display results
    fprintf('Conflict > Ambiguity: %.3f%%\n', percent_gt);
    fprintf('Conflict = Ambiguity: %.3f%%\n', percent_eq);
    fprintf('Conflict < Ambiguity: %.3f%%\n', percent_lt);
end

