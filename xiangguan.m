y = wgn(1,10000,1); %产生一个m行n列的高斯白噪声的矩阵，p以dBW为单位指定输出噪声的强度
R = corrcoef(y,y);
x = wgn(1,10000,1);
R2 = corrcoef(x,y);

y_yiwei=[y(10000),y(1,1:9999)];
R3 = corrcoef(y_yiwei,y);
R4=xcorr(x,y,"unbiased");

lpFilt2 = designfilt('lowpassiir','FilterOrder',2, ...
         'PassbandFrequency',10,'PassbandRipple',0.1, ...
         'SampleRate',1000);
y_LowPass=filtfilt(lpFilt2,y);
figure
plot(y_LowPass);
title('白噪声滤波');
y_LowPass_yiwei=[y_LowPass(10000),y_LowPass(1,1:9999)];
R10 = corrcoef(y_LowPass,y_LowPass_yiwei);

fs = 100000;
ts = 1/fs;
t=0:ts:0.3;
z = sin(2*pi*10*t) + sin(2*pi*100*t)+sin(2*pi*t);
z_yiwei=[z(30001),z(1,1:30000)];
R5 = corrcoef(z_yiwei,z);