%fsInput为输入信号的采样率，signal为信号地址，n为需要显示的信号数量
%测试用
function displayTime_DTest(fsInput,signal,n)
fs=fsInput;%采样率
T = 1/fs;%两个点之间的距离
%参数分别为开始读的行和开始读的列
%data=csvread('18-16-28.csv',0,0);%csvread只能读取纯数据
data1=load(signal);
b=length(data1);%求数组长度
    promptx='计算哪两列的相关系数：';
    m1=input(promptx);
    prompty='第二列：';
    n1=input(prompty);
    
mm1= data1(:,m1);
nn1= data1(:,n1);
R = corrcoef(mm1, nn1);
disp('相关系数矩阵为');
disp(R);%第i行第j列的数据表明为矩阵R第i列和第j列的相关性


if(n==1)
    promptx='x轴在第几列(0则表示自动生成x轴)：';
    x1=input(promptx);
if(x1==0)
a1=(1/fs:1/fs:b/fs);
end
    prompty='信号在第几列：';
    y1=input(prompty);
    %a为x，b为y
if(x1~=0)
a1= data1(:,x1);
end
b1= data1(:,y1);
figure(1);%第一个图
plot(a1,b1);
title('时域图')
xlabel("时间/s")
ylabel("幅度/V")
hold on;
plot(a1,filter(highpass2,(b1)));
hold on;
%plot(a1,abs(hilbert(filter(highpass2,(b1)))));
%hold on;
plot(a1,filter(n10Lowpass,abs(hilbert(filter(highpass2,(b1))))));%有过冲，其他良好
% 目前的高通滤波器，只能利用IIR，FIR没有这么好的性能
%plot(a1,filter(n10Lowpass,abs(hilbert(filter(highpass2,(b1))))));%有过冲，其他良好
hold on;
end

if(n==2)
    promptx='x轴在第几列(0则表示自动生成x轴)：';
    x1=input(promptx);
if(x1==0)
a1=(1/fs:1/fs:b/fs);
end
    prompty1='第一个信号在第几列：';
    y1=input(prompty1);
    prompty1='此信号图例：';
    infoy1=input(prompty1,'s');
    prompty1='第二个信号在第几列：';
    y2=input(prompty1);
    prompty1='此信号图例：';
    infoy2=input(prompty1,'s');
    %a为x，b为y
if(x1~=0)
a1= data1(:,x1);
end
b1= data1(:,y1);
b2= data1(:,y2);

figure(1);%第一个图
plot(a1,b1);
hold on;
plot(a1,b2);
legend(infoy1,infoy2);
title('时域图')
xlabel("时间/s")
ylabel("幅度/V")
figure(2);%第一个图
plot(a1,b1);
title('时域图')
xlabel("时间/s")
ylabel("幅度/V")
legend(infoy1);
figure(3);%第一个图
plot(a1,b2);
title('时域图')
xlabel("时间/s")
ylabel("幅度/V")
legend(infoy2);
end

if(n==3)
    promptx='x轴在第几列(0则表示自动生成x轴)：';
    x1=input(promptx);
if(x1==0)
a1=(1/fs:1/fs:b/fs);
end
    prompty1='第一个信号在第几列：';
    y1=input(prompty1);
        prompty1='此信号图例：';
    infoy1=input(prompty1,'s');
    prompty1='第二个信号在第几列：';
    y2=input(prompty1);
        prompty1='此信号图例：';
    infoy2=input(prompty1,'s');
    prompty1='第三个信号在第几列：';
    y3=input(prompty1);
        prompty1='此信号图例：';
    infoy3=input(prompty1,'s');
    %a为x，b为y
if(x1~=0)
a1= data1(:,x1);
end
b1= data1(:,y1);
b2= data1(:,y2);
b3= data1(:,y3);
figure(1);%第一个图
plot(a1,b1);
hold on;
plot(a1,b2);
hold on;
plot(a1,b3);
title('时域图')
xlabel("时间/s")
ylabel("幅度/V")
legend(infoy1,infoy2,infoy3);
figure(2);%第一个图
plot(a1,b1);
title('时域图')
xlabel("时间/s")
ylabel("幅度/V")
legend(infoy1);
figure(3);%第二个图
plot(a1,b2);
title('时域图')
xlabel("时间/s")
ylabel("幅度/V")
legend(infoy2);
figure(4);%第三个图
plot(a1,b3);
title('时域图')
xlabel("时间/s")
ylabel("幅度/V")
legend(infoy3);
end

if(n==4)
    promptx='x轴在第几列(0则表示自动生成x轴)：';
    x1=input(promptx);
if(x1==0)
a1=(1/fs:1/fs:b/fs);
end
    prompty1='第一个信号在第几列：';
    y1=input(prompty1);
            prompty1='此信号图例：';
    infoy1=input(prompty1,'s');
    prompty1='第二个信号在第几列：';
    y2=input(prompty1);
            prompty1='此信号图例：';
    infoy2=input(prompty1,'s');
    prompty1='第三个信号在第几列：';
    y3=input(prompty1);
            prompty1='此信号图例：';
    infoy3=input(prompty1,'s');
    prompty1='第四个信号在第几列：';
    y4=input(prompty1);
            prompty1='此信号图例：';
    infoy4=input(prompty1,'s');
    %a为x，b为y
