%fsInput为采样率，signal为信号文件名，n为需要处理的�?
function LIA_2(fsInput,signal,n)
%% 读取文件
data1=load(signal);
b=length(data1);%求数组长�?
data2= data1(:,n);%读取第n列的数据
data=filter(IIR_40hz,data2');
fs=fsInput;            %Hz       %采样频率

%%  signal参�?信号
% 三要�?
A=1;                %amplify

promptx='������Ҫ��������Ƶ��';
fRef=input(promptx);

f=fRef;               %Hz
w=2*pi*f;           %rad/s
p=0;                %rad
%采样

T=b/fs;                %s        %观测时间

d=1/fs;             %s        %采样间隔

t= d:d:T;       %离散时间t
s1=A*sin(w*t+p);    %参�?信号
s2=A*cos(w*t+p);    %参�?信号+90°


                         
  

%% �������˲������
%[b,a] = besself(10,0.5,'low');%��������ֹƵ��
%[num,den] = bilinear(b,a,0.5);

%% 锁相放大
out1=(2.6212767171*2*filter(zuixiaoercheng3,(data.*s1))).*(2.6212767171*2*filter(zuixiaoercheng3,(data.*s1)));%滤波后的�?��输出
out2=(2.6212767171*2*filter(zuixiaoercheng3,(data.*s2))).*(2.6212767171*2*filter(zuixiaoercheng3,(data.*s2)));%滤波后的二路输出

% %% ����
% figure(1)
% shabi2=data.*s1;
% plot(t,shabi2);
% 
% figure(2)
% shabi=filter(Filter_IIR,(data.*s1));
% plot(t,shabi);
%%
result=sqrt((out1)+(out2));
figure(2);
subplot(2,1,1);
plot(t,data2);
xlabel('ʱ��/s');
ylabel('����/V');
title("Դ�ź�")

subplot(2,1,2);
plot(t,result);
xlabel('ʱ��/s');
ylabel('����/V');
title("����Ŵ������")

%% �ԱȽ���������ã�
figure(3)
sourece=load('09-27-57-source-CorDenoise.csv');
plot(t,sourece/(max(sourece)));
hold on;
plot(t,result/(max(result)));
