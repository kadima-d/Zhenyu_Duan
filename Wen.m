close all;clc;clear;
fs=1000;%������
T = 1/fs;%������֮��ľ���
data1=load('20230410di2lie_Denoise.csv');
%data2=load('09-27-57-source-CorDenoise.csv');
%data3=load('09-27-57.csv');
b=length(data1);%�����鳤��
a1=(1/fs:1/fs:b/fs);%����x��
mm1= data1(:,1);%��ĥ
%nn1= data2(:,1);%����
%oo1=data3(:,2);
%pp1=data3(:,4);


mm1_highpass=filter(lvboqi24,(mm1));%��ͨ�˲�
signal=mm1_highpass;%�ź�
ref=mm1_highpass;   %�ο��źŴ���ǰ
figure(1);
plot(a1,signal);

for i=1:b
%ն��
    if ref(i,1)>0.006
        ref(i,1)=0.006;
    end
    if ref(i,1)<-0.006
        ref(i,1)=-0.006;
    end
end

ref_0=filter(WenForRef,ref);
ref_90=imag(hilbert(ref));%�ο��źŵ������ź�
figure(2)
plot(a1,ref_0)

%����Ŵ���
out1=(2.6212767171*2*filter(zuixiaoercheng3,(signal.*ref_0))).*(2.6212767171*2*filter(zuixiaoercheng3,(signal.*ref_0)));%滤波后的�?��输出
out2=(2.6212767171*2*filter(zuixiaoercheng3,(signal.*ref_90))).*(2.6212767171*2*filter(zuixiaoercheng3,(signal.*ref_90)));%滤波后的二路输出

result=sqrt((out1)+(out2));
figure(3)
plot(a1,result);




