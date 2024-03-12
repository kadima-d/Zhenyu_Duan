function displayFFT_D(fsInput,signal)
fs=fsInput;%������
T = 1/fs;%������֮��ľ���
%�����ֱ�Ϊ��ʼ�����кͿ�ʼ������
%data=csvread('18-16-28.csv',0,0);%csvreadֻ�ܶ�ȡ������
data1=load(signal);

x1= data1(:,1);% ȡ��n����Ƶ��
%y1= data1(:,2);
%x2= data1(:,3);
%y2= data1(:,4);

b=length(x1);%���ݲ�������
Y2=fft(x1);%��FFT
P2=abs(Y2/b);
P1 = P2(1:b/2+1);%������?
P1(2:end-1) = 2*P1(2:end-1);%����P1��ֱ��
f = fs*(0:(b/2))/b;%����Ƶ��Fs��ֻ��fs/2���ź�
P3=20*log10(P1);

figure;
plot(f,P1) ;
title('Ƶ��')
xlabel("f/Hz")
ylabel("����")
grid on
% 
% figure
% P1log=20*log10(P1);
% plot(f,P1log);
% title('���������Ƶ��')
% xlabel("f/Hz")
% ylabel("����")
% grid on;
% 
% figure
% 
% %semilogx(f,P1log);
% %flog=log10(f);
% plot(f,P1) ;
% set(gca,'XScale','log') 
% title('���������Ƶ��')
% xlabel("f/Hz")
% ylabel("����")
% grid on;

figure
loglog(f,20*P1,'k');
title('ʵ�������ȥ���Ƶ��')
xlabel("f/Hz")
ylabel("����/dB")
grid on;
axes('position',[0.65,0.7,0.2,0.2]);%�ֲ��Ŵ�ͼλ��
%axis([2213 2280 0.205 0.245]);%���귶Χ����
loglog(f,P1,'k');
% figure(1);%��һ��ͼ
% plot(x1,y1);
% hold on;
% plot(x2,y2);
% 
% figure(2);%�ڶ���ͼ
% plot(x1,y1);
% 
% figure(3);%������ͼ
% plot(x2,y2);