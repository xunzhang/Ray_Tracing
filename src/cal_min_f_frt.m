function f_frt_min = cal_min_f_frt()

	r = 60;
	s = 0;
    options=optimset(@fminsearch);
    options.Display         = 'final';
	f_frt_min = fminsearch(@(f_frt) find_f_frt_of_min_rmse(f_frt,r,s),50.5206,options)

end
