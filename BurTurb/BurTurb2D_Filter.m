%Choose the box or gaussian, 1 or 2 respectively
%Formulas from CFD wiki: https://www.cfd-online.com/Wiki/LES_filters
function u_filtered = BurTurb2D_Filter(u,option)

n_x        = length(u);
delta      = (2*pi)/n_x;
u_k        = fft(u);
k          = [0 1:(n_x/2-1) n_x/2 -(n_x/2-1):1:-1]';

if option == 1      % Box Filter
    F               = sin(0.5*k*delta)./(0.5*k*delta);
    F(1)            = 1;
    u_proxy         = F.*u_k;
    u_proxy(n_x/2+1)= 0;
    
elseif option == 2  % Gaussian Filter
    F               = exp(-k.^2.*delta^2/24);
    F(1)            = 1;
    u_proxy         = F.*u_k;
    u_proxy(n_x/2+1)= 0;
end
u_filtered = real(ifft(u_proxy));

end