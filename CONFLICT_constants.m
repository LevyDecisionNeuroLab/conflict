function CONSTANTS = CONFLICT_constants()

CONSTANTS = struct;

CONSTANTS.DATA.PATH = ['CONFLICT-data/Conflict 2023 - ' ...
    'conflict in separate block_June 17, 2023_13.29 - Sheet1.csv'];

%% Exclusion criteria
CONSTANTS.DATA.MIN_VALID_CATCH_TRIAL = 2/3; % Minimal proportion of catch
% trials that should be asnwered correctly to be considered a valid
% participant

%% How data is coded
CONSTANTS.DATA.CHOICE_VALUE.RISK = 'risk';
CONSTANTS.DATA.CHOICE_VALUE.AMBIG = 'ambiguous';
CONSTANTS.DATA.CHOICE_VALUE.CONFLICT = 'conflict';
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Columns name
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Columns name - risk
CONSTANTS.DATA.COLUMN.RISK = {'risk_c50_r5', 'risk_c50_r6', ...
    'risk_c50_r7', 'risk_c50_r8','risk_c50_r10', 'risk_c50_r12', ...
    'risk_c50_r14', 'risk_c50_r16', 'risk_c50_r19', 'risk_c50_r23', ...
    'risk_c50_r27','risk_c50_r31', 'risk_c50_r37', 'risk_c50_r44', ...
    'risk_c50_r52','risk_c50_r61', 'risk_c50_r73',  'risk_c50_r86',...
    'risk_c50_r101', 'risk_c50_r110', ...
    'risk_c25_r120'};
% Note that the last value 'risk_c25_r120' has a different prefix -
% this is just a wrong namgin of the column (made in qulatricks) but it
% does refer to a 50% risk trial. To generate this list, call the function:
% CONFLICT_get_risk_col_names()

%% Columns name - ambiguity
CONSTANTS.DATA.COLUMN.AMB_40 = { 'amb_c40_r5', 'amb_c40_r6', 'amb_c40_r7',...
    'amb_c40_r8', 'amb_c40_r10', 'amb_c40_r12', 'amb_c40_r14',...
    'amb_c40_r16', 'amb_c40_r19', 'amb_c40_23', 'amb_c40_r27', ...
    'amb_c40_r31', 'amb_c40_r37', 'amb_c40_r44', 'amb_c40_r52', ...
    'amb_c40_r61', 'amb_c40_r73', 'amb_c40_r86', 'amb_c40_r101', ...
    'amb_c40_110', 'amb_c40_r120'};
% To generate this list, call the function:
%   CONFLICT_get_ambig_col_names(data, 40)

CONSTANTS.DATA.COLUMN.AMB_25 = { 'amb_c25_r5', 'amb_c25_r6', ...
    'amb_c10_r7',... % Note that due to code naming error this is coded as "c10" but it does refer to a conflict of 25. The column 'amb_c10_7' (with no 'r') does refere to a conflict level of 10.
    'amb_c25_r8', 'amb_c25_r10', 'amb_c25_r12', ...
    'amb_c25_r14', 'amb_c25_r16', 'amb_c25_r19', ...
    'amb_c25_r23', 'amb_c25_r27', 'amb_c25_r31', ...
    'amb_c25_r37', 'amb_c25_r44', 'amb_c25_r52', 'amb_c25_r61', ...
    'amb_c25_r73', 'amb_c25_r86' , 'amb_c25_101', 'amb_c25_r110', ...
    'amb_c25_r120'};
% To generate this list, call the function:
%   CONFLICT_get_ambig_col_names(data, 25)


CONSTANTS.DATA.COLUMN.AMB_10 = {'amb_c10_r5', 'amb_c10_r6', ...
    'amb_c10_7', 'amb_c10_r8', 'amb_c10_r10', 'amb_c10_r12', ...
    'amb_c10_r14', 'amb_c10_r16', 'amb_c10_r19', 'amb_c10_r23', ...
    'amb_c10_r27', 'amb_c10_r31', 'amb_c10_r37', 'amb_c10_r44', ...
    'amb_c10_r52', 'amb_c10_r61', 'amb_c10_r73', 'amb_c10_r86', ...
    'amb_c10_r101', 'amb_c10_r110', 'amb_c10_r120'};
% To generate this list, call the function:
%   CONFLICT_get_ambig_col_names(data, 10)

%% Columns name - conflict
CONSTANTS.DATA.COLUMN.CONF_40 = {'con_c40_r5', 'con_c40_r6', ...
    'con_c40_r7', 'con_c40_r8', 'con_c40_r10', 'con_c40_r12', ...
    'con_c40_r14', 'con_c40_r16', 'con_c40_r19', 'con_c40_r23', ...
    'con_c40_r27', 'con_c40_r31', 'con_c40_r37', 'con_c40_r44', ...
    'con_c40_r52', 'con_c40_r61', 'con_c40_r73', 'con_c40_r86', ...
    'con_c40_r101', 'con_c40_r110', 'con_c40_r120'};
% CONFLICT_get_conflict_col_names(data, 40)

CONSTANTS.DATA.COLUMN.CONF_25 = {'con_c25_r5', 'con_c25_r6', ...
    'con_c25_r7', 'con_c25_r8', 'con_c25_r10', 'con_c25_r12',...
    'con_c25_r14', 'con_c25_r16', 'con_c25_r19', 'con_c25_r23',...
    'con_c25_r27', 'con_c25_r31', 'con_c25_r37', 'con_c25_r44',...
    'con_c25_r52', 'con_c25_r61', 'con_c25_r73', 'con_c25_r86',...
    'con_c25_101', 'con_c25_r110', 'con_c25_r120'};

% CONFLICT_get_conflict_col_names(data, 25)

CONSTANTS.DATA.COLUMN.CONF_10 = {'con_c10_r5', 'con_c10_r6', 'con_c10_r7',...
    'con_c10_r8', 'con_c10_r10', 'con_c10_r12', 'con_c10_r14', ...
    'con_c10_r16', 'con_c10_r19', 'con_c10_r23', 'con_c10_r27', ...
    'con_c10_r31', 'con_c10_r37', 'con_c10_r44', 'con_c10_r52', ...
    'con_c10_r61', 'con_c10_r73', 'con_c10_r86', 'con_c10_r101', ...
    'con_c10_r110', 'con_c10_r120'};
% CONFLICT_get_conflict_col_names(data, 10)

%% Plotting constants
CONSTANTS.COLORS.CONFLICT = [255 118 122]./255;
CONSTANTS.COLORS.AMBIGUITY = [91 155 213]./255;
CONSTANTS.COLORS.RISK = [197 224 180]./255;

CONSTANTS.SYMBOLS.P_SPREAD_10 = '+';
CONSTANTS.SYMBOLS.P_SPREAD_20 = '*';
CONSTANTS.SYMBOLS.P_SPREAD_30 = 'O';
CONSTANTS.SYMBOLS.COLOR = 'k';

end
