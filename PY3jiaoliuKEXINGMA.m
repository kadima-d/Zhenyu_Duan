clear;clc;close all;
%% 滤波器设计
lpFilt = designfilt('lowpassiir','FilterOrder',15, ...
         'PassbandFrequency',0.1,'PassbandRipple',0.1, ...
         'SampleRate',1000);
%fvtool(lpFilt)


%% 漂移产生
y=randn(1,1010001);
t1=-10:0.001:1000; %t就是相当于一个数组[0.01, 0.02, 0.03,..., 9.98, 9.99, 10]
figure
plot(t1,y);

y_1=filter(PYfilter4,y);%滤波器的截止频率决定了漂移的频带
figure
plot(t1,y_1);

drift=2000*y_1;%(:,300000:320000);%取300秒(300000)到320秒(320000)的漂移当作漂移
figure;
plot(drift);%产生了20s的漂移信号，纯随机，每次都不同
title('漂移信号');
xlabel('时间/s');
ylabel('幅度/V');
PYmax = 0;%检测漂移中变化量的最大值
for i = 1:20000
    if(abs(drift(1,i+1)-drift(1,i))>=PYmax)
     PYmax =abs(drift(1,i+1)-drift(1,i));
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
%% 为算法做准备

%% 开始仿真

f=100*sin(2*pi*t);  
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

%% 低通滤波降噪
f_LowPass=filter(PYfilter1,f_noise_drift);
figure;
plot(t,f_LowPass);
title('低通滤波去噪');
xlabel('时间/s');
ylabel('幅度/V');

SGNmax = 0;%检测信号中变化量的最大值
for i = 1:20000
    if(abs(f_LowPass(1,i+1)-f_LowPass(1,i))>=SGNmax)
     SGNmax =abs(f_LowPass(1,i+1)-f_LowPass(1,i));
    end
end
SGNmin = 0;%检测信号中变化量的最大值
for i = 1:20000
    if(abs(f_LowPass(:,i+1)-f_LowPass(:,i))<=SGNmin)
     SGNmin =abs(f_LowPass(1,i+1)-f_LowPass(1,i));
    end
end
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
    if((abs(f_LowPass(1,i+1)-f_LowPass(1,i)))>resolution/1)%resolution为传感器分辨率,被除数为灵敏度
        drift_wen(1,i+1)=drift_wen(1,i)+zhunbei(1,i+1)-zhunbei(1,i);
    end

    if((abs(f_LowPass(1,i+1)-f_LowPass(1,i)))<resolution/1)%resolution为传感器分辨率
        drift_wen(1,i+1)=drift_wen(1,i)+f_LowPass(1,i+1)-f_LowPass(1,i);%更新漂移
    end

end
figure;
plot(t,drift_wen);%算法拟合出的漂移
hold on;
plot(t,drift);%刚开始随机产生出的漂移
xlabel('时间/s');
ylabel('幅度/V');
legend('算法计算出的漂移','人为给的漂移');


drigt_wen_test=filter(PYfilter3,drift_wen);
figure;
plot(t,drigt_wen_test);%算法拟合出的漂移
hold on;
plot(t,drift);%刚开始随机产生出的漂移
title('测试漂移能否达标');
xlabel('时间/s');
ylabel('幅度/V');
legend('算法计算出的漂移','人为给的漂移');






%% 画图专用
fdraw=100*sin(2*pi*t1);  
figure;
plot(t1(:,300000:320000),fdraw(:,300000:320000),'Color','k');%第一个图！！！！！！！传感信号
title('传感信号');
xlabel('时间/s');
ylabel('幅度/V');

figure
plot(t,drift,'Color','k');%第二个图！！！！！！！漂移信号
title('漂移');
xlabel('时间/s');
ylabel('幅度/V');

figure;
plot(t,f_noise_drift(:,300000:320000),'Color','k');%第三个图！！！！！！！加噪声和漂移
title('加噪声和漂移');
xlabel('时间/s');
ylabel('幅度/V');
%% 把漂移去除
y=f_LowPass-drift_wen;
figure;
plot(t,f_noise_drift(:,300000:320000));
hold on ;
%plot(t1(:,300000:320000),fdraw(:,300000:320000));
%hold on;
plot(t,y);
title('结果对比');
xlabel('时间/s');
ylabel('幅度/V');
legend('传感信号+漂移','经过去漂移算法的输出');

figure
plot(t1(:,300100:320100),fdraw(:,300000:320000));
hold on;
plot(t,y);
title('结果对比');
xlabel('时间/s');
ylabel('幅度/V');
legend('理想传感信号','经过去漂移算法的输出');
%axes('position',[0.2,0.7,0.2,0.2]);%局部放大图位置
%plot(t,y,'Color','k');

%grpdelay(PYfilter5,2,1000);

