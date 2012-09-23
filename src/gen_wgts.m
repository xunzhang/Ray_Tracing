%
%	gen_wgts.m
%	
%	Input parameter:
%		input_vec: the sequence of the Ray
%		str: method to produce wgts more below
%			'normal'-----
%			'dist_wgt'-----
%			'inv_dist_wgt'-----
%			'triangle'-----
%			'Gauss'-----
%
%	Output parameter:
%		wgts_result
%
%	function wgts_result = gen_wgts(input_vec, str)
%

function wgts_result = gen_wgts(input_vec, str)
    
	tmp = size(input_vec);
    length = tmp(1);
    
    if(strcmp(str, 'normal') == 1)
        for i = 1:length
            wgts_result(i) = 1 / (2 * length - 1);
        end
    end
    
    if(strcmp(str, 'dist_wgt') == 1)
        wgts_result(1) = 0;
        sum_dists = 0;
        for i = 2:length
            dist(i) = abs(input_vec(i) - input_vec(1));
            sum_dists = sum_dists + dist(i);
        end
        
        for i = 2:length
           wgts_result(i) = dist(i) / (2 * sum_dists);
        end
    end
    
    if(strcmp(str, 'inv_dist_wgt') == 1)
        wgts_result(1) = 1 / 3;
        sum_wgts = 0;
        for i = 2:length
            dist = abs(input_vec(i) - input_vec(1));
            wgts_result(i) = 1 / dist;
            sum_wgts = sum_wgts + wgts_result(i);
        end
        
        for i = 2:length
           wgts_result(i) = wgts_result(i) / sum_wgts;
           wgts_result(i) = wgts_result(i) * (0.5 - 1 / 3 / 2);
        end
    end
    
    if(strcmp(str, 'triangle') == 1)
        peak = 2 / 3;
        width = 3 / (2 * length - 1);
        wgts_result(1) = peak * width;
        for i = 2:length
            wgts_result(i) = triangle_distributed_function(i, length - 1, peak) * width;
        end
    end
    
    if(strcmp(str, 'Gauss') == 1)
        peak = 2 / 3;
        width = 4 / (2 * length - 1);
        wgts_result(1) = peak * width;
        for i = 2:length
            wgts_result(i) = gauss_distributed_function(i, length - 1, peak) * width;
        end
    end

end

