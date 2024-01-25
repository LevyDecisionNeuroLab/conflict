function [valid_participant_data, n_initial_participants, n_valid] = CONFLICT_return_valid_participants(is_plot)
%CONFLICT_RETURN_VALID_PARTICIPANTS Summary of this function goes here
%   Detailed explanation goes here
if nargin==0
    is_plot=false;
end


CONSTANS = CONFLICT_constants();
% Load the raw CSV data file into a table (assuming it has a header row)

% Read the table
data = readtable(CONSTANS.DATA.PATH);

%% Filter participant by overall time
% Exclude participants taking 2std more than the mean time

duration_column = data.Duration_inSeconds_;

% Convert seconds to minutes
duration_minutes = duration_column / 60;

% Compute the statistics
mean_duration = mean(duration_minutes);
std_duration = std(duration_minutes);
max_duration = max(duration_minutes);
min_duration = min(duration_minutes);
cutoff_max = mean_duration + 2 * std_duration;
cutoff_min = 10;

% Print the statistics
fprintf('Overall experiment time statistics:\n');
fprintf('\tMean: %.2f minutes\n', mean_duration);
fprintf('\tStandard Deviation: %.2f minutes\n', std_duration);
fprintf('\tMaximum: %.2f minutes\n', max_duration);
fprintf('\tMinimum: %.2f minutes\n', min_duration);
fprintf('\tCutoff (Maximum): %.2f minutes\n', cutoff_max);
fprintf('\tCutoff (Minimum): %.2f minutes\n', 10);

participants_valid_time = data((duration_minutes<cutoff_max) & (duration_minutes>cutoff_min), :);
percent_valid_by_time = 100-100*(size(data,1)-size(participants_valid_time, 1))./size(data,1);
if is_plot
    title('Experiment completion time')
    plot(sort(duration_minutes),'*-');
    yline(cutoff_max, 'r');
    yline(cutoff_min, 'r');
    CONFLICT_set_labels('Participants (sorted)', 'Completion time (Minutes)');
    legend('Participants', ['Valid time threshold (' num2str(round(percent_valid_by_time , 1)) '%)'])
end
%% Filter by answers to catch trials
mean_correct_catch_trial = mean( ...
    (participants_valid_time.Q90 == 12) & ...
    strcmp(participants_valid_time.Q91, 'drums') & ...
    strcmp(participants_valid_time.Q118, 'Thursday'), ...
    2);

min_valid_proportion = CONSTANS.DATA.MIN_VALID_CATCH_TRIAL;
valid_participant_data = participants_valid_time( ...
    mean_correct_catch_trial>=min_valid_proportion, :);

%% Print participants statistics
n_initial_participants = size(data,1);
n_valid = size(valid_participant_data, 1);

% Create a table to display the summary
summary_table = table(n_initial_participants, n_valid, ...
    'VariableNames', {'Total Participants', 'Valid Participants'});

% Display the summary table
disp(summary_table);

% Print an informative message
% fprintf('Out of %d initial participants, %d are considered valid.\n', ...
%     n_initial_participants, n_valid);
% Assuming you have already calculated the variables n_initial_participants and n_valid
% Assuming you have already calculated the variables n_initial_participants and n_valid
percentage_exclusion = (n_initial_participants - n_valid) / n_initial_participants * 100;

fprintf('Out of %d initial participants, %d are considered valid (%.1f%% percentage exclusion) \n', ...
    n_initial_participants, n_valid, percentage_exclusion);

end

