%Copied from stack exchange
function seed = BurTurb2D_Seed(alpha,n_x,n_y)

lol                 = sqrt(n_x)*randn(n_x,n_y);
freq                = [ 1 1:n_x/2 (n_x/2-1):-1:1 ];
lol_k               = fft2(lol);
lol_k(1,:)            = 0; 
lol_k(n_x/2+1,:)      = 0;  
lol_mod             = lol_k .* (freq .^ (- alpha/2 ) );
seed                = real( ifft2(lol_mod) );

end
