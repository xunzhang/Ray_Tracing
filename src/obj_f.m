function f = obj_f(x)

global a b xrec varrec;

for i=1:5
    xtrs(i) = a(i)*x(i)+b(i); 
end

xrec=[xrec;xtrs];


%********self_programming**********


f = var1 + var2;

var    = [f, var1 , var2];
varrec = [varrec;var];

