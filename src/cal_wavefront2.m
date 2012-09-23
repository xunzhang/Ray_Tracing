%
%	cal_wavefront.m
%		
%	Input parameter:	
%		f_frt
%
%	Output parameter:
%		wave_result	
%	
%	function wave_result = cal_wavefront(f_frt)
%


function wave_result = cal_wavefront2(f_frt, r, s)
	
	%
	%	read paras from 'input.txt'
	%
	%fid = fopen('input', 'r')
    Num_Lgts = 12;%fscanf(fid, '%d', 1);
    n1 = 1.0;%fscanf(fid, '%f', 1);
    n2 = 1.58492;%fscanf(fid, '%f', 1);
    d = 4.8;%fscanf(fid, '%f', 1);
    W = 10.0;%fscanf(fid, '%f', 1);
    lamda = 6.3280e-04;%fscanf(fid, '%f', 1);
    lamda1 = lamda / n1;
    lamda2 = lamda / n2;

	%
	%	read len paras from 'len.txt'
	%	new two Len object.
	%	asp_1 is left side of the Len and asp_2 is right side of the Len
	%
    %len_fid = fopen('len', 'r');
	%len_R = fscanf(len_fid, '%f', 1);
	%len_k = fscanf(len_fid, '%f', 1);
	%len_A2 = fscanf(len_fid, '%f', 1);
	%len_A4 = fscanf(len_fid, '%f', 1);
	%len_A6 = fscanf(len_fid, '%f', 1);
	%len_A8 = fscanf(len_fid, '%f', 1);
	%len_Dist = fscanf(len_fid, '%f', 1);
	%len2_Dist = fscanf(len2_fid, '%f', 1);

	asp_1 = Len(-r,s,0,0,0,0,0);
    asp_2 = Len(r,s,0,0,0,0,-d);
	%asp_1 = Len(len_R, len_k, len_A2, len_A4, len_A6, len_A8, len_Dist);
	%asp_2 = Len(-len_R, len_k, len_A2, len_A4, len_A6, len_A8, -d);

    %figure(1);
    %hold;

    %for i=1:140
    %    asp_plot(i,1) = i / 10;
    %    asp_plot(i,2) = asp_1.cal_y(asp_plot(i,1));
    %end
    %sym_plot(asp_plot);

    %for i=1:140
    %    asp_plot(i,1) = i / 10;
    %    asp_plot(i,2) = asp_2.cal_y(asp_plot(i,1));
    %end
    %sym_plot(asp_plot);

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
    %sym_plot([P1;P2;P3;P4]);
    
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
        %sym_plot([P1;P2;P3;P4]);
        %debug = [P1;P2;P3;P4]
    end
	
	%
	%	assign the boundary value
	%
    wavefront(1,1) = 0;
    wavefront(1,2) = P1(2) / lamda1 + d / lamda2 + W / lamda1;
    wavefront(:,2) = wavefront(1,2) - wavefront(:,2);

    %figure(2);
    %hold;
    %sym_plot(wavefront);

	%
	%	return the wavefront
	%
    wave_result = wavefront;
end
