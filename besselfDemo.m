%% �������˲������
[b,a] = besself(10,0.5,'low');%��������ֹƵ��
[num,den] = bilinear(b,a,0.5);
%%  signal参�?信号
% 三要�?
A=1;                %amplify
fs=1000;            %caiyanglv
f=10;               %Hz
w=2*pi*f;           %rad/s
p=0;                %rad
%采样

T=10;                %s        %观测时间

d=1/fs;             %s        %采样间隔

t= d:d:T;       %离散时间t
s1=A*sin(w*t+p)+2;    %
%% s1
figure(1);
plot(t,filter(num,den,s1));
figure(2);
plot(t,s1);