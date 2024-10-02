clear all
close all
clc

global w f V0 tao E
w = 2*pi*3000; f=pi/2; V0=2; R=1e3; C=1e-6; tao=R*C; E = 5;

t=linspace(0, 10*tao, 100);

v = (E/tao)*(t.*[sin(w.*t+f)-w.*t.*cos(w.*t+f)])./((w^2).*(t.^2)+1) + V0.*exp(-t./tao);

e = E*sin(w*t+f);

i = (e-v)/R;

plot(t,v, 'b', t,10*i,'r')