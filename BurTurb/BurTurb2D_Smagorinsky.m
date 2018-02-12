function tau = BurTurb2D_Smagorinsky(u,du_dx,dx)

[n_x,n_y]      = size(u);
C_s_2          = 0.16^2; %from notes
mod_du_dx_smag = BurTurb2D_Dealiasing(abs(du_dx),n_x,n_y,1);
du_dx_smag     = BurTurb2D_Dealiasing(du_dx,n_x,n_y,1);
prod_du_dx     = BurTurb2D_Dealiasing(mod_du_dx_smag.*du_dx_smag,n_x,n_y,2);
tau            = -2*C_s_2*((dx)^2)*prod_du_dx;

end


