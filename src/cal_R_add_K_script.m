clc;
clear all;
clc;

X0 = [60, -3.9];
Xmax = [60*1.1,1];
Xmin = [60*0.9,-1];

options=optimset(@fmincon);
%options.Display         = 'iter-detailed';
options.Display         = 'final';
options.MaxFunEvals     = 50;
options.MaxIter         = 10;    
options.DiffMaxChange   = 0.5;
options.DiffMinChange   = 0.2; 

[x,fval,exitflag,output,lambda,grad] = fmincon(@final_func,X0,[],[],[],[],Xmin,Xmax,[],options)

%outres=fopen('res','w');
%fprintf(outres,'%6.14f\n ',xrec);
%fclose(outres);
