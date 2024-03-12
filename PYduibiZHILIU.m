clear;clc;close all;

%% 漂移产生
% 产生了噪声后，其方差为其噪声强度
%一点说明，对高斯白噪声，其方差和功率（单位为W）是一样的。
%因此，对方差，要做的只是将w变换成dbw，即dbw=10log（w）。

%y=randn(1,1010001);
%y = wgn(1,1010001,1); %产生一个m行n列的高斯白噪声的矩阵，p以dBW为单位指定输出噪声的强度
y=load("piaoyiyuanshishuju.csv");
t1=-10:0.001:1000; %t就是相当于一个数组[0.01, 0.02, 0.03,..., 9.98, 9.99, 10]
figure
plot(t1,y);

y_1=filter(PYfilter4,y);%漂移频率为0.1Hz
figure
plot(t1,y_1);

drift=20*y_1;%(:,300000:320000);%取300秒(300000)到320秒(320000)的漂移当作漂移
figure;
plot(drift);%产生了20s的漂移信号，纯随机，每次都不同
title('漂移信号');
xlabel('时间/s');
ylabel('幅度/V');
max = 0;%检测漂移中变化量的最大值
for i = 1:20000
    if(abs(drift(:,i+1)-drift(:,i))>=max)
     max =abs(drift(:,i+1)-drift(:,i));
    end
end
%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1111

%% 计算分辨率
t=-10:0.001:1000;
fenbianlu=ones(1,1010001)-1;
%fenbianlv=awgn(fenbianlu,20,0)/10;%给1加上噪声，求分辨率
fenbianlv=load("zaosheng.csv");
zaoshengfangcha=var(fenbianlv);
%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
figure;
plot(t,fenbianlv,'Color','k');
title('直流加噪声');
xlabel('时间/s');
ylabel('幅度/V');
% f_noise_std=std(fenbianlv);% 算出标准差，其三倍为分辨率
% resolution =f_noise_std;

%% 开始仿真 

fy=20;

%f_noise=awgn(f,20,0);%加噪声进去，分别是信号，信噪比，信号功率
f_noise=fy+fenbianlv;

figure;
plot(t,f_noise,'Color','k');
title('加噪声');
xlabel('时间/s');
ylabel('幅度/V');
%% 加噪声和漂移
f_noise_drift=f_noise+drift;%最终的需要处理的信号


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

%% 相关去噪
lpFilt2 = designfilt('lowpassiir','FilterOrder',2, ...
         'PassbandFrequency',2,'PassbandRipple',0.1, ...
         'SampleRate',1000);

f_LowPass=Cor_Denoise_4(f_noise_drift,100,10);
f_LowPass=filtfilt(lpFilt2,f_LowPass);

f_LowPass=f_LowPass+f_noise_drift(:,300000)-f_LowPass(:,300000);%消除初始偏置
figure;
plot(f_noise_drift(:,300000:320000))
hold on;
plot(f_LowPass(:,300000:320000),'Linewidth', 2);
title('低通滤波去噪');
xlabel('时间/s');
ylabel('幅度/V');
legend('原始信号','去噪结果');%!!!!第一个图


SGNmax = 0;%检测信号中变化量的最大值
for i = 1:20000
    if(abs(f_LowPass(1,i+1)-f_LowPass(1,i))>=SGNmax)
     SGNmax =abs(f_LowPass(1,i+1)-f_LowPass(1,i));
    end
end
SGNmin = 1;%检测信号中变化量的最大值
for i = 1:20000
    if(abs(f_LowPass(:,i+1)-f_LowPass(:,i))<=SGNmin)%!!!!!!!!!!!!!!!!!!!!!!!!
     SGNmin =abs(f_LowPass(1,i+1)-f_LowPass(1,i));
    end
end

