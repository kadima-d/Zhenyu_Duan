clc;clear;close all;
%测试，给图用，demo2为正式版程序
tic
%对希尔伯特变换的改进fs=1000;%采样率
fs=1000;%采样率
T = 1/fs;%两个点之间的距离
data1=load('19-29-20.csv');%直流
b=length(data1);%求数组长度
a1=(1/fs:1/fs:b/fs);%生成x轴

data2=load('09-27-57.csv');%方波
b=length(data2);%求数组长度
a2=(1/fs:1/fs:b/fs);%生成x轴


data3=load('20230410.csv');%三角波
b=length(data3);%求数组长度
a3=(1/fs:1/fs:b/fs);%生成x轴


figure(1);
%set(gcf,'position',[250 300 600 600]);

% %subplot(1,3,1);
%set(gca,'position', [0.1 0.15 0.7 0.7]);
plot(a1,data1(:,4),'Color',[1 0 0]);
%csvwrite('shiyanyiY.csv',mm1_highpass');
%csvwrite('shiyanyiX.csv',mm1_highpass');
legend('实验一');
data1=data1(:,4);
ylabel('电压(V)','FontSize',12,'FontName','华文中宋');
xlabel('时间(s)','FontSize',12,'FontName','华文中宋');
%小图范围x:2280~2213 y:0.205~0.245
axes('position',[0.2,0.7,0.2,0.2]);%局部放大图位置
%axis([2213 2280 0.205 0.245]);%坐标范围设置
plot(a1,data1,'Color',[1 0 0]);
% hold on;
% 
% subplot(1,3,2);
figure(2);
plot(a2,data2(:,4),'Color',[0 1 0]);
legend('实验二');
data2=data2(:,4);
ylabel('电压(V)','FontSize',12,'FontName','华文中宋');
xlabel('时间(s)','FontSize',12,'FontName','华文中宋');
% %小图范围x:2398~2405 y:0.19~0.25
axes('position',[0.2,0.7,0.2,0.2]);%局部放大图位置
% %axis([2213 2280 0.205 0.245]);%坐标范围设置
plot(a2,data2,'Color',[0 1 0]);


figure(3);
plot(a3,data3(:,2),'Color',[0 0 1]);
legend('实验三');
data3=data3(:,2);
ylabel('电压(V)','FontSize',12,'FontName','华文中宋');
xlabel('时间(s)','FontSize',12,'FontName','华文中宋');
% %小图范围x:2398~2405 y:0.19~0.25
axes('position',[0.2,0.7,0.2,0.2]);%局部放大图位置
% %axis([2213 2280 0.205 0.245]);%坐标范围设置
plot(a3,data3,'Color',[0 0 1]);
% 
% subplot(1,3,3);
% plot(a3,data3(:,2),'Color',[0 0 1]);
% data3=data3(:,2);
% ylabel('电压(V)','FontSize',12,'FontName','华文中宋');
% xlabel('时间(s)','FontSize',12,'FontName','华文中宋');
% %小图范围x:852~862 y:0.11~0.16
% axes('position',[0.8,0.6,0.1,0.1]);%局部放大图位置
% %axis([2213 2280 0.205 0.245]);%坐标范围设置
% plot(a3,data3,'Color',[0 0 1]);
% legend('实验三');


%% 相关去噪


Cor_Denoise_3();


Cor_Denoise_3();



Cor_Denoise_3();













