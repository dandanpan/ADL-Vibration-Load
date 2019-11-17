close all;clear;clc;

s = daq.createSession('ni');
addAnalogInputChannel(s,'cDAQ1Mod1',0:3,'Voltage');
s.Rate = 25600;
s.DurationInSeconds =60*3.5;
for i=1:1
    tic
    [data,time] = startForeground(s);
    plot(time,data);ylim([-2,5]);
    save('./PorterLab_20190326_making_breakfast_rep3.mat','data');
    toc
end