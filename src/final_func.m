% clc;
% clear all;
% clc;
function res = final_func(xx)

	
	r = xx(1)
    s = xx(2)
% 	r = 61;
% 	s = -3.8;

	f0 = cal_min_f_frt()
	b0 = cal_wavefront(f0, r, s)
	%r = 61;
	%s = -3.8;
    
%     options=optimset(@fminsearch);
%     options.Display         = 'final';
    
	f = fminsearch(@(f_frt) find_f_frt_of_min_rmse_2(f_frt,r,s), [50.5206, r, s])
	b = cal_wavefront2(f(1), r, s)
	
	tmp = b(:,2) - b0(:,2)

    
	size_here = size(tmp);
	size_here = size_here(1);
    
    wgts_result = cal_wgts();
    
     for i = 1:size_here
        bb(i) = tmp(i) * wgts_result(i);
        b0(i,2) = b0(i,2) * wgts_result(i);
    end 
  
    rmse_fm = std(bb)
    rmse = std(b0(:,2))
    
	res = abs(f(1) - f0) / f0 + rmse_fm(1)/rmse(1)
end
