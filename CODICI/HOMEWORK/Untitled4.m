k=6
x=linspace (0,pi,k)
f1=cos(x);
f2=sin(x);
fprintf('n\t x(n)\t cos(x(n))\t sin(x(n))\n');...
fprintf('%d\t %3.2f\t %+6.5f\t % 6.5f\n',[(1:k);x;f1;f2])