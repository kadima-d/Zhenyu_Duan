fs=1000;%采样率
T = 1/fs;%两个点之间的距离
data1=load('09-27-57-Cor_Denoise.csv');
data2=load('09-27-57-source-CorDenoise.csv');
data3=load('09-27-57.csv');
b=length(data1);%求数组长度
a1=(1/fs:1/fs:b/fs);%生成x轴
mm1= data1(:,1);%场磨
nn1= data2(:,1);%极板
oo1=data3(:,2);
pp1=data3(:,4);
%% 希尔伯特变换求包络

% result=200*filter(n10Lowpass,abs(hilbert(filter(highpass2,(mm1)))));
% plot(a1,result);
% hold on;
% 
% preresult=filter(n10Lowpass,abs(hilbert(filter(highpass2,(mm1)))));
% plot(a1,filter(n10Lowpass,abs(hilbert(filter(highpass2,(mm1))))));
% hold on;
% plot(a1,nn1/(max(nn1)));%极板归一化
% hold on;
% 
% plot(a1,filter(highpass2,(mm1)));
% hold on;
%% 高通+低通
mm1_highpass=filter(lvboqi13,(filter(lvboqi12,mm1)));%高通滤波
figure(1);
plot(a1,mm1_highpass);
hold on;
plot(a1,mm1);
title('高通滤波后');
xlabel('时间/s');
ylabel('幅度/V');
legend('高通滤波后','源信号');
%% 去过冲
%检测离群值，这个可以限制标准差的大小，但不能去除尖刺噪声
B = filloutliers(mm1_highpass,"spline","movmedian",10000);
figure(2)
plot(a1,B)
%大信号有效果，小信号效果不明显
%plot(a1,filloutliers(mm1_highpass,'previous','quartiles'));%第二个
% mm1_highpass_outliers=filloutliers(mm1_highpass,'previous','quartiles');%去除离群点
% figure(2);
% plot(a1,mm1_highpass_outliers);
% title('去除离群点后');

%原始包络和高通后的对比
%% 希尔伯特求包络
mm1_highpass_outliers_hilbert=abs(hilbert(B));%求包络
figure(3); 
plot(a1,mm1_highpass_outliers_hilbert);
title('包络');
hold on;
plot(a1,mm1_highpass);
hold on;
title('高通滤波后');
xlabel('时间/s');
ylabel('幅度/V');
legend('包络','源信号');

%原始包络低通后和高通后的对比
mm1_highpass_outliers_hilbert_lowpass =filter(lvboqi10,mm1_highpass_outliers_hilbert);%求包络后求低通
figure(4);
plot(a1,mm1_highpass);
hold on;
plot(a1,mm1_highpass_outliers_hilbert_lowpass);
hold on
%归一化比较

figure(5)
plot(a1,filloutliers(mm1_highpass_outliers_hilbert_lowpass,0.004)/0.004);
hold on;
plot(a1,nn1/(max(nn1)));%极板归一化
hold on;
title('归一化比较');
xlabel('时间/s');
ylabel('幅度/V');
legend('场磨','极板');
% plot(a1,filter(n10Lowpass,abs(hilbert(mm1_highpass)))/0.006);
% hold on;
% plot(a1,nn1/(max(nn1)));
% hold on;
%不好用
%plot(a1,filloutliers(mm1_highpass,'previous','mean'));%第二个
%不好用
%plot(a1,filloutliers(mm1_highpass,'previous','movmedian',3000));%第四个
%第三个不好用
%plot(a1,filloutliers(mm1_highpass,'previous',"percentiles",[10 90]));%第三个

%滑动平均算法，每n个点取平均值,用不上
% plot(a1,movmean(mm1,5));%后面的参数为窗口长度
% hold on;
%% 第二种尝试 用FFT去直流
% data1_fft=fft(data1);
% data1_fftNew = data1_fft;
% data1_fftNew(1)=0;
% data1_fftNew(2)=0;
% data1_fftNew(3)=0;
% data1_fftNew(4)=0;
% x_new=real(ifft(data1_fftNew));
% figure(1);
% plot(a1,x_new);
% hold on;
% plot(a1,data1);
% hold on;

%% 第三种尝试 直接上锁相放大器

%% 第四种尝试，利用极大极小值求包络线
% [K1,V1]=findpeaks(filter(highpass2,(mm1)),'MinPeakWidth',800); % 求极大值位置和幅值
% up=spline(K1,V1,b);          % 内插,获取上包络曲线
% [K2,V2]=findpeaks(filter(highpass2,(mm1)),'MinPeakWidth',800);% 求极小值位置和幅值
% down=spline(K2,V2,b);        % 内插,获取下包络曲线
% figure(4)
% plot(a1,up);
% hold on;
% plot(a1,down);
% hold on;
% plot(a1,filter(highpass2,(mm1)));
% hold on;

 %% 第五种尝试，利用envelope极值
% y = hampel(mm1);
% [yupper,ylower]= envelope(y,800,'peak');
% plot(a1,(yupper-ylower)/max(yupper-ylower));
% hold on;
% plot(a1,nn1/max(nn1));
% hold on;
% 
% plot(a1,yupper);
% hold on;
% plot(a1,ylower);
% hold on;
% plot(a1,mm1);
% hold on;
% plot(a1,(yupper-ylower));
% hold on;
% plot(a1,(yupper-ylower)/max(yupper-ylower));
% hold on;
