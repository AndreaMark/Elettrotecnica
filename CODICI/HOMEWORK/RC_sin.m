function [dxdt] = RC_sin(t,x)
% da dare in pasto alla funzione ODE45 come @RC_sin

global Emax omega phi R C

E = Emax*sin(2*pi*omega*t + phi);
dxdt = -x/(R*C) + E/(R*C);
end

