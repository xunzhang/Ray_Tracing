%
%	find_f_frt_of_min_rmse.m
%
% 	Input parameter: 
%		f_frt
%
%	Output parameter: 
%		rmse
%
% 	function rmse = find_f_frt_of_min_rmse(f_frt)
%

function rmse = find_f_frt_of_min_rmse(f_frt, r, s)
	
	%r = 2;

    wavefront = cal_wavefront(f_frt, r, s);

	weights = cal_wgts();

	rmse = cal_rmse(weights, wavefront);
end
