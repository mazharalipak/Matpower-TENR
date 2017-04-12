function [ dx, dl,dz,dMM,J] = tnr_step( x, l, z, tnr)
%tnr_step Summary of this function goes here
%   Detailed explanation goes here
    [nx, nz] = deal(length(x), length(z));
    
    F = tnr.F(x, l, tnr);
    [J,JJ] = tnr.J(x, l, tnr);

    [G, u, v] = tnr.G(J, z);
    
    dGdz = tnr.dGdz(J, z);
    
    dGdxl = tnr.dJdxl(x, l, u, v, tnr);        
        
        fullJ_half=[dGdxl(:,1:end-1) dGdz zeros(size(J,1)+1,1)];
        
        fullJ=[JJ; fullJ_half];
        
      
        dMM=[F;G];
        
    dv = - fullJ \ [F; G];
    
    dx = dv(1:nx);
    dl = dv(nx+1);
    dz = dv(nx+2:nx + 1 + nz);
end

