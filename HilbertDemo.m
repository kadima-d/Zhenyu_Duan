
% 利用Hilbert变换求包络线
fs=3000;
t=0:1/fs:200; 
%x6=sin(2*pi*2*t)+sin(2*pi*4*t);
%x6=sin(2*pi*2*t).*sin(2*pi*20*t)+1;
x6=sin(2*pi*2*t);
x66 = hilbert(x6);
xx = abs(x66);
figure(1)
hold on
plot(t,x6);
plot(t,xx,'r')
xlim([0 5])
a=xx(6);
figure(2)
plot(t,imag(x66));