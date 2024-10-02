function dxdt = RC(t, x)
% Funsione da dare in pasto al comando ODE45

global E R C

dxdt = -x/(R*C) + E/(R*C);
end