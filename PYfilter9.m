function Hd = PYfilter9
%PYFILTER9 返回离散时间滤波器对象。

% MATLAB Code
% Generated by MATLAB(R) 9.13 and DSP System Toolbox 9.15.
% Generated on: 24-Jul-2023 16:21:29

% Butterworth Lowpass filter designed using FDESIGN.LOWPASS.

% All frequency values are in Hz.
Fs = 1000;  % Sampling Frequency

N  = 10;  % Order
Fc = 10;  % Cutoff Frequency

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.lowpass('N,F3dB', N, Fc, Fs);
Hd = design(h, 'butter');

% [EOF]
