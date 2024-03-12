
clc;clear;close all;
tic
%对希尔伯特变换的改进fs=1000;%采样率
fs=1000;%采样率
T = 1/fs;%两个点之间的距离
data1=load('shiyanyiCor.csv');
b=length(data1);%求数组长度
a1=(1/fs:1/fs:b/fs);%生成x轴


data2=load('shiyanerCor.csv');
b=length(data2);%求数组长度
a2=(1/fs:1/fs:b/fs);%生成x轴


data3=load('shiyansanCor.csv');
b=length(data3);%求数组长度
a3=(1/fs:1/fs:b/fs);%生成x轴


%% 源信号
figure;
plot(a1,data1);
title('实验一');
xlabel('时间/s');
ylabel('幅度/V');
set(gca,'FontSize',20,'LineWidth',1);
axes('position',[0.25,0.65,0.2,0.2]);%局部放大图位置
plot(a1,data1);


figure;
plot(a2,data2);
title('实验一');
xlabel('时间/s');
ylabel('幅度/V');
set(gca,'FontSize',20,'LineWidth',1);
axes('position',[0.25,0.65,0.2,0.2]);%局部放大图位置
plot(a2,data2);


figure;
plot(a3,data3);
title('实验一');
xlabel('时间/s');
ylabel('幅度/V');
set(gca,'FontSize',20,'LineWidth',1);
axes('position',[0.25,0.65,0.2,0.2]);%局部放大图位置
plot(a3,data3);



%% 带通滤波
data1_H=filter(lvboqi24,data1);%无过冲，通带增益也近似为1，非常良好的保留了信息
figure;
plot(a1,data1_H);
hold on;
plot(a1,data1);
title('实验一带通滤波前后');
xlabel('时间/s');
ylabel('幅度/V');
legend('带通滤波后','带通滤波前');
set(gca,'FontSize',20,'LineWidth',1);
axes('position',[0.25,0.65,0.2,0.2]);%局部放大图位置
plot(a1,data1_H);
hold on;
plot(a1,data1);


b=length(data1_H);%数据采样点数
Y2=fft(data1_H);%求FFT
P2=abs(Y2/b);
P1 = P2(1:b/2+1);%单边谱?
P1(2:end-1) = 2*P1(2:end-1);%由于P1是直流
f = fs*(0:(b/2))/b;%采样频率Fs，只看fs/2的信号
P3=20*log10(P1);
figure
loglog(f,20*P1,'k');
title('实验一带通滤波后频谱')
xlabel("f/Hz")
ylabel("幅度/dB")
grid on;
set(gca,'FontSize',20,'LineWidth',1);
axes('position',[0.25,0.65,0.2,0.2]);%局部放大图位置
%axis([2213 2280 0.205 0.245]);%坐标范围设置
loglog(f,P1,'k');




data2_H=filter(lvboqi25,data2);%无过冲，通带增益也近似为1，非常良好的保留了信息
figure;
plot(a2,data2_H);
hold on;
plot(a2,data2);
title('实验二带通滤波前后');
xlabel('时间/s');
ylabel('幅度/V');
legend('带通滤波后','带通滤波前');
set(gca,'FontSize',20,'LineWidth',1);
axes('position',[0.25,0.65,0.2,0.2]);%局部放大图位置
plot(a2,data2_H);
hold on;
plot(a2,data2);



b=length(data2_H);%数据采样点数
Y2=fft(data2_H);%求FFT
P2=abs(Y2/b);
P1 = P2(1:b/2+1);%单边谱?
P1(2:end-1) = 2*P1(2:end-1);%由于P1是直流
f = fs*(0:(b/2))/b;%采样频率Fs，只看fs/2的信号
P3=20*log10(P1);
figure
loglog(f,20*P1,'k');
title('实验二带通滤波后频谱')
xlabel("f/Hz")
ylabel("幅度/dB")
grid on;
set(gca,'FontSize',20,'LineWidth',1);
axes('position',[0.25,0.65,0.2,0.2]);%局部放大图位置
%axis([2213 2280 0.205 0.245]);%坐标范围设置
loglog(f,P1,'k');



