fs=1000;%������
T = 1/fs;%������֮��ľ���
data1=load('09-27-57-Cor_Denoise.csv');
data2=load('09-27-57-source-CorDenoise.csv');
data3=load('09-27-57.csv');
b=length(data1);%�����鳤��
a1=(1/fs:1/fs:b/fs);%����x��
mm1= data1(:,1);%��ĥ
nn1= data2(:,1);%����
oo1=data3(:,2);
pp1=data3(:,4);
%% ϣ�����ر任�����

% result=200*filter(n10Lowpass,abs(hilbert(filter(highpass2,(mm1)))));
% plot(a1,result);
% hold on;
% 
% preresult=filter(n10Lowpass,abs(hilbert(filter(highpass2,(mm1)))));
% plot(a1,filter(n10Lowpass,abs(hilbert(filter(highpass2,(mm1))))));
% hold on;
% plot(a1,nn1/(max(nn1)));%�����һ��
% hold on;
% 
% plot(a1,filter(highpass2,(mm1)));
% hold on;
%% ��ͨ+��ͨ
mm1_highpass=filter(lvboqi13,(filter(lvboqi12,mm1)));%��ͨ�˲�
figure(1);
plot(a1,mm1_highpass);
hold on;
plot(a1,mm1);
title('��ͨ�˲���');
xlabel('ʱ��/s');
ylabel('����/V');
legend('��ͨ�˲���','Դ�ź�');
%% ȥ����
%�����Ⱥֵ������������Ʊ�׼��Ĵ�С��������ȥ���������
B = filloutliers(mm1_highpass,"spline","movmedian",10000);
figure(2)
plot(a1,B)
%���ź���Ч����С�ź�Ч��������
%plot(a1,filloutliers(mm1_highpass,'previous','quartiles'));%�ڶ���
% mm1_highpass_outliers=filloutliers(mm1_highpass,'previous','quartiles');%ȥ����Ⱥ��
% figure(2);
% plot(a1,mm1_highpass_outliers);
% title('ȥ����Ⱥ���');

%ԭʼ����͸�ͨ��ĶԱ�
%% ϣ�����������
mm1_highpass_outliers_hilbert=abs(hilbert(B));%�����
figure(3); 
plot(a1,mm1_highpass_outliers_hilbert);
title('����');
hold on;
plot(a1,mm1_highpass);
hold on;
title('��ͨ�˲���');
xlabel('ʱ��/s');
ylabel('����/V');
legend('����','Դ�ź�');

%ԭʼ�����ͨ��͸�ͨ��ĶԱ�
mm1_highpass_outliers_hilbert_lowpass =filter(lvboqi10,mm1_highpass_outliers_hilbert);%���������ͨ
figure(4);
plot(a1,mm1_highpass);
hold on;
plot(a1,mm1_highpass_outliers_hilbert_lowpass);
hold on
%��һ���Ƚ�

figure(5)
plot(a1,filloutliers(mm1_highpass_outliers_hilbert_lowpass,0.004)/0.004);
hold on;
plot(a1,nn1/(max(nn1)));%�����һ��
hold on;
title('��һ���Ƚ�');
xlabel('ʱ��/s');
ylabel('����/V');
legend('��ĥ','����');
% plot(a1,filter(n10Lowpass,abs(hilbert(mm1_highpass)))/0.006);
% hold on;
% plot(a1,nn1/(max(nn1)));
% hold on;
%������
%plot(a1,filloutliers(mm1_highpass,'previous','mean'));%�ڶ���
%������
%plot(a1,filloutliers(mm1_highpass,'previous','movmedian',3000));%���ĸ�
%������������
%plot(a1,filloutliers(mm1_highpass,'previous',"percentiles",[10 90]));%������

%����ƽ���㷨��ÿn����ȡƽ��ֵ,�ò���
% plot(a1,movmean(mm1,5));%����Ĳ���Ϊ���ڳ���
% hold on;
%% �ڶ��ֳ��� ��FFTȥֱ��
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

%% �����ֳ��� ֱ��������Ŵ���

%% �����ֳ��ԣ����ü���Сֵ�������
% [K1,V1]=findpeaks(filter(highpass2,(mm1)),'MinPeakWidth',800); % �󼫴�ֵλ�úͷ�ֵ
% up=spline(K1,V1,b);          % �ڲ�,��ȡ�ϰ�������
% [K2,V2]=findpeaks(filter(highpass2,(mm1)),'MinPeakWidth',800);% ��Сֵλ�úͷ�ֵ
% down=spline(K2,V2,b);        % �ڲ�,��ȡ�°�������
% figure(4)
% plot(a1,up);
% hold on;
% plot(a1,down);
% hold on;
% plot(a1,filter(highpass2,(mm1)));
% hold on;

 %% �����ֳ��ԣ�����envelope��ֵ
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
