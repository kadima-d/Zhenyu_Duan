t=0.001:0.001:100;
x=square(0.1*t)+0.1*sin(2*pi*t)+1.5;
figure(1);
plot(t,x);
% 设计带�?滤波�?
Fs = 1 / (t(2) - t(1)); % 采样频率
low_freq = (1.9*pi) / (2*pi); % 低截止频率（赫兹�?
high_freq = (2.1*pi) / (2*pi); % 高截止频率（赫兹�?

filter_order = 6; % 滤波器阶�?
filter_type = 'bandpass'; % 滤波器类�?

% Butterworth滤波�?
bandpass_filter = designfilt('bandpassiir', ...
                             'FilterOrder', filter_order, ...
                             'HalfPowerFrequency1', low_freq, ...
                             'HalfPowerFrequency2', high_freq, ...
                             'SampleRate', Fs, ...
                             'DesignMethod', 'butter');

% 应用滤波�?
result = filtfilt(bandpass_filter, x);
figure(2);
plot(t,result);

figure(3);
plot(t,x-result);