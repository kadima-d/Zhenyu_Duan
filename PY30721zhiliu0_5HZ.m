clear;clc;close all;
%% 滤波器设计
lpFilt = designfilt('lowpassiir','FilterOrder',15, ...
         'PassbandFrequency',0.5,'PassbandRipple',0.1, ...
         'SampleRate',1000);
%fvtool(lpFilt)


%% 漂移产生
% 产生了噪声后，其方差为其噪声强度
%一点说明，对高斯白噪声，其方差和功率（单位为W）是一样的。
%因此，对方差，要做的只是将w变换成dbw，即dbw=10log（w）。

%y=randn(1,1010001);
y = wgn(1,1010001,1); %产生一个m行n列的高斯白噪声的矩阵，p以dBW为单位指定输出噪声的强度
t1=-10:0.001:1000; %t就是相当于一个数组[0.01, 0.02, 0.03,..., 9.98, 9.99, 10]
figure
plot(t1,y);

y_1=filter(PYfilter8,y);%滤波降噪
figure
plot(t1,y_1);

drift=5*y_1;%(:,300000:320000);%取300秒(300000)到320秒(320000)的漂移当作漂移
figure;
plot(drift);%产生了20s的漂移信号，纯随机，每次都不同
title('漂移信号');
xlabel('时间/s');
ylabel('幅度/V');
max = 0;%检测漂移中变化量的最大值
for i = 1:20000
    if(abs(drift(:,i+1)-drift(:,i+1))>=max)
     max =drift(:,i+1)-drift(:,i);
    end
end


%% 计算分辨率
t=-10:0.001:1000;
fenbianlu=ones(1,1010001)-1;
fenbianlv=awgn(fenbianlu,20,0);%给1加上噪声，求分辨率
figure;
plot(t,fenbianlv,'Color','k');
title('直流加噪声');
xlabel('时间/s');
ylabel('幅度/V');
f_noise_std=std(fenbianlv);% 算出标准差，其三倍为分辨率
resolution =3*f_noise_std;

%% 开始仿真

f=20;%真实信号
%f_noise=awgn(f,20,0);%加噪声进去，分别是信号，信噪比，信号功率
f_noise=f+fenbianlv;

figure;
plot(t,f_noise,'Color','k');
title('加噪声');
xlabel('时间/s');
ylabel('幅度/V');
%% 加噪声和漂移
f_noise_drift=f_noise+drift;%最终的需要处理的信号
figure;
plot(t(:,300000:320000),f_noise_drift(:,300000:320000),'Color','k');
title('加噪声和漂移');
xlabel('时间/s');
ylabel('幅度/V');

b=length(f_noise_drift(:,300000:320000));%数据采样点数
Y2=fft(f_noise_drift(:,300000:320000));%求FFT
P2=abs(Y2/b);
P1 = P2(1:b/2+1);%单边谱?
P1(2:end-1) = 2*P1(2:end-1);%由于P1是直流
f = 1000*(0:(b/2))/b;%采样频率Fs，只看fs/2的信号
P3=20*log10(P1);
figure
loglog(f,20*P1,'k');
title('直流+漂移对数频谱')
xlabel("f/Hz")
ylabel("幅度/dB")

%% 低通滤波降噪
f_LowPass=filter(PYfilter1,f_noise_drift);
figure;
plot(t,f_LowPass);
title('低通滤波去噪');
xlabel('时间/s');
ylabel('幅度/V');

%% 为算法做准备
zhunbei=filtfilt(lpFilt,f_noise_drift);
figure;
plot(t(:,300000:320000),zhunbei(:,300000:320000));%pzhunbei按理来说应该是滤波出来的漂移信号
title('低通出来的漂移');
xlabel('时间/s');
ylabel('幅度/V');
hold on;
plot(t(:,300000:320000),drift(:,300000:320000));
%% 去漂移算法  不能忘记绝对值  限制数组大小，不然会累计误差
% drift_wen=zeros(1,length(f_LowPass));
% drift_wen=drift_wen(:,300000:320000);
% f_LowPass=f_LowPass(:,300000:320000);
% zhunbei=zhunbei(:,300000:320000);
% drift=drift(:,300000:320000);
% t=t(:,300000:320000);


drift_wen=zeros(1,length(f_LowPass));
drift_wen=drift_wen(:,300000:320000);
f_LowPass=f_LowPass(:,300100:320100);
zhunbei=zhunbei(:,300000:320000);
drift=drift(:,300000:320000);
t=t(:,300000:320000);



drift_wen(1,1)=drift(1,1);%消除初始偏置


for i = 1:length(f_LowPass)-1
    if((abs(f_LowPass(1,i+1)-f_LowPass(1,i)))>resolution/370)%resolution为传感器分辨率,被除数为灵敏度
        drift_wen(1,i+1)=drift_wen(1,i)+zhunbei(1,i+1)-zhunbei(1,i);
    end

    if((abs(f_LowPass(1,i+1)-f_LowPass(1,i)))<resolution/370)%resolution为传感器分辨率
        drift_wen(1,i+1)=drift_wen(1,i)+f_LowPass(1,i+1)-f_LowPass(1,i);%更新漂移
    end

end
figure;
plot(drift_wen);%算法拟合出的漂移
hold on;
plot(drift);%刚开始随机产生出的漂移
legend('算法计算结果','漂移信号');%第四个图！！！！！！！漂移对比
%% 画图专用
fy =20*ones(1,20001);
figure;
plot(fy,'Color','k');%第一个图！！！！！！！传感信号
title('传感信号');
xlabel('采样点数');
ylabel('幅度');


figure
plot(drift,'Color','k');%第二个图！！！！！！！漂移信号
title('漂移');
xlabel('采样点数');
ylabel('幅度');

figure;
plot(f_noise_drift(:,300000:320000),'Color','k');%第三个图！！！！！！！加噪声和漂移
title('加噪声和漂移');
xlabel('采样点数');
ylabel('幅度');
%% 把漂移去除
figure;
y=f_LowPass-drift_wen;
plot(t,f_noise_drift(:,300000:320000));%第五个图！！！！！！！对比
hold on;
plot(t,y, 'Linewidth', 2);
hold on;
plot(t,fy, 'Linewidth', 2);
title('结果对比');
xlabel('采样点数');
ylabel('幅度');
legend('含漂移信号','漂移补偿结果','理想传感信号');


% figure
% plot(f_LowPass-20)
% hold on;
% plot(drift_wen)
% title('测试');
% xlabel('时间/s');
% ylabel('幅度/V');
% legend('f_LowPass','drift_wen');


% b=length(y);%数据采样点数
% Y2=fft(y);%求FFT
% P2=abs(Y2/b);
% P1 = P2(1:b/2+1);%单边谱?
% P1(2:end-1) = 2*P1(2:end-1);%由于P1是直流
% f = 1000*(0:(b/2))/b;%采样频率Fs，只看fs/2的信号
% P3=20*log10(P1);
% figure
% loglog(f,20*P1,'k');
% title('直流+漂移对数频谱')
% xlabel("f/Hz")
% ylabel("幅度/dB")

%axes('position',[0.2,0.7,0.2,0.2]);%局部放大图位置
%plot(t,y,'Color','k');

%grpdelay(PYfilter5,2,1000);

