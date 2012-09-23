%
%	cal_wavefront_and_polt.m
%		
%	Input parameter:	
%
%	Output parameter:
%		wave_result	
%	
%	function wave_result = cal_wavefront_and_polt()
%


function wave_result = cal_wavefront_and_polt()
	
	%
	%	read the para from 'input.txt'
	%
    fid = fopen('input.txt', 'r');
    Num_Lgts = fscanf(fid, '%d', 1);
    n1 = fscanf(fid, '%f', 1);
    n2 = fscanf(fid, '%f', 1);
    d = fscanf(fid, '%f', 1);
    W = fscanf(fid, '%f', 1);
    lamda = fscanf(fid, '%f', 1);
    
    lamda1 = lamda / n1;
    lamda2 = lamda / n2;

	%
	%	new two Len object.
	%	asp_1 is left side of the Len and asp_2 is right side of the Len
	%
    asp_1 = Len(-60,-3.9,0,0,0,0,0);
    asp_2 = Len(60,-3.9,0,0,0,0,-d);

    figure(1);
    hold;

    for i=1:140
        asp_plot(i,1) = i / 10;
        asp_plot(i,2) = asp_1.cal_y(asp_plot(i,1));
    end
    sym_plot(asp_plot);

    for i=1:140
        asp_plot(i,1) = i / 10;
        asp_plot(i,2) = asp_2.cal_y(asp_plot(i,1));
    end
    sym_plot(asp_plot);

    n = n2;
    R1 = asp_1.R;
    R2 = asp_2.R;
    f_eff = 1 / ((n - 1) * (-1 / R1 + 1 / R2 + (n - 1) * d / (n * R1 * R2)));
    f_frt = f_eff * (1 - (n - 1) * d / (n * R2));
    f_bak = f_eff * (1 + (n - 1) * d / (n * R1));
	
	%
	%	init value of P1 P2 P3 P4
	%	P1 is never changed
	%
    P1 = [0, f_frt];
    P2 = [0, 0];
    P3 = [0, -d];
    P4 = [0, -d-W];
	
	%
	%	new a Ray object
	%
    Ray_obj = Ray(P1, P2, P3, P4, n1, n2);
    sym_plot([P1;P2;P3;P4]);
    
	%
	%	main loop to create Rays and cal the phase difference 
	%
	for j=1:Num_Lgts
        i = j;
        asp_par = asp_1;
	
		%
		%	cal coords of P2
		%
    	P2 = [i,asp_par.cal_y(i)];
        Ray_obj.P2.x = P2(1); Ray_obj.P2.y = P2(2);

		%
		%	cal coords of P3
		%
        theta = Ray_obj.refraction(asp_par, 1);
        asp_par = asp_2;
    	P3 = Ray_obj.slove_p3(theta, i, asp_par);
    	Ray_obj.P3.x = P3(1); Ray_obj.P3.y = P3(2);
    
		%
		%	cal coords of P4
		%
    	theta = Ray_obj.refraction(asp_par,2);
    	P4 = Ray_obj.solve_p4(theta, d, W); 
        Ray_obj.P4.x = P4(1); Ray_obj.P4.y = P4(2);
	
		%
		%	cal the phase difference of every Ray
		%
        wavefront(j+1, 1) = i;
        wavefront(j+1, 2) = dist(P1,P2) / lamda1 + dist(P2,P3) / lamda2 + dist(P3,P4) / lamda1;
        sym_plot([P1;P2;P3;P4]);
        %debug = [P1;P2;P3;P4]
    end
	
	%
	%	assign the boundary value
	%
    wavefront(1,1) = 0;
    wavefront(1,2) = P1(2) / lamda1 + d / lamda2 + W / lamda1;
    wavefront(:,2) = wavefront(1,2) - wavefront(:,2);

    figure(2);
   	hold;
    sym_plot(wavefront);

	%
	%	return the wavefront
	%
    wave_result = wavefront;
end
