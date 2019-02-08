%%% estimate parameters for domain growth

filename = 'tissue length spreadsheet.xls';
sheet = 'somite stage';
xlRange = 'D1:D3'; % does not work, can actually write anything here will read gull table anyways

subsetA = xlsread(filename,sheet,xlRange);

domain_length = subsetA(:,4)'/10;

domain_length = domain_length(~isnan(domain_length));

L_0 = domain_length(1); % set initial domain length

time = zeros (1,length(domain_length));
for i = 0: length(domain_length)-1
    time(i+1) = i*(24/length(domain_length));
end

%time = time';

figure
scatter(time, domain_length, 'filled')


% x = [ L_inf, a]

%fun = @(x,xdata)x(1)*exp(x(2)*(xdata))./((x(1)/L_0)*ones(1,length(domain_length))...
 %       + exp(x(2)*(xdata))-ones(1,length(domain_length)));

%x0 = [980,0.05];

% with time delay

fun = @(x,xdata)(x(1)*exp(x(2)*(xdata-x(3)))./((x(1)/L_0)*ones(1,length(domain_length))...
  + exp(x(2)*(xdata-x(3)))-ones(1,length(domain_length))) + x(4));%
 %  including unkown L_inf
 
 %%% from their work
%  fun = @(x,xdata)(x(1)*exp(x(2)*(xdata-x(3))*x(1))./((x(1)/L_0)*ones(1,length(domain_length))...
%    + exp(x(2)*(xdata-x(3))*x(1))-ones(1,length(domain_length))) + x(4));%
  
 
 
% fun = @(x,xdata)(L_inf*exp(x(1)*(xdata-x(2)))./((L_inf/L_0)*ones(1,length(domain_length))...
  % + exp(x(1)*(xdata-x(2)))-ones(1,length(domain_length))) + x(3)); % L_inf known


x0 = [90,0.05,-0,2]; % L_inf unknown
%x0 = [0.05,-0,2]; % L_inf known


% lb = [900,0.02];
% ub = [2000,2];
% options = optimoptions('FunctionTolerance');

parameters = lsqcurvefit(fun,x0,time,domain_length)%,lb,ub,options);
xrange = 0:0.01:30;
xrange = xrange';
hold on
plot (xrange,fun(parameters,xrange),'linewidth',4)
fun(parameters,0)
xlabel('Time','FontSize',14)
%xlabel('\alpha','fontweight','bold','FontSize',14)
set(gca,'linewidth',2)
ylabel('Domain length \mu m','FontSize',14)
%title(['MCT4 influence on population sizes, MCT1 = ', num2str(MCT11)],'FontSize',14)
title(['Parameters L_{infty} = ' num2str(round(parameters(1))) ', a = ' num2str(parameters(2))],'fontweight','bold','FontSize',14)

%set(gca,'FontWeight','bold')
set(gca,'FontSize',36)
 ax = gca;

%yticks([0.5 1.0])

L_0 = 30; % will have to make this consistent with actual initial length
a = 0.1653;%23;
L_inf = 110;%86.76;
t_s = 14.59;
constant = 24.44;%-1.95; 


domain_length_2 = ((L_inf*exp(a*(xrange-t_s)))./ (L_inf/L_0 + exp(a*(xrange-t_s)) - 1) )+constant;
   
hold on
  plot(xrange,domain_length_2)  

        



