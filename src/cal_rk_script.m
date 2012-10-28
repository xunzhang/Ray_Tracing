%
%
%  Processing 2 script
%
%

clc;
clear all;
clc;

[parameter_package, asp_1, asp_2, ray_obj] = Load_Input('input', 'len');
[f_frt_min, rmse_min_value] = fminsearch(@(f_frt) Find_f_frt_of_Min_Rmse(f_frt, ray_obj, parameter_package, asp_1, asp_2), 50.5206);

X0 = [60, -3.9];
Xmax = [60*1.1, 5];
Xmin = [60*0.9, -5];

options=optimset(@fminsearch);
options.Display = 'final';
%options.Display = 'iter-detailed';
%options.TolX = 0.001;
%options.MaxFunEvals = 50;
options.MaxIter = 5;    
options.TolFun = 0.1;

[a, b] = fminsearch(@(rk_pair) Final_Func(rk_pair, f_frt_min, ray_obj, parameter_package, asp_1, asp_2), [60, -3.9], options)
%[x, fval, exitflag, output, lambda, grad] = fmincon(@(rk_pair) Final_Func(rk_pair, f_frt_min, ray_obj, parameter_package, asp_1, asp_2), X0, [], [], [], [], Xmin, Xmax, [], options)
