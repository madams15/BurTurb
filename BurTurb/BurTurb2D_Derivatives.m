%From notes
function [du_dx,d2u_dx2,du_dx2,du_dy,d2u_dy2] = BurTurb2D_Derivatives(u,dx,v,dy)

[n_x,n_y]    = size(u);

pre_x        = 2*pi/n_x/dx;
pre_y        = 2*pi/n_y/dy;

k_x          = [0 1:(n_x/2-1) 0 -(n_x/2-1):1:-1]';
k_y          = [0 1:(n_y/2-1) 0 -(n_y/2-1):1:-1]';

u_k          = fft2(u);
du_dx        = (pre_x)*real(ifft2(sqrt(-1)*k_x.*u_k));
d2u_dx2      = (pre_x^2)*real(ifft2(-k_x.*k_x.*u_k));

u_k_buffer   = [u_k(1:n_x/2+1,:)' zeros(n_y,n_x) u_k(n_x/2+2:n_x,:)']';
u_buffer     = real(ifft2(u_k_buffer));
u2_buffer    = u_buffer.*u_buffer;
u_k2_buffer  = fft2(u2_buffer);
u_k2         = [u_k2_buffer(1:n_x/2+1,:)' u_k2_buffer(n_x+n_x/2+2:n_x+n_x,:)']';
du_dx2       = (2)*(pre_x)*real(ifft2(sqrt(-1)*k_x.*u_k2));

v_k          = fft2(v);
du_dy        = (pre_y)*real(ifft2(sqrt(-1)*k_y.*v_k));
d2u_dy2      = (pre_y^2)*real(ifft2(-k_y.*k_y.*v_k));

end
