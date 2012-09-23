classdef Len 
    
	%
    %	Summary of Len class goes here
	%		function Len(R_in, k_in, A2_in, A4_in, A6_in, A8_in, Dist_in) is the Constructor
	%		function cal_y(obj, x) is to cal another para based on input para
	%		
	%   Detailed explanation goes below
	%

    properties
        R
        k
        A2
        A4
        A6
        A8
        Dist
    end
    
    methods
        function obj = Len(R_in, k_in, A2_in, A4_in, A6_in, A8_in, Dist_in)
            obj.R = R_in;
            obj.k = k_in;
            obj.A2 = A2_in;
            obj.A4 = A4_in;
            obj.A6 = A6_in;
            obj.A8 = A8_in;
            obj.Dist = Dist_in;
        end          
      	function asp_y = cal_y(obj, x)
            asp_y = x ^2 / obj.R / (1 + (1 - (1 + obj.k) * (x / obj.R) ^2) ^0.5) + obj.Dist + obj.A2 * x ^2 + obj.A4 * x ^4 + obj.A6 * x ^6 + obj.A8 * x ^8;
        end
    end
end

