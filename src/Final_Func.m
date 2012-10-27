%
%  Final_Func.m
%
%  Parameter list: 
%    rk_pair - in
%    f_frt_min - in
%    ray_obj - inout
%    parameter_package - in
%    asp_1, asp_2 - in
%
%  Return value:
%    result
%
%  function result = Final_Func(rk_pair, f_frt_min, ray_obj, parameter_package, asp_1, asp_2)
%
function result = Final_Func(rk_pair, f_frt_min, ray_obj, parameter_package, asp_1, asp_2)
  r = rk_pair(1);
  k = rk_pair(2);
  f = fminsearch(@(f_frt) Find_f_frt_of_Min_Rmse_it(f_frt, r, k, ray_obj, parameter_package, asp_1, asp_2), f_frt_min);
  result = abs(f(1) - f_frt_min));
end
