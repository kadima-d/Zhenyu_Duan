function Hd = filter938
%FILTER938 Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.2 and the Signal Processing Toolbox 7.4.
% Generated on: 01-Apr-2023 09:38:39

% FIR Window Highpass filter designed using the FIR1 function.

% All frequency values are in Hz.
Fs = 1000;  % Sampling Frequency

N    = 6000;     % Order
Fc   = 0.5;      % Cutoff Frequency
flag = 'scale';  % Sampling Flag

% Create the window vector for the design algorithm.
win = hamming(N+1);

% Calculate the coefficients using the FIR1 function.
b  = fir1(N, Fc/(Fs/2), 'high', win, flag);
Hd = dfilt.dffir(b);

% [EOF]
