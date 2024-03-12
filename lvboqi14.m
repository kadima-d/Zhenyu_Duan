function Hd = lvboqi14
%LVBOQI14 返回离散时间滤波器对象。

% MATLAB Code
% Generated by MATLAB(R) 9.13 and Signal Processing Toolbox 9.1.
% Generated on: 07-Apr-2023 17:33:48

% FIR least-squares Lowpass filter designed using the FIRLS function.

% All frequency values are in Hz.
Fs = 1000;  % Sampling Frequency

N     = 100;  % Order
Fpass = 3;    % Passband Frequency
Fstop = 20;   % Stopband Frequency
Wpass = 1;    % Passband Weight
Wstop = 1;    % Stopband Weight

% Calculate the coefficients using the FIRLS function.
b  = firls(N, [0 Fpass Fstop Fs/2]/(Fs/2), [1 1 0 0], [Wpass Wstop]);
Hd = dfilt.dffir(b);

% [EOF]