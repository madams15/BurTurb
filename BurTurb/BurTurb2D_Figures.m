function BurTurb2D_Figures(Z,Ux,Uy,ux,uy,x,y,t,dt,t_steps,n_x,n_y, viscosity)
%%
[X,Y] = meshgrid(x(1:n_x),y(1:n_y));

CRed=zeros(100,100,3);
CRed(:,:,1)=1;

CGreen=zeros(100,100,3);
CGreen(:,:,2)=1;

CBlue=zeros(100,100,3);
CBlue(:,:,3)=1;

figure(1)
subplot(1,3,1)
surf(x,y,ux,CBlue,'FaceAlpha',0.5)%,'EdgeColor','none');
subplot(1,3,2)
surf(x,y,uy,CBlue,'FaceAlpha',0.5)%,'EdgeColor','none');
subplot(1,3,3)
surf(x,y,Z(:,:,1),CBlue,'FaceAlpha',0.5)%,'EdgeColor','none');
print('IC','-dpng');

figure(2)
surf(x,y,Ux(:,:,1),CBlue,'FaceAlpha',0.5)%,'EdgeColor','none')
hold on;
surf(x,y,Ux(:,:,end/2),CGreen,'FaceAlpha',0.5)%,'EdgeColor','none')
hold on;
surf(x,y,Ux(:,:,end),CRed,'FaceAlpha',0.5)%,'EdgeColor','none')
hold off;
print('UxTimeEvol','-dpng');

figure(3)
surf(x,y,Uy(:,:,1)',CBlue,'FaceAlpha',0.5)%,'EdgeColor','none')
hold on;
surf(x,y,Uy(:,:,end/2)',CGreen,'FaceAlpha',0.5)%,'EdgeColor','none')
hold on;
surf(x,y,Uy(:,:,end)',CRed,'FaceAlpha',0.5)%,'EdgeColor','none')
hold off;
print('UyTimeEvol','-dpng');

figure(5)
subplot(1,3,1)
%figure(5)
surf(X,Y,Z(1:n_x,1:n_y,1),CBlue,'FaceAlpha',0.5)%,'EdgeColor','none');
xlabel('x');
ylabel('y');
title(['t = ', num2str(t(1))]);

subplot(1,3,2)
%figure(6)
surf(X,Y,Z(1:n_x,1:n_y,t_steps/2),CGreen,'FaceAlpha',0.5)%,'EdgeColor','none');
xlabel('x');
ylabel('y');
title(['t = ', num2str(t(end)/2)]);

subplot(1,3,3)
%figure(7)
surf(X,Y,Z(1:n_x,1:n_y,t_steps-1),CRed,'FaceAlpha',0.5)%,'EdgeColor','none');
xlabel('x');
ylabel('y');
title(['t = ', num2str(t(end))]);
print('SuperPosVelEvolution','-dpng');

end
