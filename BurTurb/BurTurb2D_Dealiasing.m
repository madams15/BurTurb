function out = BurTurb2D_Dealiasing(term,points1,points2,option)

if option == 1
    num1      = points1/2;
    out_k     = fft2(term);
    out_k_mod = [out_k(1:points1/2+1,:)' zeros(points2,num1) out_k(points1/2+2:points1,:)']';
    out       = real(ifft2(out_k_mod));
elseif option == 2
    num1                     = points1/2;
    out_k                    = fft2(term);
    out_k_mod                = [out_k(1:points1/2+1,:)' out_k(num1+points1/2+2:num1+points1,:)']';
    out_k_mod(points1/2+1,:) = 0;
    out                      = (3/2)*real(ifft2(out_k_mod));
    
end
