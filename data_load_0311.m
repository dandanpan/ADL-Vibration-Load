close all; clear all;
load('/Users/shijiapan/Box Sync/Feb 2019 Activity/Porter_0205_nothing.mat');
figure; 
subplot(1,3,1);
plot(data(2,:));hold on;
% plot(data(3,:));hold on;
plot(data(4,:));hold off;
data_empty = data;
ylim([-5,5]);

load('/Users/shijiapan/Box Sync/Feb 2019 Activity/Porter_0205_kettle.mat');
data_kettle = data;

subplot(1,3,2); 
plot(data(2,:));hold on;
% plot(data(3,:));hold on;
plot(data(4,:));hold off;
ylim([-5,5]);

load('/Users/shijiapan/Box Sync/Feb 2019 Activity/Porter_0205_microwave.mat');
data_micro = data;

subplot(1,3,3); 
plot(data(2,:));hold on;
% plot(data(3,:));hold on;
plot(data(4,:));hold off;
ylim([-5,5]);

