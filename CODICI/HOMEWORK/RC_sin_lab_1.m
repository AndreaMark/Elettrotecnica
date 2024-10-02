function [dxdt] = RC_sin_lab_1(t,x)
% da dare in pasto alla funzione ODE45 come @RC_sin

global Emax omega1 tao1

E = Emax*sin(omega1*t);
dxdt = -x/tao1 + E/tao1;
end

