%
%  Find_f_frt_of_Min_Rmse_it.m
%
%  Parameter list:
%    f_frt - in
%    r, k - in    
%    ray_obj - inout
%    parameter_package - in
%    asp_1, asp_2 - in
%
%  Return value:  
%    rmse
%
%  function rmse = Find_f_frt_of_Min_Rmse_it(f_frt, r, k, ray_obj, parameter_package, asp_1, asp_2)
%
function rmse = Find_f_frt_of_Min_Rmse_it(f_frt, r, k, ray_obj, parameter_package, asp_1, asp_2)
  wavefront = Cal_Wavefront_it(f_frt, r, k, ray_obj, parameter_package, asp_1, asp_2);
  weights = Cal_Wgts(parameter_package)
  rmse = Cal_Rmse(parameter_package, weights, wavefront)
end
