clear all
close all
clc

R=10; X1=2, X2=5; X3=6;
ZR=R; Z1=-j*X1;; Z2=j*X2; Z3=-j*X3;

Zeq= Z1 + (Z3*(ZR+Z2))/(Z3+ZR+Z2)