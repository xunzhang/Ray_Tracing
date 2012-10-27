%
%  Dist.m
%
%  Notice: 
%    cal the Euclidean distance between two points
%
%  Parameter list:
%    p1, p2
%
%  Return value:
%    y
%
%  function y = Dist(p1, p2)
%
function y = Dist(p1, p2)
	y = sqrt((p1(1) - p2(1)) ^2 + (p1(2) - p2(2)) ^2);
end
