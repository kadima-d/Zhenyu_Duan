%fsInputΪ�����źŵĲ����ʣ�signalΪ�źŵ�ַ��nΪ��Ҫ��ʾ���ź�����
%������
function displayTime_DTest(fsInput,signal,n)
fs=fsInput;%������
T = 1/fs;%������֮��ľ���
%�����ֱ�Ϊ��ʼ�����кͿ�ʼ������
%data=csvread('18-16-28.csv',0,0);%csvreadֻ�ܶ�ȡ������
data1=load(signal);
b=length(data1);%�����鳤��
    promptx='���������е����ϵ����';
    m1=input(promptx);
    prompty='�ڶ��У�';
    n1=input(prompty);
    
mm1= data1(:,m1);
nn1= data1(:,n1);
R = corrcoef(mm1, nn1);
disp('���ϵ������Ϊ');
disp(R);%��i�е�j�е����ݱ���Ϊ����R��i�к͵�j�е������


if(n==1)
    promptx='x���ڵڼ���(0���ʾ�Զ�����x��)��';
    x1=input(promptx);
if(x1==0)
a1=(1/fs:1/fs:b/fs);
end
    prompty='�ź��ڵڼ��У�';
    y1=input(prompty);
    %aΪx��bΪy
if(x1~=0)
a1= data1(:,x1);
end
b1= data1(:,y1);
figure(1);%��һ��ͼ
plot(a1,b1);
title('ʱ��ͼ')
xlabel("ʱ��/s")
ylabel("����/V")
hold on;
plot(a1,filter(highpass2,(b1)));
hold on;
%plot(a1,abs(hilbert(filter(highpass2,(b1)))));
%hold on;
plot(a1,filter(n10Lowpass,abs(hilbert(filter(highpass2,(b1))))));%�й��壬��������
% Ŀǰ�ĸ�ͨ�˲�����ֻ������IIR��FIRû����ô�õ�����
%plot(a1,filter(n10Lowpass,abs(hilbert(filter(highpass2,(b1))))));%�й��壬��������
hold on;
end

if(n==2)
    promptx='x���ڵڼ���(0���ʾ�Զ�����x��)��';
    x1=input(promptx);
if(x1==0)
a1=(1/fs:1/fs:b/fs);
end
    prompty1='��һ���ź��ڵڼ��У�';
    y1=input(prompty1);
    prompty1='���ź�ͼ����';
    infoy1=input(prompty1,'s');
    prompty1='�ڶ����ź��ڵڼ��У�';
    y2=input(prompty1);
    prompty1='���ź�ͼ����';
    infoy2=input(prompty1,'s');
    %aΪx��bΪy
if(x1~=0)
a1= data1(:,x1);
end
b1= data1(:,y1);
b2= data1(:,y2);

figure(1);%��һ��ͼ
plot(a1,b1);
hold on;
plot(a1,b2);
legend(infoy1,infoy2);
title('ʱ��ͼ')
xlabel("ʱ��/s")
ylabel("����/V")
figure(2);%��һ��ͼ
plot(a1,b1);
title('ʱ��ͼ')
xlabel("ʱ��/s")
ylabel("����/V")
legend(infoy1);
figure(3);%��һ��ͼ
plot(a1,b2);
title('ʱ��ͼ')
xlabel("ʱ��/s")
ylabel("����/V")
legend(infoy2);
end

if(n==3)
    promptx='x���ڵڼ���(0���ʾ�Զ�����x��)��';
    x1=input(promptx);
if(x1==0)
a1=(1/fs:1/fs:b/fs);
end
    prompty1='��һ���ź��ڵڼ��У�';
    y1=input(prompty1);
        prompty1='���ź�ͼ����';
    infoy1=input(prompty1,'s');
    prompty1='�ڶ����ź��ڵڼ��У�';
    y2=input(prompty1);
        prompty1='���ź�ͼ����';
    infoy2=input(prompty1,'s');
    prompty1='�������ź��ڵڼ��У�';
    y3=input(prompty1);
        prompty1='���ź�ͼ����';
    infoy3=input(prompty1,'s');
    %aΪx��bΪy
if(x1~=0)
a1= data1(:,x1);
end
b1= data1(:,y1);
b2= data1(:,y2);
b3= data1(:,y3);
figure(1);%��һ��ͼ
plot(a1,b1);
hold on;
plot(a1,b2);
hold on;
plot(a1,b3);
title('ʱ��ͼ')
xlabel("ʱ��/s")
ylabel("����/V")
legend(infoy1,infoy2,infoy3);
figure(2);%��һ��ͼ
plot(a1,b1);
title('ʱ��ͼ')
xlabel("ʱ��/s")
ylabel("����/V")
legend(infoy1);
figure(3);%�ڶ���ͼ
plot(a1,b2);
title('ʱ��ͼ')
xlabel("ʱ��/s")
ylabel("����/V")
legend(infoy2);
figure(4);%������ͼ
plot(a1,b3);
title('ʱ��ͼ')
xlabel("ʱ��/s")
ylabel("����/V")
legend(infoy3);
end

if(n==4)
    promptx='x���ڵڼ���(0���ʾ�Զ�����x��)��';
    x1=input(promptx);
if(x1==0)
a1=(1/fs:1/fs:b/fs);
end
    prompty1='��һ���ź��ڵڼ��У�';
    y1=input(prompty1);
            prompty1='���ź�ͼ����';
    infoy1=input(prompty1,'s');
    prompty1='�ڶ����ź��ڵڼ��У�';
    y2=input(prompty1);
            prompty1='���ź�ͼ����';
    infoy2=input(prompty1,'s');
    prompty1='�������ź��ڵڼ��У�';
    y3=input(prompty1);
            prompty1='���ź�ͼ����';
    infoy3=input(prompty1,'s');
    prompty1='���ĸ��ź��ڵڼ��У�';
    y4=input(prompty1);
            prompty1='���ź�ͼ����';
    infoy4=input(prompty1,'s');
    %aΪx��bΪy
