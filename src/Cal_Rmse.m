%
%  Cal_Rmse.m 
%  Notice: 
%    the rmse here base on the formula rmse = sqrt(w1 * (value1^2) + w2 * value2^2 + ... + wk * valuek^2)
%
%  Input parameter:
%    weights 
%    wavefront
%	
%  Output parameter:
%    rmse_result
%	
%  function rmse_result = Cal_Rmse(weights, wavefront)
%
function rmse_result = Cal_Rmse(parameter_package, weights, wavefront)
  %
  %	cal the rmse and return rmse_result
  %
  sum = 0;
  %((-wavefront(:, 2)) .^2)
  values = weights' .* ((-wavefront(:, 2)) .^2);	
  for i = 2:parameter_package.num_lgts
    sum = sum + values(i);
  end
  sum = sum * 2;
  rmse_result = sqrt(sum);
end
