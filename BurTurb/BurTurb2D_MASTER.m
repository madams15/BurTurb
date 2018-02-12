%% Solves 2D Burgers Equation using Pseudo-spectral Method
% ~Marissa B. Adams~
%----------------------------------------------------------------------------
tic;
clc;
clear;
close all;

%% User-defined Inputs
n_x        = 100;           %ROWS
dx         = 2*pi/n_x;
n_y        = 100;           %COLUMNS
dy         = 2*pi/n_y;
t_steps    = 0.51e3;
dt         = 1e-3;
viscosity  = 0;                    %CHANGE IFF NEEDED

%% Calculations
% Initialize
% NOTES :: Starts from sinusoidal u,then take derivatives, introduce seed ...
% ... then introduce smag tau, use derivatives again to calculate the     ...
% ... derivative of tau, then calculate the RHS, then finite different to update

ux = zeros(n_x,1);
Ux = zeros(n_x,t_steps);
uy = zeros(n_y,1);
Uy = zeros(n_y,t_steps);

t = (0:dt:(t_steps-1)*dt)';
x = (0:dx:(n_x-1)*dx)';
y = (0:dy:(n_y-1)*dy)';

%%
for i=1:n_x
    for j=1:n_y
        ux(i,j,1)=1-cos(x(i));%sin(x(i));
        if(j<n_y/2+1)
            uy(i,j,1)=1-cos(2*(y(j)));%sin(y(j));
        else
            uy(i,j,1)=-(1-cos(2*y(j)));
        end
        Z(i,j,1) = sqrt(ux(i,j,1)^2 + uy(i,j,1)^2);
    end
end

%%
% Time-marching along x
seed_diff_x = 1e-6;                %CHANGE IFF NEEDED
seed_diff_y = 1e-6;
Ux = BurTurb2D_TimeMarch(ux,uy,viscosity,t_steps,dx,dy,dt,n_x,n_y,seed_diff_x);
ux = ux';
uy = uy';
Uy = BurTurb2D_TimeMarch(uy,ux,viscosity,t_steps,dy,dx,dt,n_y,n_x,seed_diff_y);

%% Plot figures
Z = zeros(n_x,n_y,t_steps);
for k = 1:t_steps
    for i=1:n_x
        for j=1:n_y
            Z(i,j,k) = sqrt(Ux(i,j,k)^2 + (Uy(j,i,k)')^2);
        end
    end
end


BurTurb2D_Figures(Z,Ux,Uy,ux,uy,x,y,t,dt,t_steps,n_x,n_y,viscosity);


%%
clearvars -except t x y Ux Uy Z viscosity n_x n_y dt dx dy t_steps
toc;
