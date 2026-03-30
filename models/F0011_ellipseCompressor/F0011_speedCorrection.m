function [N_corr, N_corr_n] = F0011_speedCorrection(w_c, T, par)
% rad/sec -> rpm
N = w_c .* 30/pi;

% speed correction
N_corr = N ./sqrt(T./par.T_ref);

% speed ratio
N_corr_n = N_corr ./ par.Nc_max_map;
end