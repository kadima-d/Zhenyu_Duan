function Hd = PYfilter14
%PYFILTER14 返回离散时间滤波器对象。

% MATLAB Code
% Generated by MATLAB(R) 9.13 and DSP System Toolbox 9.15.
% Generated on: 16-Nov-2023 15:22:44

% Butterworth Highpass filter designed using FDESIGN.HIGHPASS.

% All frequency values are in Hz.
Fs = 1000;  % Sampling Frequency

N  = 20;   % Order
Fc = 0.1;  % Cutoff Frequency

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.highpass('N,F3dB', N, Fc, Fs);
Hd = design(h, 'butter');

% [EOF]