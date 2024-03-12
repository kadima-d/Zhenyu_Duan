close all;clc;clear;
fs=1000;%采样率
T = 1/fs;%两个点之间的距离
data1=load('20230410di2lie_Denoise.csv');
%data2=load('09-27-57-source-CorDenoise.csv');
%data3=load('09-27-57.csv');
b=length(data1);%求数组长度
a1=(1/fs:1/fs:b/fs);%生成x轴
mm1= data1(:,1);%场磨
%nn1= data2(:,1);%极板
%oo1=data3(:,2);
%pp1=data3(:,4);


mm1_highpass=filter(lvboqi24,(mm1));%高通滤波
signal=mm1_highpass;%信号
ref=mm1_highpass;   %参考信号处理前
figure(1);
plot(a1,signal);

for i=1:b
%斩波
    if ref(i,1)>0.006
        ref(i,1)=0.006;
    end
    if ref(i,1)<-0.006
        ref(i,1)=-0.006;
    end
end

ref_0=filter(WenForRef,ref);
ref_90=imag(hilbert(ref));%参考信号的正交信号
figure(2)
plot(a1,ref_0)

%锁相放大器
out1=(2.6212767171*2*filter(zuixiaoercheng3,(signal.*ref_0))).*(2.6212767171*2*filter(zuixiaoercheng3,(signal.*ref_0)));%婊ゆ尝鍚庣殑涓?矾杈撳嚭
out2=(2.6212767171*2*filter(zuixiaoercheng3,(signal.*ref_90))).*(2.6212767171*2*filter(zuixiaoercheng3,(signal.*ref_90)));%婊ゆ尝鍚庣殑浜岃矾杈撳嚭

result=sqrt((out1)+(out2));
figure(3)
plot(a1,result);




