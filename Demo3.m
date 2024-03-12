tic
%对希尔伯特变换的改进fs=1000;%采样率
fs=1000;%采样率
T = 1/fs;%两个点之间的距离
data1=load('20230410di2lie_Denoise.csv');
data2=load('20230410_source_di1lie_Denoise.csv');
data3=load('20230410.csv');
b=length(data1);%求数组长度
a1=(1/fs:1/fs:b/fs);%生成x轴
mm1= data1(:,1);%场磨
nn1= data2(:,1);%极板
oo1=data3(:,2);
pp1=data3(:,4);
%% 高通+低通
%mm1_highpass=filter(lvboqi13,(filter(lvboqi12,mm1)));%高通滤波
%mm1_highpass=filter(Bandpass,mm1);%有过冲存在
% mm1_highpass=filter(lvboqi24,mm1);%通带增益不为1
% figure(1);
% plot(a1,mm1_highpass);
% hold on;
% plot(a1,mm1);
% title('高通滤波后');
% xlabel('时间/s');
% ylabel('幅度/V');
% legend('高通滤波后','源信号');
%% 看信号

% figure(100)
% t1=(1/fs:1/fs:length(data3(:,1))/fs);%生成x轴
% plot(t1,data3(:,1));
% hold on;
% plot(a1,nn1);
% hold on;
% title('极板前后对比');
toc
