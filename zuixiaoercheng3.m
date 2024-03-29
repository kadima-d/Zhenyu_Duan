function Hd = zuixiaoercheng3
%ZUIXIAOERCHENG3 Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.2 and the Signal Processing Toolbox 7.4.
% Generated on: 24-Mar-2023 13:47:19

% FIR least-squares Lowpass filter designed using the FIRLS function.

% All frequency values are in Hz.
Fs = 1000;  % Sampling Frequency

N     = 700;  % Order
Fpass = 0.1;  % Passband Frequency
Fstop = 0.7;  % Stopband Frequency
Wpass = 1;    % Passband Weight
Wstop = 1;    % Stopband Weight

% Calculate the coefficients using the FIRLS function.
b  = firls(N, [0 Fpass Fstop Fs/2]/(Fs/2), [1 1 0 0], [Wpass Wstop]);
Hd = dfilt.dffir(b);

% [EOF]
