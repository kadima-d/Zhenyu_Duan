clc;clear;close all;
tic
%��ϣ�����ر任�ĸĽ�fs=1000;%������
fs=1000;%������
T = 1/fs;%������֮��ľ���
data1=load('20230410di2lie_Denoise.csv');
data2=load('20230410_source_di1lie_Denoise.csv');
data3=load('20230410.csv');
data4=load('20230410di5lieDiff_Denoise.csv');
b=length(data1);%�����鳤��
a1=(1/fs:1/fs:b/fs);%����x��

mm1= data1(:,1);%��ĥ
%mm1=data4;%�ڶ��к͵����н��в��



nn1= data2(:,1);%����
oo1=data3(:,2);
pp1=data3(:,4);
%% ��ͨ+��ͨ
%mm1_highpass=filter(lvboqi13,(filter(lvboqi12,mm1)));%��ͨ�˲�
%mm1_highpass=filter(Bandpass,mm1);%�й������
%mm1_highpass=filter(lvboqi20,mm1);%ͨ�����治Ϊ1
mm1_highpass=filter(lvboqi24,mm1);%�޹��壬ͨ������Ҳ����Ϊ1���ǳ����õı�������Ϣ


figure(1);
plot(a1,mm1_highpass);
hold on;
plot(a1,mm1);
title('��ͨ�˲���');
xlabel('ʱ��/s');
ylabel('����/V');
legend('��ͨ�˲���','Դ�ź�');
%% ȥ����ɢ��
% x=mm1_highpass';
% x=[x(1:5*fs),x,x(b-5*fs:b)];
% figure(3)
% t=T:T:length(x)/fs;
% plot(t,x);
% 
% for i = 5*fs+1:b-5*fs-1     %ȡǰ����
% junfangcha=std(x((i-2.5*fs) : (i+2.5*fs)));
% if x(i)>1.5*junfangcha
%     x(i)=x(i)/5;
% end
% end
% 
% x=x(5*fs+1:b+5*fs);
% figure(4)
% t=0.001:0.001:length(x)/1000;
% plot(t,x);
% mm1_highpass = x';
%% С���任
% 
% % С���任 
% [c, l] = wavedec(mm2, 5, 'db4'); % 5��С���ֽ⣬ʹ��db4С�������� 
% approx = wrcoef('a', c, l, 'db4', 5); % �ع�����ϵ�� 
% detail = wrcoef('d', c, l, 'db4', 5); % �ع�ϸ��ϵ��
% 
% % �˲� 
% z = wden(mm2, 'sqtwolog', 'h', 'mln', 10, 'sym8'); % ��ϸ��ϵ����������ֵ�˲� 
% y = mm2-z;
% 
% % ��ͼ 
% subplot(2,1,1); plot(a1, mm2); title('ԭʼ�ź�'); xlabel('ʱ�䣨�룩'); ylabel('��ֵ'); 
% subplot(2,1,2); plot(a1, y); title('�˲����ź�'); xlabel('ʱ�䣨�룩'); ylabel('��ֵ');
% 

%% ��ͨ+��ͨ
% 
% mm1_highpass=filter(lvboqi15,mm1);%��ͨ�˲�
% figure(1);
% plot(a1,mm1_highpass);
% hold on;
% plot(a1,mm1);
% title('��ͨ�˲���');
% xlabel('ʱ��/s');
% ylabel('����/V');
% legend('��ͨ�˲���','Դ�ź�');

%% ȥ����ɢ��
% B = filloutliers(mm1_highpass,"center","movmean",10000);
% figure(2)
% plot(a1,B)
%% vmdoyjh
%[mm1_highpass_extend,mm1Begin,mm1End]=edge_extend(mm1_highpass);
imf=VMD_display(mm1_highpass,1000,5);
signal=imf(5,:)';

%% ϣ�����������
mm1_highpass_outliers_hilbert=abs(hilbert(signal));%�����
figure(100); 
plot(a1,mm1_highpass_outliers_hilbert);
hold on;
plot(a1,signal);
hold on;
title('ϣ�����������');
xlabel('ʱ��/s');
ylabel('����/V');
legend('����','Դ�ź�');
%% ��ͨ�˲���
mm1_highpass_outliers_hilbert_lowpass =filter(lvboqi10,mm1_highpass_outliers_hilbert);%���������ͨ
figure(10000);
plot(a1,signal);
hold on;
plot(a1,mm1_highpass_outliers_hilbert_lowpass);
hold on
title('ϣ�����������');
xlabel('ʱ��/s');
ylabel('����/V');
legend('Դ�ź�','����');

%% ��һ���Ƚ�
figure(600)

a1=(1/fs:1/fs:(b-29999)/fs);%����x��

plot(a1,(nn1(30000:b)-0.46)/(max((nn1(30000:b)-0.46))));%�����һ��
hold on;
plot(a1,mm1_highpass_outliers_hilbert_lowpass(30000:b)/max(mm1_highpass_outliers_hilbert_lowpass(30000:b)));
hold on;
title('��һ���Ƚ�');
xlabel('ʱ��/s');
ylabel('����/V');
legend('����','��ĥ');
%% ������Ŵ���бȽ�
% figure(300);
% plot(a1,mm1_highpass_outliers_hilbert_lowpass/max(mm1_highpass_outliers_hilbert_lowpass));
% LIA();
% 
% toc