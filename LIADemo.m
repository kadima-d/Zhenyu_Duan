%%  清内�?关闭窗口 准备工作
clear 
close all
clc
 
%%  signal
% 三要�?
A=1;                %amplify
f=1;               %Hz
w=2*pi*f;           %rad/s
p=0;                %rad
%采样
T=3600;                %s        %观测时间
fs=10000;            %Hz       %采样频率
d=1/fs;             %s        %采样间隔
 
 
t=0:d:T;       %离散时间t
s1=A*sin(w*t+p);    %正弦信号
 
% figure(1)
% plot(t,s1);
% xlabel('时间/s');
% ylabel('幅度');
s2=A*cos(w*t+p);
subplot(3,1,1);
plot(t,s2);
xlabel('时间/s');
ylabel('幅度');
title("参�?信号")
%% 加入白噪声的信号
s3=A*sin(w*t+3);
signal = 4*awgn(s3,5,'measured'); %加入白噪声程�?
subplot(3,1,2);
plot(t,signal);
xlabel('时间/s');
ylabel('幅度');
title("带白噪声的源信号")
%% 锁相放大功能
out1=(2*filter(Filter_IIR,(signal.*s1))).*(2*filter(Filter_IIR,(signal.*s1)));%滤波后的�?��输出
out2=(2*filter(Filter_IIR,(signal.*s2))).*(2*filter(Filter_IIR,(signal.*s2)));%滤波后的二路输出

% figure(10)
% plot(t,signal.*s1);
% figure(11)
% plot(t,filter(Filter_IIR,(signal.*s1)));


result=sqrt((out1)+(out2));
subplot(3,1,3);
plot(t,result)
xlabel('时间/s');
ylabel('幅度');
title("锁相结果")
% 
% Y2=filter(Filter_ButterWorth_IIR,Y);
% figure(4)
% plot(t,Y2);
% xlabel('时间/s');
% ylabel('幅度');

% 
% s3=s1.*s2;
% figure(3)
% plot(t,s3);
% xlabel('时间/s');
% ylabel('幅度');