%
%	dist.m
%	NOTE: cal the Euclidean distance between two points
%	
%	Input parameter:	
%		p1
%		p2
%	
%	Output parameter:
%		y
%
%	function y = dist(p1, p2)
%

function y = dist(p1, p2)
	y = sqrt((p1(1) - p2(1)) ^2 + (p1(2) - p2(2)) ^2);
end
