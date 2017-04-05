var y pi i;

varexo e_y e_pi e_i;

parameters a1 a2 a3 b1 b2 b3 c1 c2 c3;

a1 = .2;
a2 = .8;
a3 = .05;

b1 = .3;
b2 = .7;
b3 = .1;

c1 = 0.9;
c2 = 1.5;
c3 = 0.5;

model;
  y  = a1*y(-1) + a2*y(1) - a3*(i-pi(1)) + e_y ;
  pi = b1*pi(-1) + b2*pi(1) + b3*y + e_pi ;
  i  = c1*i(-1) + c2*pi(1) + c3*y + e_i ;
end;

steady;

check;

shocks;
var e_y  = 0.002;
var e_pi = 0.004;
var e_i  = 0.001;
end;

dse = dseries('endogenousvariables.mat');
dsx = dseries('exogenousvariables.mat');
dsx = [dsx.e_y, dsx.e_pi, dsx.e_i];

dsx

// Check that the returned paths for the endogenous variables are correct.
[ts, oo_] = extended_path(zeros(3, 1), 99, dsx.data(2:100,:), options_, M_, oo_);

[ts.y.data, dse.y.data]
[ts.pi.data, dse.pi.data]
[ts.i.data, dse.i.data]