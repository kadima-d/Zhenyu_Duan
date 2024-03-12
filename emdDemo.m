clear;clc;close all;

fs = 100000;
ts = 1/fs;
t=0:ts:0.3;
z = sin(2*pi*10*t) + sin(2*pi*100*t)+sin(2*pi*t)+sin(2*pi*1000*t)+sin(2*pi*10000*t);
imf=emd(z);
figure
plot(z);
title('原始信号');
emd_visu(z,t,imf)  % EMD专用画图函数
figure
plot(imf(1,:));
hold on;
plot(imf(2,:));
hold on;
plot(imf(3,:));
title('emd');
legend('1','2','3');%!!!!第一个图
figure
plot(imf(4,:));
hold on;
plot(imf(5,:));
hold on;
plot(imf(6,:));
title('emd');
legend('4','5','6');%!!!!第一个图
%% vmd
imf2=vmd(z,'NumIMF',6,'LMUpdateRate',0.01);
figure
plot(imf2(:,1));
figure
plot(imf2(:,2));
figure
plot(imf2(:,3));
figure
plot(imf2(:,4));
figure
plot(imf2(:,5));
figure
plot(imf2(:,6));
title('vmd');


