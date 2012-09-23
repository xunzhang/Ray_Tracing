%
%	sym_plot.m
%	NOTE: plot the vec 
%	
%	Input parameter:
%		x
%
%	Output parameter:
%
%	function sym_plot(x)
%

function sym_plot(x)
    plot(-x(:,2),  x(:,1));
    plot(-x(:,2), -x(:,1));
end
