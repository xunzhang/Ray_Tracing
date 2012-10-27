%
%  Cal_Wavefront.m
%		
%  Parameter list:	
%    ray_obj - inout
%    parameter_package - in
%    asp_1, asp_2 - in
%	
%  Return value:
%    wave_result
%
%  function wave_result = Cal_Wavefront(ray_obj, parameter_package, asp_1, asp_2)
%
function wave_result = Cal_Wavefront(f_frt, ray_obj, parameter_package, asp_1, asp_2)
  lamda1 = parameter_package.lamda / parameter_package.n1;
  lamda2 = parameter_package.lamda / parameter_package.n2;
  n = parameter_package.n2;
  R1 = asp_1.R;
  R2 = asp_2.R;
  f_eff = 1 / ((n - 1) * (-1 / R1 + 1 / R2 + (n - 1) * parameter_package.d / (n * R1 * R2)));
  %f_frt = f_eff * (1 - (n - 1) * d / (n * R2));
  f_bak = f_eff * (1 + (n - 1) * parameter_package.d / (n * R1));
  %
  %	init value of P1 P2 P3 P4
  %	P1 is never changed
  %
  % P1 = ray_obj.P1; really bad design of fminsearch interface!!!
  P1 = [0, f_frt]
  P2 = ray_obj.P2
  P3 = ray_obj.P3
  P4 = ray_obj.P4
  %
  %	main loop to create Rays and cal the phase difference 
  %
  for j = 1:parameter_package.num_lgts
    i = j;
    asp_par = asp_1;
    %
    %	cal coords of P2
    %
    P2 = [i,asp_par.cal_y(i)];
    %
    %	cal coords of P3
    %
    theta = ray_obj.refraction(asp_par, 1);
    asp_par = asp_2;
    P3 = ray_obj.slove_p3(theta, i, asp_par);
    %
    %	cal coords of P4
    %
    theta = ray_obj.refraction(asp_par,2);
    P4 = ray_obj.solve_p4(theta, parameter_package.d, parameter_package.W); 
    %
    %	cal the phase difference of every ray
    %
    wavefront(j+1, 1) = i;
    wavefront(j+1, 2) = Dist(P1,P2) / lamda1 + Dist(P2,P3) / lamda2 + Dist(P3,P4) / lamda1;
  end
  %
  %	assign the boundary value
  %
  wavefront(1,1) = 0;
  wavefront(1,2) = P1(2) / lamda1 + parameter_package.d / lamda2 + parameter_package.W / lamda1;
  wavefront(:,2) = wavefront(1,2) - wavefront(:,2);
  %
  %	return the wavefront
  %
  wave_result = wavefront;
end