%
%  Cal_Wavefront_it.m
%		
%  Parameter list:	
%    ray_obj - inout
%    r, k - in
%    parameter_package - in
%    asp_1, asp_2 - in
%	
%  Return value:
%    wave_result
%
%  function wave_result = Cal_Wvefront_it(ray_obj, r, k, parameter_package, asp_1, asp_2)
%
function wave_result = Cal_Wavefront_it(f_frt, r, k, ray_obj, parameter_package, asp_1_in, asp_2_in)
  lamda1 = parameter_package.lamda / parameter_package.n1;
  lamda2 = parameter_package.lamda / parameter_package.n2;
  n = parameter_package.n2;
  R1 = r;
  R2 = -r;
  f_eff = 1 / ((n - 1) * (-1 / R1 + 1 / R2 + (n - 1) * parameter_package.d / (n * R1 * R2)));
  %f_frt = f_eff * (1 - (n - 1) * d / (n * R2));
  f_bak = f_eff * (1 + (n - 1) * parameter_package.d / (n * R1));
  %
  %	init value of P1 P2 P3 P4
  %	P1 is never changed
  %
  % P1 = ray_obj.P1; really bad design of fminsearch interface!!!
  P1 = [0, f_frt];
  P2 = [ray_obj.P2.x, ray_obj.P2.y];
  P3 = [ray_obj.P3.x, ray_obj.P3.y];
  P4 = [ray_obj.P4.x, ray_obj.P4.y];
  %
  %	main loop to create Rays and cal the phase difference 
  %
  asp_1 = Len(r, k, asp_1_in.A2, asp_1_in.A4, asp_1_in.A6, asp_1_in.A8, asp_1_in.Dist);
  asp_2 = Len(-r, k, asp_2_in.A2, asp_2_in.A4, asp_2_in.A6, asp_2_in.A8, asp_2_in.Dist);

  Ray_objj = Ray(P1, P2, P3, P4, parameter_package.n1, parameter_package.n2);

  for j = 1:parameter_package.num_lgts
    i = j;
    asp_par = asp_1;
    %
    %	cal coords of P2
    %
    P2 = [i,asp_par.cal_y(i)];
    Ray_objj.P2.x = P2(1);
    Ray_objj.P2.y = P2(2);
    %
    %	cal coords of P3
    %
    theta = Ray_objj.refraction(asp_par, 1);
    asp_par = asp_2;
    P3 = Ray_objj.slove_p3(theta, i, asp_par);
    Ray_objj.P3.x = P3(1);
    Ray_objj.P3.y = P3(2);
    %
    %	cal coords of P4
    %
    theta = Ray_objj.refraction(asp_par,2);
    P4 = Ray_objj.solve_p4(theta, parameter_package.d, parameter_package.W); 
    Ray_objj.P4.x = P4(1);
    Ray_objj.P4.y = P4(2);
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
