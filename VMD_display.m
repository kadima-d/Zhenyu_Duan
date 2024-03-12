function [imf]=VMD_display(varargin)
%%此函数功能为对信号进行VMD，对分解结果进行希尔伯特变换并绘制各个分量的时域波形图，
%%时间-瞬时频率图，时间-瞬时能量图
%%输入参数说明：x(待分解信号）,fs(采样频率）,NumofImf(VMD结果分量数）,begin_t(绘图时起始点数值),
% end_t(绘图时终止点数值)
% x和fs必须输入,NumofImf默认为5，
% begin_t默认为1，end_t默认为x的长度值
if nargin~=2&&nargin~=3&&nargin~=4&&nargin~=5
    disp('请按规定输入参数')
    return
end

x=varargin{1};
fs=varargin{2};
NumofImf=5;
begin_t=1;
end_t=length(x);

if nargin==3
    NumofImf=varargin{3};
end

if nargin==4
    begin_t=varargin{3};
    end_t=varargin{4};
end

if nargin==5
    NumofImf=varargin{3}; 
    begin_t=varargin{4};
    end_t=varargin{5};
end


[imf,residual,info]=vmd(x,'NumIMF',NumofImf,'LMUpdateRate',0.01);
imf=imf';

for k=1:size(imf,1)
[hs,insf,t,imfinsf,imfinse]=hht(imf(k,:),fs);
Imf_E(k,:)=imfinse;
Imf_f(k,:)=imfinsf;
figure
subplot(311)
plot(t(begin_t:end_t),imf(k,begin_t:end_t))
title(['imf',num2str(k)])
xlabel('采样序列值')
ylabel('幅值')
subplot(312)
plot(t(begin_t:end_t),abs(imfinsf(begin_t:end_t)))
xlabel('时间/ s')
ylabel('瞬时频率/Hz')
title(['分量',num2str(k),'的瞬时频率分布'])
subplot(313)
plot(t(begin_t:end_t),imfinse(begin_t:end_t))
xlabel('时间/ s')
ylabel('瞬时能量')
title(['分量',num2str(k),'的能量分布'])
end


end

