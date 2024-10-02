close all
clear all
clc


global Emax omega phi R C
Emax = 5; omega = 3000; phi = pi/2; R = 1e3; C = 1e-6; V_C_0 = 2;

[t,v_C] = ode45(@RC_sin, [0 10*tao1], V_C_0);


E = Emax*sin(2*pi*omega*t + phi);
I = (E-v_C)/R;
figure
plot(t,v_C,'.-')
hold on 
plot(t,10*I,'.-')
grid on 
xlabel( 'time [s]')
title('Scarica condensatore')
legend('Voltage', 'Current')