if(x1~=0)
a1= data1(:,x1);
end
b1= data1(:,y1);
b2= data1(:,y2);
b3= data1(:,y3);
b4= data1(:,y4);
figure(1);%第一个图
plot(a1,b1);
hold on;
plot(a1,b2);
hold on;
plot(a1,b3);
hold on;
plot(a1,b4);
title('时域图')
xlabel("时间/s")
ylabel("幅度/V")
legend(infoy1,infoy2,infoy3,infoy4);
figure(2);%第一个图
plot(a1,b1);
title('时域图')
xlabel("时间/s")
ylabel("幅度/V")
legend(infoy1);
figure(3);%第二个图
plot(a1,b2);
title('时域图')
xlabel("时间/s")
ylabel("幅度/V")
legend(infoy2);
figure(4);%第三个图
plot(a1,b3);
title('时域图')
xlabel("时间/s")
ylabel("幅度/V")
legend(infoy3);
figure(5);%第三个图
plot(a1,b4);
title('时域图')
xlabel("时间/s")
ylabel("幅度/V")
legend(infoy4);
end

if(n==5)
    promptx='x轴在第几列(0则表示自动生成x轴)：';
    x1=input(promptx);
if(x1==0)
a1=(1/fs:1/fs:b/fs);
end
    prompty1='第一个信号在第几列：';
    y1=input(prompty1);
                prompty1='此信号图例：';
    infoy1=input(prompty1,'s');
    prompty1='第二个信号在第几列：';
    y2=input(prompty1);
                prompty1='此信号图例：';
    infoy2=input(prompty1,'s');
    prompty1='第三个信号在第几列：';
    y3=input(prompty1);
                prompty1='此信号图例：';
    infoy3=input(prompty1,'s');
    prompty1='第四个信号在第几列：';
    y4=input(prompty1);
                prompty1='此信号图例：';
    infoy4=input(prompty1,'s');
    prompty1='第五个信号在第几列：';
    y5=input(prompty1);
                prompty1='此信号图例：';
    infoy5=input(prompty1,'s');
    %a为x，b为y
if(x1~=0)
a1= data1(:,x1);
end
b1= data1(:,y1);
b2= data1(:,y2);
b3= data1(:,y3);
b4= data1(:,y4);
b5= data1(:,y5);
figure(1);%第一个图
plot(a1,b1);
hold on;
plot(a1,b2);
hold on;
plot(a1,b3);
hold on;
plot(a1,b4);
hold on;
plot(a1,b5);
title('时域图')
xlabel("时间/s")
ylabel("幅度/V")
legend(infoy1,infoy2,infoy3,infoy4,infoy5);
figure(2);%第一个图
plot(a1,b1);
title('时域图')
xlabel("时间/s")
ylabel("幅度/V")
legend(infoy1);
figure(3);%第二个图
plot(a1,b2);
title('时域图')
xlabel("时间/s")
ylabel("幅度/V")
legend(infoy2);
figure(4);%第三个图
plot(a1,b3);
title('时域图')
xlabel("时间/s")
ylabel("幅度/V")
legend(infoy3);
figure(5);%第三个图
plot(a1,b4);
title('时域图')
xlabel("时间/s")
ylabel("幅度/V")
legend(infoy4);
figure(6)
plot(a1,b5);
title('时域图')
xlabel("时间/s")
ylabel("幅度/V")
legend(infoy5);
end




% 原始信号显示模块
% x1= data1(:,1);
% y1= data1(:,2);
% x2= data1(:,3);
% y2= data1(:,4);
% R = corrcoef(y1, y2);
% disp('相关系数矩阵为');
% disp(R);%第i行第j列的数据表明为矩阵R第i列和第j列的相关性
% figure(1);%第一个图
% plot(x1,y1);
% hold on;
% plot(x2,y2);
% title('时域图')
% xlabel("时间/s")
% ylabel("幅度/V")
% figure(2);%第二个图
% plot(x1,y1);
% title('时域图')
% xlabel("时间/s")
% ylabel("幅度/V")
% figure(3);%第三个图
% plot(x2,y2);
% title('时域图')
% xlabel("时间/s")
% ylabel("幅度/V")

%相关去噪
% lev=4;%小波分解层数
% wf='db3';
% s=xden(y2,lev,wf);
% %P=psnr(y2,s);
% %m=mse(y2,s);
% figure(4)
% plot(x2,s);
% title('相关去噪')
% xlabel("时间/s")
% ylabel("幅度/V")


% b=length(dataReverse);%姹傛暟缁勯暱搴?
% %dataoff=dataRverse-mean(dataReverse);
% t=(0:b-1)*T;
% x=(1/fs:1/fs:b/fs);%锛?/f,1/f,b/f锛?
% figure;
% plot(x,dataReverse);
% title('鏃跺煙娉㈠舰')%璇存槑淇℃伅
% 
% xlabel("Time(s)"); %璁剧疆X杞存爣绛?
% ylabel("Voltage(V)"); %璁剧疆Y杞存爣绛?
% hold on;