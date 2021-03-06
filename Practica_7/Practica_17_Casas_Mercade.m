%% Practica_17_Casas_Mercade

%% Section A

close all
clear all
k1 = 1;  k2 = sqrt(2);  k3 = sqrt(3);  k4 = 4;

b11 = -(k1 + k2); b12 = k2;
b21 = k2; b22 = -(k2 + k3); b23 = k3;
b32 = k3; b33 = -(k3 +k4);

B = [0,0,0,1, 0,0;
    0, 0, 0, 0, 1, 0;
    0, 0, 0, 0 , 0, 1;
    b11, b12, 0,0,0,0;
    b21,b22,b23,0,0,0;
    0, b32, b33, 0,0,0];

z0=[0.281 ; 0.033; -1.33; 1.12; 0.35; -0.299];

dt=0.25; N=400;  j=0:N-1; z = @(t)(expm(B*t)*z0);
Z=[];


for jj=j
    zj=z(dt*jj);
    Z=[Z zj];
end
figure;
subplot(2,1,1)
plot(dt*j,Z(2,:))
title('Displacement in time of the second block')
xlabel('Time')
ylabel('Displacement')
hold on

k = -N/2:(N/2-1);
wk = 2*pi/(N*dt).*k; %spectrum of frequencies
fk=DFT(Z(2,:)');
subplot(2,1,2);
plot(wk,abs(fk));
title('Fourier coeficients as a function of their associated angular frequencies')
xlabel('Spectrum of frequencies')
ylabel('Fourier coeficients')

%In the plot we identify six characterstic peaks at six angular velocities, which corresponds to only three
%frecuencies that compose the total movment of the second block. 

%% Section B)
[val, ind] = sort(abs(fk), 'descend');
disp('The freaquency peaks obtained using DFT are')
disp(wk(ind(1:6))) % We should be carefull because this method will not give the
% maximum always. In this case we have checked visually that gives the
% correct answer.

disp('The frequency peaks obtained useing the comand eig are')
disp(imag(eig(B)'))

% We can confirm that both methods lead us to the same results.


