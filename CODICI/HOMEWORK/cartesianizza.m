function z=cartesianizza(rho, theta);
% Function che esprime un munero complesso in forma 
% Cartesiana

phi=deg2rad(theta);
[x,y]=pol2cart(phi,rho);
z=x+j*y;
end

