function [alpha_estimated, beta_ambig_estimated, beta_conf_estimated, gamma_estimated, ...
    mean_risk, mean_ambig, mean_conflict, mean_conflict_corrected, mean_ambig_corrected] = ...
    CONFLICT_fit_parameters_single_participant( ...
    participant_id, ambig_choice_table, conflict_choice_table, risk_choice)
%CONFLICT_FIT_PARAMETERS Summary of this function goes here
%   Detailed explanation goes here

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get participants data
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[A_ambig, v_ambig, choice_ambig, ...
    A_conflict, v_conflict, choice_conflict, ...
    A_risk, v_risk, choice_risk] = ...
    CONFLICT_participant_data(...
    participant_id, ambig_choice_table, conflict_choice_table, risk_choice);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get model free data
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mean_risk = mean(choice_risk);
mean_ambig = mean(choice_ambig);
mean_conflict = mean(choice_conflict);
mean_conflict_corrected = mean_conflict - mean_risk;
mean_ambig_corrected = mean_ambig - mean_risk;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fit data to model
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sv = @(p, beta, A, v, alpha) (p-beta.*(A/2)).*v.^alpha;
% sv_f, sv_v: subjective value Fixed and Variable
p_v = @(sv_f, sv_v, gamma) 1./(1+exp(gamma*(sv_f-sv_v)));


    function p_all_choices = ...
            p_choice(alpha, beta, gamma, A, v_uncertain, is_uncertain_choice)
        sv_fixed = sv(0.5, beta, 0, V_CERATIN, alpha);
        sv_uncertain = sv(0.5, beta, A, v_uncertain, alpha);
        p_uncertain = p_v(sv_fixed, sv_uncertain, gamma);
        p_all_choices = p_uncertain.*is_uncertain_choice + (1-p_uncertain).*~is_uncertain_choice;
        % Synonymous to (but in the order of the original values:
        % [p_uncertain(is_uncertain_choice) ...
        % 1-(p_uncertain(~is_uncertain_choice))];
    end

    function all_decisions_p = all_decisions_probability(behavioral_parameters)
        alpha = behavioral_parameters(1);
        beta_conf = behavioral_parameters(2);
        beta_ambig = behavioral_parameters(3);
        gamma = behavioral_parameters(4);

        p_all_choices_risk = p_choice(alpha, beta_conf, gamma, A_risk, v_risk, choice_risk); % Not to be confused, beta_conf is used here but it doesn't matter since ambiguity here is 0.
        p_all_choices_conflict = p_choice(alpha, beta_conf, gamma, A_conflict, v_conflict, choice_conflict);
        p_all_choices_ambig = p_choice(alpha, beta_ambig, gamma, A_ambig, v_ambig, choice_ambig);

        all_decisions_p = [p_all_choices_risk, p_all_choices_conflict, p_all_choices_ambig];
    end

% Define the negative log-likelihood function
likelihood = @(behavioral_parameters) -sum(log(all_decisions_probability(behavioral_parameters)));

V_CERATIN = 5;
% Set initial parameter values
initial_params = [0.8, 0, 0, 0.1];

PARAMETER_SEARCH = 'grid'; %
if strcmp(PARAMETER_SEARCH, 'fmincon')
    % Define the constraint function
    constraint_func = @(behavioral_parameters) deal(behavioral_parameters(1), behavioral_parameters(4));

    % Set lower bounds for the parameters
    lb = [0, -Inf, -Inf, 0];

    % Perform maximum likelihood estimation using fmincon
    optimization_options = optimset('MaxFunEvals', 5000, 'PlotFcns', @optimplotfval);
    % estimated_params = fmincon(likelihood, initial_params, [], [], [], [], lb, [], constraint_func, optimization_options);
    estimated_params = fmincon(likelihood, initial_params, [], [], [], [], lb, [], [], optimization_options);

elseif strcmp(PARAMETER_SEARCH, 'fminsearch')
    % Perform maximum likelihood estimation using fminsearch
    optimization_options = optimset('MaxFunEvals',5000);
    estimated_params = fminsearch(likelihood, initial_params, optimization_options);

elseif strcmp(PARAMETER_SEARCH, 'grid')
    SEARCH_RESOLUTION = 7;
    MIN_ALPHA = 0.05;
    MIN_GAMMA = 0.05;
    % Define initial parameter ranges and step sizes
    alpha_range = linspace(MIN_ALPHA, 4, SEARCH_RESOLUTION);
    % beta_ambig_range = linspace(-3, 3, SEARCH_RESOLUTION);
    % beta_conf_range = linspace(-3, 3, SEARCH_RESOLUTION);
    beta_ambig_range = linspace(-1, 1, SEARCH_RESOLUTION);
    beta_conf_range = linspace(-1, 1, SEARCH_RESOLUTION);

    gamma_range = linspace(MIN_GAMMA, 20, SEARCH_RESOLUTION);

    % Define the number of iterations for refinement
    num_iterations = 4;

    % Initialize variables for storing best parameter values and likelihood
    best_likelihood = Inf;
    best_params = [];

    % Perform iterative grid search
    for iteration = 1:num_iterations

        % Perform grid search within the current parameter ranges
        for alpha = alpha_range
            for beta_ambig = beta_ambig_range
                for beta_conf = beta_conf_range
                    for gamma = gamma_range
                        % Set the current parameter values
                        behavioral_params = [alpha, beta_ambig, beta_conf, gamma];

                        % Compute the likelihood for the current parameter values
                        current_likelihood = likelihood(behavioral_params);

                        % Update the best parameters if the current likelihood is lower
                        if current_likelihood < best_likelihood
                            best_likelihood = current_likelihood;
                            best_params = behavioral_params;
                        end
                    end
                end
            end
        end

        % Update the parameter ranges for the next iteration based on the best parameters
        alpha_center = best_params(1);
        beta_ambig_center = best_params(2);
        beta_conf_center = best_params(3);
        gamma_center = best_params(4);
        
        half_resolution = @(range) (range(end)-range(1))./4;
        % Define the updated parameter ranges with increased resolution
        alpha_range = linspace(max(MIN_ALPHA, alpha_center-half_resolution(alpha_range)), alpha_center+half_resolution(alpha_range), SEARCH_RESOLUTION);
        beta_ambig_range = linspace(beta_ambig_center-half_resolution(beta_ambig_range), beta_ambig_center+half_resolution(beta_ambig_range), SEARCH_RESOLUTION);
        beta_conf_range = linspace(beta_conf_center-half_resolution(beta_conf_range), beta_ambig_center+half_resolution(beta_conf_range), SEARCH_RESOLUTION);
        gamma_range = linspace(max(MIN_GAMMA, gamma_center-half_resolution(gamma_range)), gamma_center+half_resolution(gamma_range), SEARCH_RESOLUTION);
    end
    estimated_params = best_params;
end


% Extract the estimated parameter values
alpha_estimated = estimated_params(1);
beta_ambig_estimated = estimated_params(2);
beta_conf_estimated = estimated_params(3);
gamma_estimated = estimated_params(4);
end

