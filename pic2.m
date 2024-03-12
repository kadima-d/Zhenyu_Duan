% Cor_Denoise_3('19-29-20.csv',100,10);
% 
% Cor_Denoise_3('09-27-57.csv',100,10);
% 
% Cor_Denoise_3('20230410.csv',100,10);

%% 频谱评判

clc;clear;close all;
fs=1000;%采样率
T = 1/fs;%两个点之间的距离
% data1=load('19-29-20.csv');%直流
% b=length(data1);%求数组长度
% a1=(1/fs:1/fs:b/fs);%生成x轴
%displayFFT_D(1000,'19-29-20.csv');


displayFFT_D(1000,'shiyansanCor.csv');




% 
% 
% data2=load('09-27-57.csv');%方波
% b=length(data2);%求数组长度
% a2=(1/fs:1/fs:b/fs);%生成x轴
% 
% 
% data3=load('20230410.csv');%三角波
% b=length(data3);%求数组长度
% a3=(1/fs:1/fs:b/fs);%生成x轴