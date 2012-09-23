%
%	cal_rmse.m 
%	NOTE: the rmse here base on the formula rmse = sqrt(w1 * (value1^2) + w2 * value2^2 + ... + wk * valuek^2)
%
%	Input parameter:
%		weights 
%		wavefront
%	
%	Output parameter:
%		rmse_result
%	
%	function rmse_result = cal_rmse(weights, wavefront)
%

function rmse_result = cal_rmse(weights, wavefront)

	%
	%	read the Num_Lgts from 'input.txt'
	%
	%fid = fopen('input', 'r');
	Num_Lgts = 12;%fscanf(fid, '%d', 1);
	
	%
	%	cal the rmse and return rmse_result
	%
	sum = 0;
	weights
    ((-wavefront(:, 2)) .^2)
    values = weights' .* ((-wavefront(:, 2)) .^2);
	
	for i = 2:Num_Lgts
		sum = sum + values(i);
	end
	sum = sum * 2;

	rmse_result = sqrt(sum);
	
end
