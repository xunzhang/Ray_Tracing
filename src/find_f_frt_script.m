%
% Find the focal distance which results a minimum RMSE.
%
% Use the fminsearch matlab lib function to find the min, see more detail by typing 'doc fminsearch'.
%
clc;
clear all;
clc;

[parameter_package, asp_1, asp_2, ray_obj] = Load_Input('../config/input', '../config/len');
[f_frt_min, rmse_min_value] = fminsearch(@(f_frt) Find_f_frt_of_Min_Rmse(f_frt, ray_obj, parameter_package, asp_1, asp_2), 50.5206)
