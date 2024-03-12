clear;clc;close all;
%% 滤波器设计
lpFilt = designfilt('lowpassiir','FilterOrder',15, ...
         'PassbandFrequency',0.1,'PassbandRipple',0.1, ...
         'SampleRate',1000);
%fvtool(lpFilt)
%漂移的频率决定此滤波器的频率
lpFilt2 = designfilt('lowpassiir','FilterOrder',10, ...
         'PassbandFrequency',10,'PassbandRipple',0.1, ...
         'SampleRate',1000);
%% 漂移产生
y=randn(1,1010001);
t1=-10:0.001:1000; %t就是相当于一个数组[0.01, 0.02, 0.03,..., 9.98, 9.99, 10]
figure
plot(t1,y);

y_1=filter(PYfilter4,y);%滤波降噪
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


%% 计算分辨率
t=-10:0.001:1000;
fenbianlu=ones(1,1010001)-1;
fenbianlv=awgn(fenbianlu,20,0)/10;%给1加上噪声，求分辨率
figure;
plot(t,fenbianlv,'Color','k');
title('直流加噪声');
xlabel('时间/s');
ylabel('幅度/V');
% f_noise_std=std(fenbianlv);% 算出标准差，其三倍为分辨率
% resolution =3*f_noise_std;

%% 开始仿真

f=sin(20*pi*t);  
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

%% 相关去噪
lpFilt2 = designfilt('lowpassiir','FilterOrder',10, ...
         'PassbandFrequency',15,'PassbandRipple',0.1, ...
         'SampleRate',1000);

f_LowPass=Cor_Denoise_4(f_noise_drift,100,10);
f_LowPass=filtfilt(lpFilt2,f_LowPass);

f_LowPass=f_LowPass+f_noise_drift(:,300000)-f_LowPass(:,300000);%消除初始偏置
figure;
plot(f_LowPass(:,300000:320000));
hold on;
plot(f_noise_drift(:,300000:320000))
title('低通滤波去噪');
xlabel('时间/s');
ylabel('幅度/V');
legend('去噪结果','原始信号');%!!!!第一个图


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

resolution = mean(resolutionArr);
figure
plot(resolutionArr);

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
drift_wen=zeros(1,length(f_LowPass));
drift_wen=drift_wen(:,300000:320000);
f_LowPass=f_LowPass(:,300000:320000);
zhunbei=zhunbei(:,300000:320000);
drift=drift(:,300000:320000);
t=t(:,300000:320000);

drift_wen(1,1)=drift(1,1);%消除初始偏置


for i = 1:length(f_LowPass)-1
    if((abs(f_LowPass(1,i+1)-f_LowPass(1,i)))>resolution/1000)%resolution为传感器分辨率,被除数为灵敏度
        drift_wen(1,i+1)=drift_wen(1,i)+zhunbei(1,i+1)-zhunbei(1,i);
    end

    if((abs(f_LowPass(1,i+1)-f_LowPass(1,i)))<resolution/1000)%resolution为传感器分辨率
        drift_wen(1,i+1)=drift_wen(1,i)+f_LowPass(1,i+1)-f_LowPass(1,i);%更新漂移
    end

end


drift_wen=filtfilt(lpFilt2,drift_wen);
figure;
plot(drift_wen);%算法拟合出的漂移
hold on;
plot(drift);%刚开始随机产生出的漂移
xlabel('采样点数');
ylabel('幅度');
title('结果对比');
legend('漂移估计结果','预设漂移');%第四个图！！！！！！！！！漂移对比
chafen=abs(drift_wen-drift);
PYchafenmax = 0;%检测漂移最大误差处
for i = 100:18000 %剔除两端数据
    if(abs(chafen(1,i))>=PYchafenmax)
     PYchafenmax =abs(chafen(1,i));
    end
end
PY_mse =  sum(chafen.^2) / length(chafen );
PY_mse2 = mse(chafen);
%% 画图专用
fdraw=sin(20*pi*t1);  
figure;
plot(fdraw(:,300000:320000),'Color','k');%第一个图！！！！！！！传感信号
title('传感信号');
xlabel('采样点数');
ylabel('幅度');
%axes('position',[0.2,0.7,0.2,0.2]);%局部放大图位置
%plot(fdraw(:,300000:320000),'Color','k');

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
y=f_LowPass-drift_wen;
figure;
plot(f_noise_drift(:,300000:320000));
hold on ;
%plot(t1(:,300000:320000),fdraw(:,300000:320000));
%hold on;
plot(y);
title('结果对比');
xlabel('采样点数');
ylabel('幅度');
legend('含漂移信号','漂移补偿结果');


figure
plot(fdraw(:,300000:320000));
hold on;
plot(y);
title('结果对比');
xlabel('采样点数');
ylabel('幅度');
legend('理想传感信号','漂移补偿结果');
%axes('position',[0.2,0.7,0.2,0.2]);%局部放大图位置
%plot(t,y,'Color','k');

%grpdelay(PYfilter5,2,1000);

