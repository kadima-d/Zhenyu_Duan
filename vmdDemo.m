t=0.001:0.001:100;
x=square(0.1*t)+0.5*sin(2*pi*t)+1.5;
figure(1);
plot(t,x);
fs=1000;
b=100000;

%% vmd
imf = vmd(x);
[p,q] = ndgrid(t,1:size(imf,2));
plot3(p,q,imf)
grid on
xlabel('Time Values')
ylabel('Mode Number')
zlabel('Mode Amplitude')