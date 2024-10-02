function dxdt = RC(t, x)
% non ho ancora capito casa faccia questa funzione

global E R C

dxdt = -x/(R*C) + E/(R*C);
end