if(x1~=0)
a1= data1(:,x1);
end
b1= data1(:,y1);
b2= data1(:,y2);
b3= data1(:,y3);
b4= data1(:,y4);
figure(1);%��һ��ͼ
plot(a1,b1);
hold on;
plot(a1,b2);
hold on;
plot(a1,b3);
hold on;
plot(a1,b4);
title('ʱ��ͼ')
xlabel("ʱ��/s")
ylabel("����/V")
legend(infoy1,infoy2,infoy3,infoy4);
figure(2);%��һ��ͼ
plot(a1,b1);
title('ʱ��ͼ')
xlabel("ʱ��/s")
ylabel("����/V")
legend(infoy1);
figure(3);%�ڶ���ͼ
plot(a1,b2);
title('ʱ��ͼ')
xlabel("ʱ��/s")
ylabel("����/V")
legend(infoy2);
figure(4);%������ͼ
plot(a1,b3);
title('ʱ��ͼ')
xlabel("ʱ��/s")
ylabel("����/V")
legend(infoy3);
figure(5);%������ͼ
plot(a1,b4);
title('ʱ��ͼ')
xlabel("ʱ��/s")
ylabel("����/V")
legend(infoy4);
end

if(n==5)
    promptx='x���ڵڼ���(0���ʾ�Զ�����x��)��';
    x1=input(promptx);
if(x1==0)
a1=(1/fs:1/fs:b/fs);
end
    prompty1='��һ���ź��ڵڼ��У�';
    y1=input(prompty1);
                prompty1='���ź�ͼ����';
    infoy1=input(prompty1,'s');
    prompty1='�ڶ����ź��ڵڼ��У�';
    y2=input(prompty1);
                prompty1='���ź�ͼ����';
    infoy2=input(prompty1,'s');
    prompty1='�������ź��ڵڼ��У�';
    y3=input(prompty1);
                prompty1='���ź�ͼ����';
    infoy3=input(prompty1,'s');
    prompty1='���ĸ��ź��ڵڼ��У�';
    y4=input(prompty1);
                prompty1='���ź�ͼ����';
    infoy4=input(prompty1,'s');
    prompty1='������ź��ڵڼ��У�';
    y5=input(prompty1);
                prompty1='���ź�ͼ����';
    infoy5=input(prompty1,'s');
    %aΪx��bΪy
if(x1~=0)
a1= data1(:,x1);
end
b1= data1(:,y1);
b2= data1(:,y2);
b3= data1(:,y3);
b4= data1(:,y4);
b5= data1(:,y5);
figure(1);%��һ��ͼ
plot(a1,b1);
hold on;
plot(a1,b2);
hold on;
plot(a1,b3);
hold on;
plot(a1,b4);
hold on;
plot(a1,b5);
title('ʱ��ͼ')
xlabel("ʱ��/s")
ylabel("����/V")
legend(infoy1,infoy2,infoy3,infoy4,infoy5);
figure(2);%��һ��ͼ
plot(a1,b1);
title('ʱ��ͼ')
xlabel("ʱ��/s")
ylabel("����/V")
legend(infoy1);
figure(3);%�ڶ���ͼ
plot(a1,b2);
title('ʱ��ͼ')
xlabel("ʱ��/s")
ylabel("����/V")
legend(infoy2);
figure(4);%������ͼ
plot(a1,b3);
title('ʱ��ͼ')
xlabel("ʱ��/s")
ylabel("����/V")
legend(infoy3);
figure(5);%������ͼ
plot(a1,b4);
title('ʱ��ͼ')
xlabel("ʱ��/s")
ylabel("����/V")
legend(infoy4);
figure(6)
plot(a1,b5);
title('ʱ��ͼ')
xlabel("ʱ��/s")
ylabel("����/V")
legend(infoy5);
end




% ԭʼ�ź���ʾģ��
% x1= data1(:,1);
% y1= data1(:,2);
% x2= data1(:,3);
% y2= data1(:,4);
% R = corrcoef(y1, y2);
% disp('���ϵ������Ϊ');
% disp(R);%��i�е�j�е����ݱ���Ϊ����R��i�к͵�j�е������
% figure(1);%��һ��ͼ
% plot(x1,y1);
% hold on;
% plot(x2,y2);
% title('ʱ��ͼ')
% xlabel("ʱ��/s")
% ylabel("����/V")
% figure(2);%�ڶ���ͼ
% plot(x1,y1);
% title('ʱ��ͼ')
% xlabel("ʱ��/s")
% ylabel("����/V")
% figure(3);%������ͼ
% plot(x2,y2);
% title('ʱ��ͼ')
% xlabel("ʱ��/s")
% ylabel("����/V")

%���ȥ��
% lev=4;%С���ֽ����
% wf='db3';
% s=xden(y2,lev,wf);
% %P=psnr(y2,s);
% %m=mse(y2,s);
% figure(4)
% plot(x2,s);
% title('���ȥ��')
% xlabel("ʱ��/s")
% ylabel("����/V")


% b=length(dataReverse);%求数组长�?
% %dataoff=dataRverse-mean(dataReverse);
% t=(0:b-1)*T;
% x=(1/fs:1/fs:b/fs);%�?/f,1/f,b/f�?
% figure;
% plot(x,dataReverse);
% title('时域波形')%说明信息
% 
% xlabel("Time(s)"); %设置X轴标�?
% ylabel("Voltage(V)"); %设置Y轴标�?
% hold on;