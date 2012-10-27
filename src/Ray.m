classdef Ray
	%
	%   Summary of Len class goes here
	%       function Ray(P1_in, P2_in, P3_in, P4_in, n1_in, n2_in) is the Constructor
	%       function refraction(obj, asp_par_in, flag) is the refraction conduct and return a angle named theta
	%     	function slove_p3(obj, theta_in, i_in, asp_par_in) cal the coords of P3
	%		function solve_p4(obj, theta_in, d_in, W_in) cal the coords of P4
	%		Static function tan_asp_f(x, asp_par_in) is an basic func and call by the refraction func 
	%
	%   Detailed explanation goes below
	%
	properties
		n1
		n2
		P1 = struct('x',0,'y',0)
		P2 = struct('x',0,'y',0)
		P3 = struct('x',0,'y',0)
		P4 = struct('x',0,'y',0)
	end

	methods
		function obj = Ray(P1_in, P2_in, P3_in, P4_in, n1_in, n2_in)
			obj.P1.x = P1_in(1);
			obj.P1.y = P1_in(2);
			obj.P2.x = P2_in(1);
			obj.P2.y = P2_in(2);
			obj.P3.x = P3_in(1);
			obj.P3.y = P3_in(2);
			obj.P4.x = P4_in(1);
			obj.P4.y = P4_in(2);
            obj.n1 = n1_in;
            obj.n2 = n2_in;
		end
	end
	methods(Static)
		function del = tan_asp_f(x, asp_par_in)
            R = asp_par_in.R;
			k = asp_par_in.k;
			A2 = asp_par_in.A2;
		    A4 = asp_par_in.A4;
			A6 = asp_par_in.A6;
			A8 = asp_par_in.A8;			  
			f  = x ^2 / R;
			fp = 2 * x / R;
			g  = 1 + sqrt(1 - (k + 1) * x ^2 / R ^2);
			gp = -(k + 1) * x / R ^2 / (1 + sqrt(1 - (k + 1) * x ^2 / R ^2));
			del  = (fp * g - f * gp) / g ^2 + A2 * 2 * x + A4 * 4 * x ^3 + A6 * 6 * x ^5 + A8 * 8 * x ^7;
		end
	end
	methods
		function theta = refraction(obj, asp_par_in, flag)
            if(flag == 1)
				tmp_x1 = obj.P1.x;
				tmp_x2 = obj.P2.x;
				tmp_y1 = obj.P1.y;
				tmp_y2 = obj.P2.y;
				tmp_n1 = obj.n1;
				tmp_n2 = obj.n2;
            end
			if(flag == 2)
				tmp_x1 = obj.P2.x;
				tmp_x2 = obj.P3.x;
				tmp_y1 = obj.P2.y;
				tmp_y2 = obj.P3.y;
				tmp_n1 = obj.n2;
				tmp_n2 = obj.n1;
            end
        
			tan_ray1 = (tmp_y2 - tmp_y1) / (tmp_x2 - tmp_x1);
			if tmp_x1 == tmp_x2
				theta_ray1 = asin(1);
            elseif tan_ray1 < 0
				theta_ray1 = atan(tan_ray1) + asin(1) * 2;
				else
					theta_ray1 = atan(tan_ray1);
            end
			theta_norm = asin(1) + atan(Ray.tan_asp_f(tmp_x2, asp_par_in));

			theta_1 = theta_ray1 - theta_norm;

			theta_2 = asin(tmp_n1 / tmp_n2 * sin(theta_1));

			theta_ray2 = theta_norm + theta_2;

			theta = theta_ray2;
		end
		function p3_result = slove_p3(obj, theta_in, i_in, asp_par_in)
			a = tan(theta_in);
			b = -a * obj.P2.x + obj.P2.y;
			%lin_par = [a,b];
			x0 = i_in;
            options.TolFun = 1e-20;
            options.TolX = 1e-20;
			my_fun=@(x)((x ^2 / asp_par_in.R / (1 +(1 - (1 + asp_par_in.k) * (x / asp_par_in.R) ^2) ^0.5) + asp_par_in.A2 * x ^2 + asp_par_in.A4 * x ^4 + asp_par_in.A6 * x ^6 +asp_par_in.A8 * x^8 + asp_par_in.Dist) - (a * x + b));
            temp = fsolve(my_fun, x0, options);
            p3_result = [temp, asp_par_in.cal_y(temp)];
		end
		function p4_result = solve_p4(obj, theta_in, d_in, W_in)
			a = tan(theta_in);
			b = -a * obj.P3.x + obj.P3.y;
			p4_result = [(-d_in - W_in - b) / a, -d_in - W_in];
		end
    end
end

