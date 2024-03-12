function [y,begin_t,end_t]=edge_extend(x)
%%此函数功能为对待VMD分解的数据进行延拓处理以抑制端点效应，由于延拓后信号长度变长，
%%用begin_t和end_t记录原始信号在延拓后信号对应的起始位置和终点位置(单位为点数n,不是时间s)
L=length(x);
[x_max,t_max]=findpeaks(x);
[x_min,t_min]=findpeaks(-x);
x_min=-x_min;
num_max=length(t_max);
num_min=length(t_min);  %%寻找极大值、极小值和其个数

%%左延拓
%先出现的为极小值
if t_min(1)<t_max(1)
LL=t_min(1)-1;
LR=t_max(1)-t_min(1);
%初始化
x1=x ( (t_min(1)-LL) : (t_min(1)+LR) );
D_0= sum( abs( x1- x( (t_min(2)-LL) : (t_min(2)+LR) ) ) );
D_min=D_0; 
t_match=t_min(2);

%%寻找最佳匹配波形
for i=3:num_min
    if L-t_min(i)>LR
D_i=sum(abs(x1-x((t_min(i)-LL):(t_min(i)+LR))));
if D_i<=D_min&&(t_min(i)-LL)>fix(L/25)
    D_min=D_i;
    t_match=t_min(i);
end
    end
end
y=[x(1:t_match-LL-1),x];
begin_t=t_match-LL;  %%起点用匹配时间点减去左特征波形长度

end

%先出现的为极大值
if t_max(1)<t_min(1)
LL=t_max(1)-1;
LR=t_min(1)-t_max(1);
%初始化
x1=x ( (t_max(1)-LL) : (t_max(1)+LR) ); %%1:t_min(1)
D_0= sum( abs( x1- x( (t_max(2)-LL) : (t_max(2)+LR) ) ) );
D_min=D_0; 
t_match=t_max(2);

%%寻找最佳匹配波形
for i=3:num_max
    if L-t_max(i)>LR
D_i=sum(abs(x1-x((t_max(i)-LL):(t_max(i)+LR))));
if D_i<=D_min&&(t_max(i)-LL)>fix(L/25)
    D_min=D_i;
    t_match=t_max(i);
end
    end
end
y=[x(1:t_match-LL-1),x];
begin_t=t_match-LL;

end

%%右延拓
%最后出现的为极小值

if t_min(num_min)>t_max(num_max)
LLe=t_min(num_min)-t_max(num_max);
LRe=L-t_min(num_min);
%初始化
x_end=x ( (t_min(num_min)-LLe) : (t_min(num_min)+LRe) );
D_e0= sum( abs( x_end- x( (t_min(num_min-1)-LLe) : (t_min(num_min-1)+LRe) ) ) );
D_emin=D_e0; 
t_ematch=t_min(num_min-1);

%%寻找最佳匹配波形
for i=num_min-2:-1:1
    if t_min(i)>LLe
D_i=sum(abs(x_end-x((t_min(i)-LLe):(t_min(i)+LRe))));
if D_i<=D_emin&&(L-t_min(i)-LRe)>fix(L/25)
    D_emin=D_i;
    t_ematch=t_min(i);
end
    end
end
y=[y,x(t_ematch+LRe+1:L)];
end_t=begin_t+L-1;  %%终点可以直接用起点加原信号长度计算

% l_inc=L-t_ematch-LRe;
% a=l_inc;
% while l_inc<fix(L/10)
%     y=[y,x(t_ematch+LRe+1:L)];
%     l_inc=l_inc+a;
% end

end

%最后出现的为极大值
if t_max(num_max)>t_min(num_min)
LLe=t_max(num_max)-t_min(num_min);
LRe=L-t_max(num_max);
%初始化
x_end=x ( (t_max(num_max)-LLe) : (t_max(num_max)+LRe) );
D_e0= sum( abs( x_end- x( (t_max(num_max-1)-LLe) : (t_max(num_max-1)+LRe) ) ) );
D_emin=D_e0; 
t_ematch=t_max(num_max-1);

%%寻找最佳匹配波形
for i=num_max-2:-1:1
    if t_max(i)>LLe
D_i=sum(abs(x_end-x((t_max(i)-LLe):(t_max(i)+LRe))));
if D_i<=D_emin&&(L-t_max(i)-LRe)>fix(L/25)
    D_emin=D_i;
    t_ematch=t_max(i);
end
    end
end
y=[y,x(t_ematch+LRe+1:L)];
end_t=begin_t+L-1;

end

end