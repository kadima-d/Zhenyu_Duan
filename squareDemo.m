clc;clear;close all;
t=0.001:0.001:100;
x=square(0.1*t)+0.05*sin(2*pi*t)+1.5;
figure(100);
plot(t,x);
fs=1000;
b=100000;

%% vmd_oyjs
% tic
% imf=VMD_display(x,1000,5);
% toc
% figure(1000)
% plot(t,x-imf(4,:))
lvbo = filter(lvboqi19,x);
figure(1)
plot(t,lvbo);
hold on;
% plot(t,mm1);
% hold on;
% a1=(1/fs:1/fs:(b-1500)/fs);%生成x轴
% result=lvbo(1501:b);
% mm1_result=mm1(1:b-1500);
% figure(2)
% plot(a1,result-mm1_result);