%% 评估分辨率
piece=20;%将信号等分成这些段，然后分别求出分辨率
resolutionArr =ones(1,piece);
std1=std(f_LowPass(300000:301000));resolutionArr(1)=std1;
std2=std(f_LowPass(301000:302000));resolutionArr(2)=std2;
std3=std(f_LowPass(302000:303000));resolutionArr(3)=std3;
std4=std(f_LowPass(303000:304000));resolutionArr(4)=std4;
std5=std(f_LowPass(304000:305000));resolutionArr(5)=std5;
std6=std(f_LowPass(305000:306000));resolutionArr(6)=std6;
std7=std(f_LowPass(306000:307000));resolutionArr(7)=std7;
std8=std(f_LowPass(307000:308000));resolutionArr(8)=std8;
std9=std(f_LowPass(308000:309000));resolutionArr(9)=std9;
std10=std(f_LowPass(309000:310000));resolutionArr(10)=std10;
std11=std(f_LowPass(310000:311000));resolutionArr(11)=std11;
std12=std(f_LowPass(311000:312000));resolutionArr(12)=std12;
std13=std(f_LowPass(312000:313000));resolutionArr(13)=std13;
std14=std(f_LowPass(313000:314000));resolutionArr(14)=std14;
std15=std(f_LowPass(314000:315000));resolutionArr(15)=std15;
std16=std(f_LowPass(315000:316000));resolutionArr(16)=std16;
std17=std(f_LowPass(316000:317000));resolutionArr(17)=std17;
std18=std(f_LowPass(317000:318000));resolutionArr(18)=std18;
std19=std(f_LowPass(318000:319000));resolutionArr(19)=std19;
std20=std(f_LowPass(319000:320000));resolutionArr(20)=std20;

resolution = mean(resolutionArr)/150;
resolution = mean(resolutionArr)/1;
figure
plot(resolutionArr);
%% 为算法做准备
lpFilt = designfilt('lowpassiir','FilterOrder',15, ...
         'PassbandFrequency',0.1,'PassbandRipple',0.1, ...
         'SampleRate',1000);

zhunbei=filtfilt(lpFilt,f_noise_drift);
figure;
plot(t(:,300000:320000),zhunbei(:,300000:320000));%pzhunbei按理来说应该是滤波出来的漂移信号
title('低通出来的漂移');
xlabel('时间/s');
ylabel('幅度/V');
hold on;
plot(t(:,300000:320000),drift(:,300000:320000));
hold on;
plot(t(:,300000:320000),f_noise_drift(:,300000:320000));
%% 去漂移算法  不能忘记绝对值  限制数组大小，不然会累计误差
drift_wen=zeros(1,length(f_LowPass));
drift_wen=drift_wen(:,300000:320000);
f_LowPass=f_LowPass(:,300000:320000);
zhunbei=zhunbei(:,300000:320000);
drift=drift(:,300000:320000);
t=t(:,300000:320000);

drift_wen(1,1)=drift(1,1);%消除初始偏置

max_lowpass = 0;%检测输入信号中变化量的最大值
for i = 1:20000
    if(abs(f_LowPass(:,i+1)-f_LowPass(:,i))>=max_lowpass)
     max_lowpass =abs(f_LowPass(:,i+1)-f_LowPass(:,i));
    end
end
for i = 1:length(f_LowPass)-1
    if((abs(f_LowPass(1,i+1)-f_LowPass(1,i)))>resolution/1)%resolution为传感器分辨率,被除数为灵敏度
        drift_wen(1,i+1)=drift_wen(1,i)+zhunbei(1,i+1)-zhunbei(1,i);
    end

    if((abs(f_LowPass(1,i+1)-f_LowPass(1,i)))<resolution/1)%resolution为传感器分辨率
        drift_wen(1,i+1)=drift_wen(1,i)+f_LowPass(1,i+1)-f_LowPass(1,i);%更新漂移
    end
%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
end
figure;
%plot(t,drift_wen);%算法拟合出的漂移
plot(drift_wen);%算法拟合出的漂移
hold on;
%plot(t,drift);%刚开始随机产生出的漂移
plot(drift);%刚开始随机产生出的漂移
xlabel('采样点数');
ylabel('幅度');
legend('漂移估计结果','预设漂移');%第四个图！！！！！！！漂移对比

PYimmse=immse(drift_wen,drift);%漂移评估参数
chafen=abs(drift_wen-drift);
% PYchafenmax=max(chafen,[],2);
PYchafenmax = 0;%检测漂移最大误差处
for i = 1:20000
    if(abs(chafen(1,i))>=PYchafenmax)
     PYchafenmax =abs(chafen(1,i));
    end
