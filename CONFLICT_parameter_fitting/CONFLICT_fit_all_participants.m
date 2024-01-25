function participants = CONFLICT_fit_all_participants(data, ambig_choice_table, conflict_choice_table, risk_choice)
%CONFLICT_FIT_ALL_PARTICIPANTS Summary of this function goes here
%   Detailed explanation goes here
saved_results_exist = exist('CONFLICT_parameter_fitting/fitted_parameters_saved_calculation.mat', 'file');

if saved_results_exist
    % Load saved results
    load('CONFLICT_parameter_fitting/fitted_parameters_saved_calculation.mat', 'participants');
else

    % Initialize the struct array
    participants = struct('mean_risk', [],...
        'mean_ambig', [], 'mean_ambig_corrected', [],...
        'mean_conflict', [], 'mean_conflict_corrected', [],...
        'alpha', [], 'beta_conflict', [], 'beta_ambig', [], 'gamma', []);

    num_participants = height(data);
    for participant_id = 1:num_participants
        fprintf('Participant ID: %d\r', participant_id);

        % Fit current participant
        [alpha_estimated, beta_ambig_estimated, beta_conf_estimated, gamma_estimated,...
            mean_risk, mean_ambig, mean_conflict, mean_conflict_corrected, mean_ambig_corrected] = ...
            CONFLICT_fit_parameters_single_participant(participant_id, ...
            ambig_choice_table, conflict_choice_table, risk_choice);
        % Add the properties to the participant struct
        participants(participant_id).mean_risk = mean_risk;
        participants(participant_id).mean_ambig = mean_ambig;
        participants(participant_id).mean_ambig_corrected = mean_ambig_corrected;
        participants(participant_id).mean_conflict = mean_conflict;
        participants(participant_id).mean_conflict_corrected = mean_conflict_corrected;

        % Assign alpha, beta, and gamma values to the participant struct
        participants(participant_id).alpha = alpha_estimated;
        participants(participant_id).beta_conflict = beta_conf_estimated;
        participants(participant_id).beta_ambig = beta_ambig_estimated;
        participants(participant_id).gamma = gamma_estimated;
    end

    save('CONFLICT_parameter_fitting/fitted_parameters_saved_calculation.mat', 'participants');
end
end

