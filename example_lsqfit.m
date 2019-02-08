xdata = ...
 [0.9 1.5 13.8 19.8 24.1 28.2 35.2 60.3 74.6 81.3];
ydata = ...
 [455.2 428.6 124.1 67.3 43.2 28.1 13.1 -0.4 -1.3 -1.5];
%Create a simple exponential decay model.

fun = @(x,xdata)x(1)*exp(x(2)*xdata);
%Fit the model using the starting point x0 = [100,-1].

x0 = [100,-1];
x = lsqcurvefit(fun,x0,xdata,ydata)