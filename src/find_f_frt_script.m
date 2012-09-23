%
% find the focal distance which will results a minimum RMSE.
%

clc;
clear all;
clc;

% use the fminsearch matlab lib function to find the min, see more detail by typing 'doc fminsearch'


%[f_frt_min, rmse_min_value] = fminsearch(@find_f_frt_of_min_rmse,50.5206)

r = 60;

[f_frt_min, rmse_min_value] = fminsearch(@(f_frt) find_f_frt_of_min_rmse(f_frt,r),50.5206)

