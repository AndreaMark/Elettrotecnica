function dxdt = RC(t, x)
% Funzione da dare in pasto al comando ODE45

global E R C

dxdt = -x/(R*C);
end


