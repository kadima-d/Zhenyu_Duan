clc;clear;close all;
tic
%对希尔伯特变换的改进fs=1000;%采样率
fs=1000;%采样率
T = 1/fs;%两个点之间的距离
data1=load('20230410di2lie_Denoise.csv');
data2=load('20230410_source_di1lie_Denoise.csv');
data3=load('20230410.csv');
data4=load('20230410di5lieDiff_Denoise.csv');
b=length(data1);%求数组长度
a1=(1/fs:1/fs:b/fs);%生成x轴

mm1= data1(:,1);%场磨
%mm1=data4;%第二列和第三列进行差分



nn1= data2(:,1);%极板
oo1=data3(:,2);
pp1=data3(:,4);
%% 高通+低通
%mm1_highpass=filter(lvboqi13,(filter(lvboqi12,mm1)));%高通滤波
%mm1_highpass=filter(Bandpass,mm1);%有过冲存在
%mm1_highpass=filter(lvboqi20,mm1);%通带增益不为1
mm1_highpass=filter(lvboqi24,mm1);%无过冲，通带增益也近似为1，非常良好的保留了信息


figure(1);
plot(a1,mm1_highpass);
hold on;
plot(a1,mm1);
title('高通滤波后');
xlabel('时间/s');
ylabel('幅度/V');
legend('高通滤波后','源信号');
%% 去除离散点
% x=mm1_highpass';
% x=[x(1:5*fs),x,x(b-5*fs:b)];
% figure(3)
% t=T:T:length(x)/fs;
% plot(t,x);
% 
% for i = 5*fs+1:b-5*fs-1     %取前五秒
% junfangcha=std(x((i-2.5*fs) : (i+2.5*fs)));
% if x(i)>1.5*junfangcha
%     x(i)=x(i)/5;
% end
% end
% 
% x=x(5*fs+1:b+5*fs);
% figure(4)
% t=0.001:0.001:length(x)/1000;
% plot(t,x);
% mm1_highpass = x';
%% 小波变换
% 
% % 小波变换 
% [c, l] = wavedec(mm2, 5, 'db4'); % 5层小波分解，使用db4小波基函数 
% approx = wrcoef('a', c, l, 'db4', 5); % 重构近似系数 
% detail = wrcoef('d', c, l, 'db4', 5); % 重构细节系数
% 
% % 滤波 
% z = wden(mm2, 'sqtwolog', 'h', 'mln', 10, 'sym8'); % 对细节系数进行软阈值滤波 
% y = mm2-z;
% 
% % 绘图 
% subplot(2,1,1); plot(a1, mm2); title('原始信号'); xlabel('时间（秒）'); ylabel('幅值'); 
% subplot(2,1,2); plot(a1, y); title('滤波后信号'); xlabel('时间（秒）'); ylabel('幅值');
% 

%% 高通+低通
% 
% mm1_highpass=filter(lvboqi15,mm1);%高通滤波
% figure(1);
% plot(a1,mm1_highpass);
% hold on;
% plot(a1,mm1);
% title('高通滤波后');
% xlabel('时间/s');
% ylabel('幅度/V');
% legend('高通滤波后','源信号');

%% 去除离散点
% B = filloutliers(mm1_highpass,"center","movmean",10000);
% figure(2)
% plot(a1,B)
%% vmdoyjh
%[mm1_highpass_extend,mm1Begin,mm1End]=edge_extend(mm1_highpass);
imf=VMD_display(mm1_highpass,1000,5);
signal=imf(5,:)';

%% 希尔伯特求包络
mm1_highpass_outliers_hilbert=abs(hilbert(signal));%求包络
figure(100); 
plot(a1,mm1_highpass_outliers_hilbert);
hold on;
plot(a1,signal);
hold on;
title('希尔伯特求包络');
xlabel('时间/s');
ylabel('幅度/V');
legend('包络','源信号');
%% 低通滤波器
mm1_highpass_outliers_hilbert_lowpass =filter(lvboqi10,mm1_highpass_outliers_hilbert);%求包络后求低通
figure(10000);
plot(a1,signal);
hold on;
plot(a1,mm1_highpass_outliers_hilbert_lowpass);
hold on
title('希尔伯特求包络');
xlabel('时间/s');
ylabel('幅度/V');
legend('源信号','包络');

%% 归一化比较
figure(600)

a1=(1/fs:1/fs:(b-29999)/fs);%生成x轴

plot(a1,(nn1(30000:b)-0.46)/(max((nn1(30000:b)-0.46))));%极板归一化
hold on;
plot(a1,mm1_highpass_outliers_hilbert_lowpass(30000:b)/max(mm1_highpass_outliers_hilbert_lowpass(30000:b)));
hold on;
title('归一化比较');
xlabel('时间/s');
ylabel('幅度/V');
legend('极板','场磨');
%% 与锁相放大进行比较
% figure(300);
% plot(a1,mm1_highpass_outliers_hilbert_lowpass/max(mm1_highpass_outliers_hilbert_lowpass));
% LIA();
% 
% toc