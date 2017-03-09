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

model(bytecode);
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

% TO BE FIXED IN DYNARE Following statement should not be necessary.
stoch_simul(periods=10,irf=0,noprint,order=1);

subsample = 1Y:100Y;

SimulatedData = dseries('truedata.mat');

fplan = init_plan(subsample);
fplan = flip_plan(fplan, 'y', 'e_y', 'surprise', subsample, transpose(SimulatedData.y(subsample).data));
fplan = flip_plan(fplan, 'pi', 'e_pi', 'surprise', subsample, transpose(SimulatedData.pi(subsample).data));
fplan = flip_plan(fplan, 'i', 'e_i', 'surprise', subsample, transpose(SimulatedData.i(subsample).data));

options_.simul.maxit = 20;

f = det_cond_forecast(fplan);

figure(1)
plot(f.y-SimulatedData.y) % Should be zero
title('y')

figure(2)
plot(f.pi-SimulatedData.pi) % Should be zero
title('pi')

figure(3)
plot(f.i-SimulatedData.i) % Should be zero
title('i')

figure(4)
plot(f.e_y-SimulatedData.e_y) % Not zero because of the misspecification related to the ZLB
title('e_y')

figure(5)
plot(f.e_pi-SimulatedData.e_pi) % Not zero because of the misspecification related to the ZLB
title('e_pi')

figure(6)
plot(f.e_i-SimulatedData.e_i) % Not zero because of the misspecification related to the ZLB
title('e_i')
hold on
plot(SimulatedData.i(subsample),'or')
hold off




