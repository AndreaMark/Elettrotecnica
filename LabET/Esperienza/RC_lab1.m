function dvdt = RC_lab1(t, v)
% Funzione da dare in pasto ad ODE45

% CASO 1: f1 = 240Hz, C1=0.33microF, omega1 = 2*pi*f1, tao1 = R*C1
% CARICA COMPLETA

global Emax tao1 f1 omega1

E = sign(Emax*sin(omega1*t));
dvdt = -v/(tao1) + E/(tao1);
end

