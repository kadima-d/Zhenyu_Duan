function displayFFT_D(fsInput,signal)
fs=fsInput;%采样率
T = 1/fs;%两个点之间的距离
%参数分别为开始读的行和开始读的列
%data=csvread('18-16-28.csv',0,0);%csvread只能读取纯数据
data1=load(signal);

x1= data1(:,1);% 取第n列做频谱
%y1= data1(:,2);
%x2= data1(:,3);
%y2= data1(:,4);

b=length(x1);%数据采样点数
Y2=fft(x1);%求FFT
P2=abs(Y2/b);
P1 = P2(1:b/2+1);%单边谱?
P1(2:end-1) = 2*P1(2:end-1);%由于P1是直流
f = fs*(0:(b/2))/b;%采样频率Fs，只看fs/2的信号
P3=20*log10(P1);

figure;
plot(f,P1) ;
title('频谱')
xlabel("f/Hz")
ylabel("幅度")
grid on
% 
% figure
% P1log=20*log10(P1);
% plot(f,P1log);
% title('纵坐标对数频谱')
% xlabel("f/Hz")
% ylabel("幅度")
% grid on;
% 
% figure
% 
% %semilogx(f,P1log);
% %flog=log10(f);
% plot(f,P1) ;
% set(gca,'XScale','log') 
% title('横坐标对数频谱')
% xlabel("f/Hz")
% ylabel("幅度")
% grid on;

figure
loglog(f,20*P1,'k');
title('实验三相关去噪后频谱')
xlabel("f/Hz")
ylabel("幅度/dB")
grid on;
axes('position',[0.65,0.7,0.2,0.2]);%局部放大图位置
%axis([2213 2280 0.205 0.245]);%坐标范围设置
loglog(f,P1,'k');
% figure(1);%第一个图
% plot(x1,y1);
% hold on;
% plot(x2,y2);
% 
% figure(2);%第二个图
% plot(x1,y1);
% 
% figure(3);%第三个图
% plot(x2,y2);