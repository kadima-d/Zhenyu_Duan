%fsInput涓洪噰鏍风巼锛宻ignal涓轰俊鍙锋枃浠跺悕锛宯涓洪渶瑕佸鐞嗙殑鍒?
function LIA(fsInput,signal,n)
%% 璇诲彇鏂囦欢
data1=load(signal);
b=length(data1);%姹傛暟缁勯暱搴?
data2= data1(:,n);%璇诲彇绗琻鍒楃殑鏁版嵁
data=data2';
fs=fsInput;            %Hz       %閲囨牱棰戠巼

%%  signal鍙傝?淇″彿
% 涓夎绱?
A=1;                %amplify

promptx='输入需要被锁定的频率';
fRef=input(promptx);

f=fRef;               %Hz
w=2*pi*f;           %rad/s
p=0;                %rad
%閲囨牱

T=b/fs;                %s        %瑙傛祴鏃堕棿

d=1/fs;             %s        %閲囨牱闂撮殧

t= d:d:T;       %绂绘暎鏃堕棿t
s1=A*sin(w*t+p);    %鍙傝?淇″彿
s2=A*cos(w*t+p);    %鍙傝?淇″彿+90掳


                         
  
%% 閿佺浉鏀惧ぇ
out1=(2*filter(Filter_IIR,(data.*s1))).*(2*filter(Filter_IIR,(data.*s1)));%婊ゆ尝鍚庣殑涓?矾杈撳嚭
out2=(2*filter(Filter_IIR,(data.*s2))).*(2*filter(Filter_IIR,(data.*s2)));%婊ゆ尝鍚庣殑浜岃矾杈撳嚭

% %% 测试
% figure(1)
% shabi2=data.*s1;
% plot(t,shabi2);
% 
% figure(2)
% shabi=filter(Filter_IIR,(data.*s1));
% plot(t,shabi);
%%
result=sqrt((out1)+(out2));
figure(1);
subplot(2,1,1);
plot(t,data2);
xlabel('时间/s');
ylabel('幅度/V');
title("源信号")

subplot(2,1,2);
plot(t,result);
xlabel('时间/s');
ylabel('幅度/V');
title("锁相放大后的输出")
