clc
clear all
% Kp = 1e-7;
% Ki = 3e-5;

%Kp = 1e-9
Vin = 34.7;
Vout = 48;
Iin = 7.8;
Rp = Vin / Iin;
d = Vout / (Vin + Vout);
Vc = Vin / (1-d);
Iout = Vin * Iin / Vout;
L2 = 2.5e-3;
L1 = L2;
C1 = 100e-6;
Cp = C1;

% b3 = 0.225;
% b2 = 7070756;
% b1 = 481238.65;
% b0 = 6.41e12;
% a2 = 378201600;
% a1 = 1.8e11;
% a0 = 9.576e14;
b3 = 1/Rp;
b2 = (d*d/(L2*C1))+((1-d)*(1-d)/(L1*C1))+(1/(Cp*L1));
b1 = (d*d/(L2*C1*Rp))+((1-d)*(1-d)/(L1*C1*Rp));
b0 = d*d/(L2*L1*Cp*C1);
A = Vc / L1;
B = Vc / L2;
C = (Iin+Iout)/C1;
D = 0;
a2 = A / Cp;
a1 = (1-d)*C/(L1*Cp);
a0 = (d*d*A/(L2*C1*Cp))+((1-d)*d*B/(L1*C1*Cp));

num = [a2,a1,a0];
den = [1,b3,b2,b1,b0];
sys = tf(num,den);
%while Kp < 1e-6
c = 1e-4;
%while c >= 1e-4
% Kp = 0.1725*c;
% Ki = 4.8e6*c;
% Kd = 1*c;
Kp = 0.05605*c;
Ki = 1.0853e6*c;
Kd = 1*c;
num_c = [Kd,Kp,Ki];
den_c = [1,0];
cntrl = tf(num_c,den_c);
GH = sys*cntrl;
cl = GH/(1+GH);
figure(1)
hold on
margin(GH)
figure(2)
hold on
step(cl)
bandwidth(cl)
%Kp = Kp*10;
c = c / 10;
%end
%margin(GH);
%nyquist(GH)