data3_H=filter(lvboqi24,data3);%无过冲，通带增益也近似为1，非常良好的保留了信息
figure;
plot(a3,data3_H);
hold on;
plot(a3,data3);
title('实验三带通滤波前后');
xlabel('时间/s');
ylabel('幅度/V');
legend('带通滤波后','带通滤波前');
set(gca,'FontSize',20,'LineWidth',1);
axes('position',[0.25,0.65,0.2,0.2]);%局部放大图位置
plot(a3,data3_H);
hold on;
plot(a3,data3);


b=length(data3_H);%数据采样点数
Y2=fft(data3_H);%求FFT
P2=abs(Y2/b);
P1 = P2(1:b/2+1);%单边谱?
P1(2:end-1) = 2*P1(2:end-1);%由于P1是直流
f = fs*(0:(b/2))/b;%采样频率Fs，只看fs/2的信号
P3=20*log10(P1);
figure
loglog(f,20*P1,'k');
title('实验三带通滤波后频谱')
xlabel("f/Hz")
ylabel("幅度/dB")
grid on;
set(gca,'FontSize',20,'LineWidth',1);
axes('position',[0.25,0.65,0.2,0.2]);%局部放大图位置
%axis([2213 2280 0.205 0.245]);%坐标范围设置
loglog(f,P1,'k');

%% VMD
imf1=vmd(data1_H,'NumIMF',5,'LMUpdateRate',0.01);
imf1=imf1';
imf2=vmd(data2_H,'NumIMF',5,'LMUpdateRate',0.01);
imf2=imf2';
imf3=vmd(data3_H,'NumIMF',5,'LMUpdateRate',0.01);
imf3=imf3';
figure
subplot(5,1,1)
plot(a1,imf1(1,:));title("IMF1");set(gca,'FontSize',15,'LineWidth',1);
subplot(5,1,2)
plot(a1,imf1(1,:));title("IMF2");set(gca,'FontSize',15,'LineWidth',1);
subplot(5,1,3)
plot(a1,imf1(3,:));title("IMF3");set(gca,'FontSize',15,'LineWidth',1);
subplot(5,1,4)
plot(a1,imf1(4,:));title("IMF4");set(gca,'FontSize',15,'LineWidth',1);
subplot(5,1,5)
plot(a1,imf1(5,:));title("IMF5");set(gca,'FontSize',15,'LineWidth',1);

figure
subplot(5,1,1)
plot(a2,imf2(1,:));title("IMF1");set(gca,'FontSize',15,'LineWidth',1);
subplot(5,1,2)
plot(a2,imf2(1,:));title("IMF2");set(gca,'FontSize',15,'LineWidth',1);
subplot(5,1,3)
plot(a2,imf2(3,:));title("IMF3");set(gca,'FontSize',15,'LineWidth',1);
subplot(5,1,4)
plot(a2,imf2(4,:));title("IMF4");set(gca,'FontSize',15,'LineWidth',1);
subplot(5,1,5)
plot(a2,imf2(5,:));title("IMF5");set(gca,'FontSize',15,'LineWidth',1);

figure
subplot(5,1,1)
plot(a3,imf3(1,:));title("IMF1");set(gca,'FontSize',15,'LineWidth',1);
subplot(5,1,2)
plot(a3,imf3(2,:));title("IMF2");set(gca,'FontSize',15,'LineWidth',1);
subplot(5,1,3)
plot(a3,imf3(3,:));title("IMF3");set(gca,'FontSize',15,'LineWidth',1);
subplot(5,1,4)
plot(a3,imf3(4,:));title("IMF4");set(gca,'FontSize',15,'LineWidth',1);
subplot(5,1,5)
plot(a3,imf3(5,:));title("IMF5");set(gca,'FontSize',15,'LineWidth',1);

%% 希尔伯特求包络
data1_H_Hil=abs(hilbert(data1_H));%求包络
data2_H_Hil=abs(hilbert(data2_H));%求包络
data3_H_Hil=abs(hilbert(data3_H));%求包络

%% 临时

