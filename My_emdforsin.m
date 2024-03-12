clc;clear;close all;
fs=5000;
dt=1/fs;
t0=0:dt:10-dt;
L=50000;
f0=40;
fn1=350;fn2=600;
A0=1;An1=2;An2=2;
dn=A0*sin(2*pi*f0*t0);
noise=An1*noisegeneration(fn1,L,1,1.1);
noise=noise+An2*noisegeneration(fn2,L,2,2.2);
xn=dn+noise;

figure
subplot(211)
plot(dn)
subplot(212)
plot(noise)

imf=emd(xn);
emd_visu(xn,t0,imf)
[A,f,tt] = hhspectrum(imf);
%imf各个分量分别进行希尔伯特变换，然后分别做fft，此处的f是归一化的频率,需乘fs
[E,t,Cenf]=toimage(A,f,tt,49998,5000);  
%合成HHT谱图,第1个49998（固定,信号点数减2）表征时域分辨率，第2个表征频域，可以指定，E为求得的HHT谱
disp_hhs(E,t)%绘制HHT谱图

ff=(0:L-1)/L*fs;
figure
subplot(311)
plot(ff,abs(fft(dn)))
title('有用信号和振动干扰的频谱图')
subplot(312)
plot(ff,abs(fft(noise)))
subplot(313)
plot(ff,abs(fft(xn)))



% bpt=zeros(1,size(E,1));
% for k=1:size(E,1)
%     bpt(k)=sum(E(k,:))/fs;   %HHT谱对时间进行积分得边谱图,为了便于和fft结果比较，长度设为5000
%  end
%  figure
%  plot(Cenf*fs,bpt)
%  xlabel('频率 / Hz')
%  ylabel('幅值')
%  title('边谱图')

for k=1:size(imf,1)
[hs,f,t,imfinsf,imfinse]=hht(imf(k,:),fs);
figure
plot(t,imfinsf)
xlabel('时间/ s')
ylabel('瞬时频率/Hz')
title(['分量',num2str(k),'的瞬时频率分布'])
figure
plot(t,imfinse)
xlabel('时间/ s')
ylabel('瞬时能量')
title(['分量',num2str(k),'的能量分布'])
end

function y=noisegeneration(fn,L,t_begin,t_end)
%产生振动干扰，fn为频率，L为总信号长度，t为干扰出现的起止时间
fs=5000;
dt=1/fs;
noise=zeros(1,L);
t=t_begin+dt:dt:t_end;
nn=t_begin*fs+1:t_end*fs;
noise(nn)=sin(2*pi*fn*t);
y=noise;
end


