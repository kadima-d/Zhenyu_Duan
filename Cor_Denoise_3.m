function Cor_Denoise_3(signal,windowlength,lengthh)
% 需要开机自启时间
% xn1为输入信号，列向量
% windowlength为截取窗长,一般设置成100
% lengthh为滤波器长度，一般不超过10
%改：signal为信号名字，从信号中提取出来需要处理的列
data1=load(signal);
promptx='对哪列信号进行相关去噪：';
m1=input(promptx);
xn1= data1(:,m1);


dc=zeros(1,300)+xn1(1)+1*randn(1,300);
dc=dc';
xn11(1:length(dc))=dc;
xn11(length(dc)+1:length(dc)+length(xn1))=xn1;
xn11=xn11';
lengthxn11=length(xn11);
hn=zeros(1,lengthh);
miu=0.1*2/sum(xn11(1:windowlength).*xn11(1:windowlength));  %开机自启步长
dn=xn11(1:lengthxn11-1,:);     %构建参考信号列向量，即原始信号去除最后一点，不移位
xn=xn11(2:lengthxn11,:);       %构建输入信号列向量，即原始信号右移一位后的信号

for i_B=1:length(xn)-lengthh+1
    if i_B<windowlength
        an_B=flipud(xn(i_B:i_B+lengthh-1));       %将输入信号向量的片段进行倒置，仍为列向量
        yn_B(i_B)=hn*an_B;                      %移动第i次滤波器的输出
        e_B(i_B)=dn(i_B)-yn_B(i_B);                 %移动第i次循环误差能量
        hn=hn+miu*e_B(i_B)*an_B';       %移动第i+1次时滤波器系数
    else
        an_B=flipud(xn(i_B:i_B+lengthh-1));       %将输入信号向量的片段进行倒置，仍为列向量
        sinaljq1=xn(i_B+1-windowlength:i_B);
        stepturn(i_B)=0.5*2/sum(sinaljq1.*sinaljq1);       %新步长
        yn_B(i_B)=hn*an_B;                     
        e_B(i_B)=dn(i_B)-yn_B(i_B);                 
        hn=hn+0.2*stepturn(i_B)*e_B(i_B)*an_B';       
    end
    
end

figure;
hold on
plot(dn(length(dc)+1:end),'linewidth',1);
plot(yn_B(length(dc)+1:end),'linewidth',1);


legend('输入信号','输出信号');
xlabel('点数');
ylabel('幅度');
axes('position',[0.2,0.7,0.2,0.2]);%局部放大图位置
% %axis([2213 2280 0.205 0.245]);%坐标范围设置
plot(dn(length(dc)+1:end));
hold on;
plot(yn_B(length(dc)+1:end),'linewidth',1);

%set(gca,'FontSize',18,'FontWeight','bold','FontName','宋体');
%set(gca,'linewidth',1);
%set(gca,'Box','on');


promptx='设置写出文件的文件名：';
m1=input(promptx,'s');
csvwrite(m1,(yn_B(length(dc)+1:end))');

end