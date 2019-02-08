filename = 'tissue length spreadsheet.xls';
sheet = 'somite stage';
xlRange = 'D1:D3'; % does not work, can actually write anything here will read gull table anyways

subsetA = xlsread(filename,sheet,xlRange);

domain_length = subsetA(:,4)';

domain_length = domain_length(~isnan(domain_length));

L_0 = domain_length(1); % set initial domain length

time = zeros (1,length(domain_length));
for i = 0: length(domain_length)-1
    time(i+1) = i*(30/20);
end

%time = time';

figure
scatter(time, domain_length, 'filled')

% x = [ L_inf, a, ts]
%fun = @(x,xdata)x(1)*exp(x(2)*xdata)./((x(1)/300)*ones(1,length(domain_length))...
 %   + exp(x(2)*xdata)-ones(1,length(domain_length)));

fun = @(x,xdata)L_0 * ((x(1)*exp(x(1)*x(2)*(xdata - x(3)*ones(1,length(domain_length)))))  );...
     %/((x(1)-1)*ones(1,length(domain_length)) +exp((x(1)*x(2)*(xdata - x(3)*ones(1,length(domain_length)))))) ...
%+ ones (1,length(domain_length)) + (x(1)*exp(x(1)*x(2)*(- x(3)*ones(1,length(domain_length)))))...
    %/((x(1)-1)*ones(1,length(domain_length)) +exp((x(1)*x(2)*(- x(3)*ones(1,length(domain_length)))))));





x0 = [980,0.05,-16];

% lb = [900,0.02];
% ub = [2000,2];
% options = optimoptions('FunctionTolerance');

parameters = lsqcurvefit(fun,x0,time,domain_length);%,lb,ub,options);
xrange = 0:19;
xrange = xrange';
hold on
plot (xrange,fun(parameters,xrange))

