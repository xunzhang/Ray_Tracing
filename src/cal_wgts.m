%
%	cal_wgts.m
%	NOTE1: every ray has a unique wgt
%	NOTE2: the sum of the wgts is 1.
%
%	Input parameter:
%
%	Output parameter:
%		weights_result
%
%	 function weights_result = cal_wgts()
%

function weights_result = cal_wgts()
	
	%
	%	read the Num_Lgts and str_in from 'input.txt'
	%
	%fid = fopen('input2', 'r');
	Num_Lgts = 12;%fscanf(fid, '%d', 1);
    
    %for i = 1:5
    %    fscanf(fid, '%f', 1);
    %end
    
    str_in = 'inv_dist_wgt';%fscanf(fid, '%s', 1);
    
	%
	%	produce the sequence
	%
	seq(1) = 0;
	for i = 1:Num_Lgts
		seq(i+1) = i;
    end
    seq = seq'
  	str_in	
	%
	%	cal the wgts and return the weights_result
	%
	weights_result = gen_wgts(seq, str_in);
end

