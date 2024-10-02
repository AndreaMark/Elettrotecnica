function dvdt = RC_lab3(t, v)
% Funzione da dare in pasto ad ODE45

% CASO 3: f1 = 240Hz, C2=2.2F, omega1 = 2*pi*f1, tao2 = R*C2
% CARICA INCOMPLETA, CAPACITà

global Emax tao2 f1 omega1

E = sign(Emax*sin(omega1*t));
dvdt = -v/(tao2) + E/(tao2);
end
