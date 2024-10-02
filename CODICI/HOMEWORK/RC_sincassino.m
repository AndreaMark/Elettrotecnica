function [dxdt] = RC_sincassino(t,x)
% funzione da dare in pasto ad ODE 45

 global w Emax C phi Req

E = Emax*sin(w*t + phi);
dxdt = -x/(Req*C) + E/(Req*C);
end