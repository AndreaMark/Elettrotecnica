function dvdt = RC_lab2(t, v)
% Funzione da dare in pasto ad ODE45

% CASO 2: f2 = 720Hz, C1=0.33F, omega2 = 2*pi*f2, tao1 = R*C1
% CARICA INCOMPLETA, FREQUENZA

global Emax tao1 f2 omega2

E = sign(Emax*sin(omega2*t));
dvdt = -v/(tao1) + E/(tao1);
end

