%
%
%  Processing 2 script
%
%

clc;
clear all;
clc;

X0 = [60, -3.9];
Xmax = [60*1.1,10];
Xmin = [60*0.9,-10];
options=optimset(@fmincon);
%options.Display = 'iter-detailed';
options.Display = 'final';
options.MaxFunEvals = 50;
options.MaxIter = 10;    
options.DiffMaxChange = 0.5;
options.DiffMinChange = 0.2; 

[parameter_package, asp_1, asp_2, ray_obj] = Load_Input('../config/input', '../config/len');
[f_frt_min, rmse_min_value] = fminsearch(@(f_frt) Find_f_frt_of_Min_Rmse(f_frt, ray_obj, parameter_package, asp_1, asp_2), 50.5206);
[x, fval, exitflag, output, lambda, grad] = fmincon(@(rk_pair) Final_Func(rk_pair, f_frt_min, ray_obj, parameter_package, asp_1, asp_2), X0, [], [], [], [], Xmin, Xmax, [], options)