data1_H_Hil=data1_H_Hil(20000:3595000,:);
data1_H=data1_H(20000:3595000,:);
data2_H_Hil=data2_H_Hil(20000:end,:);
data2_H=data2_H(20000:end,:);
data3_H_Hil=data3_H_Hil(20000:3595000,:);
data3_H=data3_H(20000:3595000,:);

b=length(data1_H_Hil);%求数组长度
a1=(1/fs:1/fs:b/fs);%生成x轴
b=length(data2_H_Hil);%求数组长度
a2=(1/fs:1/fs:b/fs);%生成x轴
b=length(data3_H_Hil);%求数组长度
a3=(1/fs:1/fs:b/fs);%生成x轴
%% 
figure; 
plot(a1,data1_H_Hil,'lineWidth',3);
hold on;
plot(a1,data1_H);
title('实验一Hilbert取包络');
xlabel('时间/s');
ylabel('幅度/V');
legend('包络','带通后信号');
set(gca,'FontSize',20,'LineWidth',1);
% axes('position',[0.2,0.65,0.2,0.2]);%局部放大图位置
% % %axis([2213 2280 0.205 0.245]);%坐标范围设置
% plot(a1,data1_H_Hil,'lineWidth',3);
% hold on;
% plot(a1,data1_H);


figure; 
plot(a2,data2_H_Hil,'lineWidth',3);
hold on;
plot(a2,data2_H);
hold on;
title('实验二Hilbert取包络');
xlabel('时间/s');
ylabel('幅度/V');
legend('包络','带通后信号');
set(gca,'FontSize',20,'LineWidth',1);
% axes('position',[0.2,0.65,0.2,0.2]);%局部放大图位置
% % %axis([2213 2280 0.205 0.245]);%坐标范围设置
% plot(a2,data2_H_Hil,'lineWidth',3);
% hold on;
% plot(a2,data2_H);


figure; 
plot(a3,data3_H_Hil,'lineWidth',3);
hold on;
plot(a3,data3_H);
hold on;
title('实验三Hilbert取包络');
xlabel('时间/s');
ylabel('幅度/V');
legend('包络','带通后信号');
set(gca,'FontSize',20,'LineWidth',1);
% axes('position',[0.2,0.65,0.2,0.2]);%局部放大图位置
% % %axis([2213 2280 0.205 0.245]);%坐标范围设置
% plot(a3,data3_H_Hil,'lineWidth',3);
% hold on;
% plot(a3,data3_H);
%% 精度比较
jiban1=load('19-29-20.csv');
jiban1=jiban1(:,2);
b=length(jiban1);%求数组长度
b1=(1/fs:1/fs:b/fs);%生成x轴
figure;
plot(b1,jiban1*1.18/(max(jiban1)));%极板归一化
hold on;
plot(a1,data1_H_Hil/max(data1_H_Hil));
title('实验一');
xlabel('时间/s');
ylabel('幅度/V');
legend('铜板上电势','传感器输出');
set(gca,'FontSize',20,'LineWidth',1);


jiban2=load('09-27-57-source-CorDenoise.csv');
jiban2=jiban2(:,1);
b=length(jiban2);%求数组长度
b2=(1/fs:1/fs:b/fs);%生成x轴
figure;
plot(b2,jiban2/(max(jiban2)));%极板归一化
hold on;
plot(a2,data2_H_Hil/max(data2_H_Hil));
title('实验二');
xlabel('时间/s');
ylabel('幅度/V');
legend('铜板上电势','传感器输出');
set(gca,'FontSize',20,'LineWidth',1);



jiban3=load('20230410_source_di1lie_Denoise.csv');
jiban3=jiban3(:,1);
b=length(jiban3);%求数组长度
b3=(1/fs:1/fs:b/fs);%生成x轴
figure;
plot(b3,(jiban3-0.43)/((max(jiban3)-0.43)));%极板归一化
hold on;
plot(a3,data3_H_Hil/max(data3_H_Hil));
title('实验三');
xlabel('时间/s');
ylabel('幅度/V');
legend('铜板上电势','传感器输出');
set(gca,'FontSize',20,'LineWidth',1);










