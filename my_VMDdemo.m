








%% vmd
imf = vmd(mm1);
[p,q] = ndgrid(a1,1:size(imf,2));
figure(9)
plot3(p,q,imf)
grid on
xlabel('Time Values')
ylabel('Mode Number')
zlabel('Mode Amplitude')
figure(10);
plot(a1,imf(:,1));
figure(11);
plot(a1,imf(:,2));
figure(12);
plot(a1,imf(:,3));
figure(13);
plot(a1,imf(:,4));
figure(14);
plot(a1,imf(:,5));