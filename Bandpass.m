function Hd = Bandpass
%BANDPASS Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.2 and the DSP System Toolbox 9.4.
% Generated on: 30-Mar-2023 10:05:03

% Butterworth Bandpass filter designed using FDESIGN.BANDPASS.

% All frequency values are in Hz.
Fs = 1000;  % Sampling Frequency

N   = 10;   % Order
Fc1 = 0.5;  % First Cutoff Frequency
Fc2 = 1.5;  % Second Cutoff Frequency

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.bandpass('N,F3dB1,F3dB2', N, Fc1, Fc2, Fs);
Hd = design(h, 'butter');

% [EOF]
