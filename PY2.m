clear;clc;close all;
t=0:0.001:1000; %t就是相当于一个数组[0.01, 0.02, 0.03,..., 9.98, 9.99, 10]
f=sin(2*pi*t)+0.01*t;
figure;
plot(t,f,'Color','k');
title('仿真');
xlabel('时间/s');
ylabel('幅度/V');


f_noise=awgn(f,20,0);%加噪声进去，分别是信号，信噪比，信号功率
figure;
plot(t,f_noise,'Color','k');
title('含有漂移和白噪声的信号');
xlabel('时间/s');
ylabel('幅度/V');
axes('position',[0.2,0.7,0.2,0.2]);%局部放大图位置
%axis([2213 2280 0.205 0.245]);%坐标范围设置
plot(t,f_noise,'Color','k');

f_noise_Denoise=filter(PYfilter1,f_noise);%滤波降噪
figure;
plot(t,f_noise_Denoise,'Color','k');
title('去噪后的信号');
xlabel('时间/s');
ylabel('幅度/V');
axes('position',[0.2,0.7,0.2,0.2]);%局部放大图位置
%axis([2213 2280 0.205 0.245]);%坐标范围设置
plot(t,f_noise_Denoise,'Color','k');
%% 做后续低通滤波的数据准备
f_LowPass=filter(PYfilter2,f_noise_Denoise);
figure;
plot(t,f_LowPass);
title('1');

%% 去噪算法
% f_noise_Denoise=f_noise_Denoise(1,1000000:end);
% f_LowPass=f_LowPass(1,1000000:end);
% b=length(f_LowPass);%求数组长度
% t=(1/1000:1/1000:b/1000);%生成x轴

% 仪器分辨率：0.5
drift=zeros(1,length(f_noise_Denoise));
for i = 1:length(f_noise_Denoise)-1
    if((f_noise_Denoise(1,i+1)-f_noise_Denoise(1,i))>0.0060)%0.5为传感器分辨率
        drift(1,i+1)=drift(1,i)+f_LowPass(1,i+1)-f_LowPass(1,i);
    end

    if((f_noise_Denoise(1,i+1)-f_noise_Denoise(1,i))<0.0060)%0.5为传感器分辨率
        drift(1,i+1)=drift(1,i)+f_noise_Denoise(1,i+1)-f_noise_Denoise(1,i);%更新漂移
    end

end
figure;
plot(t,drift,'Color','k');

figure;
y=f_noise_Denoise-f_LowPass;
plot(t,y,'Color','k');
title('去漂移后的信号');
xlabel('时间/s');
ylabel('幅度/V');
axes('position',[0.2,0.7,0.2,0.2]);%局部放大图位置
%axis([2213 2280 0.205 0.245]);%坐标范围设置
plot(t,y,'Color','k');