function [phi_hat, sig2_hat, R2] = OLS_ARp(Y, p)

y0 = Y(p+1:end); % T-p by k
T = rows(y0);

y_lag = ones(T, 1);

for j = 1:p
  y_lag = [y_lag, Y(p+1-j:end-j)]; 
end

y_lag2 = y_lag'*y_lag;
phi_hat = y_lag2\(y_lag'*y0); % p*k by k
 
% Omega_hat 
u_hat = y0 - y_lag*phi_hat; % T-p by k 
sig2_hat = u_hat'*u_hat/(T-p);  % k by k

mY = meanc(y0); 
TSS = y0'*y0 - T*mY^2; % TSS
RSS = u_hat'*u_hat;  % RSS
R2 = 1 - RSS/TSS;  % R2
end