end
PY_mse =  sum(chafen.^2) / length(chafen );
PY_mse2 = mse(chafen);
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
result=f_LowPass-drift_wen;
plot(f_noise_drift(:,300000:320000));
hold on;
plot(result, 'Linewidth', 2);
hold on;
plot(fy, 'Linewidth', 2)%第五个图！！！！！！！结果
title('去漂移后的信号');
xlabel('采样点数');
ylabel('幅度');
legend('含漂移信号','漂移补偿结果','理想传感信号');
%% 其他的漂移算法的效果
imf=emd(f_noise_drift(:,300000:320000));
figure
plot(imf(9,:));
hold on;
plot(imf(10,:));
hold on;
plot(imf(11,:));
title('emd');
legend('1','2','3');%!!!!第一个图

lpFilt3 = designfilt('bandpassiir','FilterOrder',20, ...
         'HalfPowerFrequency1',0.5,'HalfPowerFrequency2',3, ...
         'SampleRate',1000);

butterworth_result=filtfilt(lpFilt3,f_noise_drift);
figure;
plot(f_noise_drift(:,300000:320000));
hold on;
plot(butterworth_result(:,300000:320000));
xlabel('采样点数');
ylabel('幅度');
title('数字滤波器');
%多项式拟合
P1=polyfit(t1(:,300000:320000),f_noise_drift(:,300000:320000),1);
yici=polyval(P1,t1(:,300000:320000));

P2=polyfit(t1(:,300000:320000),f_noise_drift(:,300000:320000),2);
erci=polyval(P2,t1(:,300000:320000));
figure
plot(erci);
hold on;
plot(f_noise_drift(:,300000:320000));
title('二次拟合结果');
P3=polyfit(t1(:,300000:320000),f_noise_drift(:,300000:320000),3);
sanci=polyval(P3,t1(:,300000:320000));
P4=polyfit(t1(:,300000:320000),f_noise_drift(:,300000:320000),4);
sici=polyval(P4,t1(:,300000:320000));
P5=polyfit(t1(:,300000:320000),f_noise_drift(:,300000:320000),5);
wuci=polyval(P5,t1(:,300000:320000));
P6=polyfit(t1(:,300000:320000),f_noise_drift(:,300000:320000),6);
liuci=polyval(P6,t1(:,300000:320000));
plot(liuci);
hold on;
plot(f_noise_drift(:,300000:320000));
title('6次拟合结果');
figure
% plot(f_noise_drift(:,300000:320000)-yici+yici(1));
% hold on;
% plot(f_noise_drift(:,300000:320000)-erci+erci(1));
% hold on;
% plot(f_noise_drift(:,300000:320000)-sanci+sanci(1));
% hold on;
% plot(f_noise_drift(:,300000:320000)-sici+sici(1));
% hold on;


% plot(yidongjunzhi(:,300000:320000));
% hold on;
plot(f_noise_drift(:,300000:320000)-imf(11,:)+20-imf(10,:));%-imf(9,:)-imf(1,:)-imf(2,:)-imf(3,:)+20);
hold on;
plot(f_noise_drift(:,300000:320000)-wuci+20);
hold on;
plot(f_noise_drift(:,300000:320000)-liuci+20);
hold on;
plot(butterworth_result(:,300000:320000)+20,'Linewidth', 2);
hold on;
plot(result+0.005, 'Linewidth', 3);
hold on;
plot(fy, 'Linewidth', 2)%第五个图！！！！！！！结果

hold on;
title('对比');
xlabel('采样点数');
ylabel('幅度');
legend('emd','五次','六次','巴特沃斯滤波器','本文算法','理想信号');

%plot(yici-yici(1)+drift(1));
% plot(yici-20);
% hold on;
% plot(erci-20);
% hold on;
% plot(sanci-20);
% hold on;
% plot(sici-20);
% hold on;
figure
plot(imf(11,:)+imf(10,:)-20);
hold on;
plot(wuci-20);
hold on;
plot(liuci-20);
hold on;
plot(f_noise_drift(:,300000:320000)-butterworth_result(:,300000:320000)-20);
hold on;
plot(drift);
hold on;
plot(drift_wen);
title('对比');
xlabel('采样点数');
ylabel('幅度');
legend('emd','五次','六次','巴特沃斯滤波器','本文算法','理想信号');




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

