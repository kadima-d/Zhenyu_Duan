%% ±´Èû¶ûÂË²¨Æ÷Éè¼Æ
[b,a] = besself(10,0.5,'low');%½×Êı£¬½ØÖ¹ÆµÂÊ
[num,den] = bilinear(b,a,0.5);
%%  signalå‚è?ä¿¡å·
% ä¸‰è¦ç´?
A=1;                %amplify
fs=1000;            %caiyanglv
f=10;               %Hz
w=2*pi*f;           %rad/s
p=0;                %rad
%é‡‡æ ·

T=10;                %s        %è§‚æµ‹æ—¶é—´

d=1/fs;             %s        %é‡‡æ ·é—´éš”

t= d:d:T;       %ç¦»æ•£æ—¶é—´t
s1=A*sin(w*t+p)+2;    %
%% s1
figure(1);
plot(t,filter(num,den,s1));
figure(2);
plot(t,s1);