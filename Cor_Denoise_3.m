function Cor_Denoise_3(signal,windowlength,lengthh)
% ��Ҫ��������ʱ��
% xn1Ϊ�����źţ�������
% windowlengthΪ��ȡ����,һ�����ó�100
% lengthhΪ�˲������ȣ�һ�㲻����10
%�ģ�signalΪ�ź����֣����ź�����ȡ������Ҫ�������
data1=load(signal);
promptx='�������źŽ������ȥ�룺';
m1=input(promptx);
xn1= data1(:,m1);


dc=zeros(1,300)+xn1(1)+1*randn(1,300);
dc=dc';
xn11(1:length(dc))=dc;
xn11(length(dc)+1:length(dc)+length(xn1))=xn1;
xn11=xn11';
lengthxn11=length(xn11);
hn=zeros(1,lengthh);
miu=0.1*2/sum(xn11(1:windowlength).*xn11(1:windowlength));  %������������
dn=xn11(1:lengthxn11-1,:);     %�����ο��ź�����������ԭʼ�ź�ȥ�����һ�㣬����λ
xn=xn11(2:lengthxn11,:);       %���������ź�����������ԭʼ�ź�����һλ����ź�

for i_B=1:length(xn)-lengthh+1
    if i_B<windowlength
        an_B=flipud(xn(i_B:i_B+lengthh-1));       %�������ź�������Ƭ�ν��е��ã���Ϊ������
        yn_B(i_B)=hn*an_B;                      %�ƶ���i���˲��������
        e_B(i_B)=dn(i_B)-yn_B(i_B);                 %�ƶ���i��ѭ���������
        hn=hn+miu*e_B(i_B)*an_B';       %�ƶ���i+1��ʱ�˲���ϵ��
    else
        an_B=flipud(xn(i_B:i_B+lengthh-1));       %�������ź�������Ƭ�ν��е��ã���Ϊ������
        sinaljq1=xn(i_B+1-windowlength:i_B);
        stepturn(i_B)=0.5*2/sum(sinaljq1.*sinaljq1);       %�²���
        yn_B(i_B)=hn*an_B;                     
        e_B(i_B)=dn(i_B)-yn_B(i_B);                 
        hn=hn+0.2*stepturn(i_B)*e_B(i_B)*an_B';       
    end
    
end

figure;
hold on
plot(dn(length(dc)+1:end),'linewidth',1);
plot(yn_B(length(dc)+1:end),'linewidth',1);


legend('�����ź�','����ź�');
xlabel('����');
ylabel('����');
axes('position',[0.2,0.7,0.2,0.2]);%�ֲ��Ŵ�ͼλ��
% %axis([2213 2280 0.205 0.245]);%���귶Χ����
plot(dn(length(dc)+1:end));
hold on;
plot(yn_B(length(dc)+1:end),'linewidth',1);

%set(gca,'FontSize',18,'FontWeight','bold','FontName','����');
%set(gca,'linewidth',1);
%set(gca,'Box','on');


promptx='����д���ļ����ļ�����';
m1=input(promptx,'s');
csvwrite(m1,(yn_B(length(dc)+1:end))');

end