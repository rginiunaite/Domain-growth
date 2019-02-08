L_0 = 30; % will have to make this consistent with actual initial length
a = 0.23;%23;
L_inf = 86.76;
t_s = 15.9;
constant = 29.12;%-1.95; 

t= 0;


%domain_length =  L_0 * ((L_inf * exp(a*(t-t_s)*L_inf))/(L_inf-1+exp(a*(t-t_s)*L_inf))+ constant);


%domain_len_der = L_0 * ((L_inf*L_inf*a * exp(a*(t-t_s)*L_inf))/(L_inf-1+exp(a*(t-t_s)*L_inf)) ...
       %      - (L_inf * L_inf * a * exp(2*a*(t-t_s)*L_inf))/((L_inf-1+exp(a*(t-t_s)*L_inf))*(L_inf-1+exp(a*(t-t_s)*L_inf))));
        
    t = 0:0.01:30; 
    
       
   
figure
  plot(t,fun)  

        
domain_length_2 = ((L_inf*exp(a*(t-t_s)))/ (L_inf/L_0 + exp(a*(t-t_s)) - 1) )+constant

domain_len_der_2 = ((a*L_inf*exp(a*t))/ (L_inf/L_0 + exp(a*t) - 1) - (a*L_inf*exp(2*a*t))/(L_inf/L_0 + exp(a*t) - 1) ); 