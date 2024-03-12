function f_n = xden(f,n,wf)
%相关性去噪法
%输入参数：f为带噪信号，n为分解层数，wf为小波函数名称
%返回函数f_n为去噪信号
[Lo_D,Hi_D,Lo_R,Hi_R]=wfilters(wf);
[swa,swd]=swt(f,n,Lo_D,Hi_D);%swd是细节系数，swa是近似系数
ss =swd;
s1=swd;
T=zeros(size(ss));
%先把系数处理矩阵设置为全0
%在1:n-1分解层次上对高频系数处理，最后一层无法求相关系数，所以不作处理
for j=1:n-1
    cw=s1(j,:).*s1(j+1,:);%定义相关系数为相邻两层的乘积
    pw=sum(abs(swd(j,:)).^2);%计算小波能量
    pcw=sum(abs(cw).^2);%计算相关系数能量
    w_n=cw.*((pw/pcw)^0.5);%归一化
    
    
    acw=abs(w_n);
    aw=abs(swd(j,:));
    ss=swd(j,:).*(acw>aw);%(acw>aw)返回0或者1,1为信号，0为噪声
    ss1=(ss~=0);%将选出的点赋给系数处理矩阵相应位置
end
mask_max=ones(1,length(T));
T=[T((1:(n-1)),:);mask_max];%最后一层系数处理矩阵全置1
s1=s1.*T;
f_n=iswt(swa,s1,wf);
end