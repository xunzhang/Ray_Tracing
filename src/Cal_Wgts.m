%
%  Cal_Wgts.m
%
%  Notice:
%  1. every ray has a unique wgt
%  2. the sum of the wgts is 1
%
%  Parameter list:
%    parameter_package - in
%
%  Return value:
%    weights_result
%
%  function weights_result = Cal_Wgts(parameter_package)
%
function weights_result = Cal_Wgts(parameter_package)	
  %
  %	produce the sequence
  %
  seq(1) = 0;
  for i = 1:parameter_package.num_lgts
    seq(i+1) = i;
  end
  seq = seq'
  %
  %	cal the wgts and return the weights_result
  %
  % weights_result = Gen_Wgts(seq, parameter_package.str_in);
  weights_result = Gen_Wgts(seq, 'inv_dist_wgt');
end

