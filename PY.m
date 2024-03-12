clear;clc;close all;
t=-10:0.001:10; %t就是相当于一个数组[0.01, 0.02, 0.03,..., 9.98, 9.99, 10]
f=heaviside(t)+0.01*t;
figure;
plot(t,f,'Color','k');
title('1');
xlabel('时间/s');
ylabel('幅度/V');
legend('1');

f_noise=awgn(f,20,0);%加噪声进去，分别是信号，信噪比，信号功率
figure;
plot(t,f_noise,'Color','k');
title('含有漂移和白噪声的信号');
xlabel('时间/s');
ylabel('幅度/V');
%legend('含有漂移和白噪声的信号');

f_noise_Denoise=filter(PYfilter1,f_noise);%滤波降噪
figure;
plot(t,f_noise_Denoise,'Color','k');
title('去噪后的信号');
xlabel('时间/s');
ylabel('幅度/V');
%legend('去噪后的信号');
%% 去噪算法
% 仪器分辨率：0.5
drift=zeros(1,length(f_noise_Denoise));
for i = 1:length(f_noise_Denoise)-1
    if((f_noise_Denoise(1,i+1)-f_noise_Denoise(1,i))>0.0002)%0.5为传感器分辨率
        drift(1,i+1)=drift(1,i);
    end

    if((f_noise_Denoise(1,i+1)-f_noise_Denoise(1,i))<0.002)%0.5为传感器分辨率
        drift(1,i+1)=drift(1,i)+f_noise_Denoise(1,i+1)-f_noise_Denoise(1,i);%更新漂移
    end

end
figure;
y=f_noise_Denoise-drift;
plot(t,y,'Color','k');
title('去漂移后的信号');
xlabel('时间/s');
ylabel('幅度/V');
%legend('去漂移后的信号');