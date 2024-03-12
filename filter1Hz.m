% 生成信号 
t = 0.001:0.001:100;
x = square(0.1*t) + 0.1*sin(2*pi*t) + 1.5;

% 小波变换 
[c, l] = wavedec(x, 5, 'db4'); % 5层小波分解，使用db4小波基函数 
approx = wrcoef('a', c, l, 'db4', 5); % 重构近似系数 
detail = wrcoef('d', c, l, 'db4', 5); % 重构细节系数

% 滤波 
z = wden(x, 'sqtwolog', 'h', 'mln', 10, 'sym8'); % 对细节系数进行软阈值滤波 
y = x-z;

% 绘图 
subplot(2,1,1); plot(t, x); title('原始信号'); xlabel('时间（秒）'); ylabel('幅值'); 
subplot(2,1,2); plot(t, y); title('滤波后信号'); xlabel('时间（秒）'); ylabel('幅值');


