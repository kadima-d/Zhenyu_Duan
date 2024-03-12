clc
close all
 
t=0:.1:2*pi;
plot(t,sin(t),'k');
 
axes('position',[0.55,0.55,0.3,0.3]);%关键在这句！所画的小图
plot(t,sin(t), 'b');