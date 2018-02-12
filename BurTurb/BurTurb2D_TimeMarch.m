function U = BurTurb2D_TimeMarch(u,v,viscosity,t_steps,dx,dy,dt,n_x,n_y,seed_diff_x)
 for i = 1:t_steps
    [du_dx,d2u_dx2,du_dx2,du_dy,d2u_dy2] = BurTurb2D_Derivatives(u,dx,v,dy);
    seed_x                               = BurTurb2D_Seed(0.75,n_x,n_y)';
    seed_filtered_x                      = BurTurb2D_Filter(seed_x,2);  
    tau_x                                = BurTurb2D_Smagorinsky(u,du_dx,dx);
    dtau_xdx                             = BurTurb2D_Derivatives(tau_x,dx,tau_x,dy);
    
    RHS_x = viscosity*d2u_dx2 + viscosity*d2u_dy2 - 0.5*du_dx2 - v.*du_dy + ...
        sqrt(2*seed_diff_x/dt)*seed_filtered_x - 0.5*dtau_xdx;
    % FD for time dervative (velocity verlet-ish)
    if i == 1
        u_mod = u + dt*RHS_x;                              
    else
        u_mod = u + dt*(1.5*RHS_x - 0.5*RHS_xp);             
    end
    u_mod_k          = fft(u_mod);
    u_mod_k(n_x/2+1) = 0;
    u_mod            = real(ifft(u_mod_k));
    u                = u_mod;
    U(:,:,i)         = u_mod;
    RHS_xp           = RHS_x;
     
    fprintf('%f\n',i*dt);
    
 end
