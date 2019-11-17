clear;
close all;
clc;

load('/Users/shijiapan/Box Sync/Activity_Detection/0208/PorterLab_20190208_breakfast_rep3.mat');
addpath('/Users/shijiapan/Documents/MATLAB/SASFunctions/');
Fs = 2560;

figure;
subplot(2,1,1);
plot(data(1,:),data(4,:));
subplot(2,1,2);
plot(data(1,:),data(5,:));
selelcted_channel = [4,5];

% noise
idx = find(data(1,:)>48 & data(1,:)<=49.5);
noise_t = data(selelcted_channel,idx);
compare_channels(noise_t);

% walking
idx = find(data(1,:)>1 & data(1,:)<=5.2);
signal_t{1} = data(selelcted_channel,idx);
compare_channels(signal_t{1});

% kettle
idx = find(data(1,:)>5.2 & data(1,:)<=6.2);
signal_t{2} = data(selelcted_channel,idx);
compare_channels(signal_t{2});

% walking
idx = find(data(1,:)>6.5 & data(1,:)<=8.8);
signal_t{3} = data(selelcted_channel,idx);
compare_channels(signal_t{3});

% microwave
idx = find(data(1,:)>8.5 & data(1,:)<=9.5);
signal_t{4} = data(selelcted_channel,idx);
compare_channels(signal_t{4});

% microwave
idx = find(data(1,:)>13.4 & data(1,:)<=13.9);
signal_t{5} = data(selelcted_channel,idx);
compare_channels(signal_t{5});

% walking
idx = find(data(1,:)>17 & data(1,:)<=19);
signal_t{6} = data(selelcted_channel,idx);
compare_channels(signal_t{6});

% walking
idx = find(data(1,:)>24 & data(1,:)<=27);
signal_t{7} = data(selelcted_channel,idx);
compare_channels(signal_t{7});

% walking
idx = find(data(1,:)>42.5 & data(1,:)<=43);
signal_t{8} = data(selelcted_channel,idx);
compare_channels(signal_t{8});

% walking
idx = find(data(1,:)>45.5 & data(1,:)<=46);
signal_t{9} = data(selelcted_channel,idx);
compare_channels(signal_t{9});

% microwave
idx = find(data(1,:)>50 & data(1,:)<=52);
signal_t{10} = data(selelcted_channel,idx);
compare_channels(signal_t{10});

% microwave
idx = find(data(1,:)>55 & data(1,:)<=56);
signal_t{11} = data(selelcted_channel,idx);
compare_channels(signal_t{11});


%%
load('/Users/shijiapan/Box Sync/Activity_Detection/0208/PorterLab_20190208_breakfast_rep4.mat');

figure;
subplot(2,1,1);
plot(data(1,:),data(4,:));
subplot(2,1,2);
plot(data(1,:),data(5,:));

% walking
idx = find(data(1,:)>4.5 & data(1,:)<=6.6);
signal_t{12} = data(selelcted_channel,idx);
compare_channels(signal_t{12});


% kettle
idx = find(data(1,:)>6.6 & data(1,:)<=7.2);
signal_t{13} = data(selelcted_channel,idx);
compare_channels(signal_t{13});

% walking
idx = find(data(1,:)>8 & data(1,:)<=11);
signal_t{14} = data(selelcted_channel,idx);
compare_channels(signal_t{14});

% microwave
idx = find(data(1,:)>13.5 & data(1,:)<=14.5);
signal_t{15} = data(selelcted_channel,idx);
compare_channels(signal_t{15});

% walking
idx = find(data(1,:)>17.5 & data(1,:)<=20.5);
signal_t{16} = data(selelcted_channel,idx);
compare_channels(signal_t{16});


% walking
idx = find(data(1,:)>42 & data(1,:)<=44);
signal_t{17} = data(selelcted_channel,idx);
compare_channels(signal_t{17});

% walking
idx = find(data(1,:)>50 & data(1,:)<=50.8);
signal_t{18} = data(selelcted_channel,idx);
compare_channels(signal_t{18});

% microwave
idx = find(data(1,:)>50.8 & data(1,:)<=51.5);
signal_t{19} = data(selelcted_channel,idx);
compare_channels(signal_t{19});

% microwave
idx = find(data(1,:)>55.4 & data(1,:)<=57);
signal_t{20} = data(selelcted_channel,idx);
compare_channels(signal_t{20});


%% feature extraction
% close all

[ noise_f ] = frequencyFeature( noise_t, Fs, 0 );
event_features = [];
for eventID = 1:length(signal_t)
    [signal_f{eventID}] = frequencyFeature( signal_t{eventID}, Fs, 0 );
    % filter signals
%     signal_f{eventID}((signal_f{eventID}(:,1)>56 & signal_f{eventID}(:,1)<63),:) = [];
%     signal_f{eventID}((signal_f{eventID}(:,1)>116 & signal_f{eventID}(:,1)<123),:) = [];
%     signal_f{eventID}((signal_f{eventID}(:,1)>176 & signal_f{eventID}(:,1)<183),:) = [];
%     signal_f{eventID}((signal_f{eventID}(:,1)>236 & signal_f{eventID}(:,1)<243),:) = [];
    
    event_features = [event_features, signal_f{eventID}(:,2)];
end

[coeff, score, latent] = pca(event_features');
figure;
idx1 = [1,3,6,7,8,9,12,14,16,17,18];
scatter3(score(idx1,1),score(idx1,2),score(idx1,3));hold on;
idx2 = [4,5,10,11,15,19,20];
scatter3(score(idx2,1),score(idx2,2),score(idx2,3));hold on;
idx3 = [2,13];
scatter3(score(idx3,1),score(idx3,2),score(idx3,3));hold off;

figure;
idx1 = [1,3,6,7,8,9,12,14,16,17,18];
scatter(score(idx1,1),score(idx1,2));hold on;
idx2 = [4,5,10,11,15,19,20];
scatter(score(idx2,1),score(idx2,2));hold on;
idx3 = [2,13];
scatter(score(idx3,1),score(idx3,2));hold off;


%%
figure;
for i = idx1
    plot(signal_f{i}(:,2));hold on;
end
hold off;

figure;
for i = idx2
    plot(signal_f{i}(:,2));hold on;
end
hold off;

figure;
for i = idx3
    plot(signal_f{i}(:,2));hold on;
end
hold off;

%%
function signal_t = compare_channels(signal_t)
    channel_num = size(signal_t,1);
    if channel_num == 1
        return;
    end
    figure;
    for cnum = 1:channel_num
        plot(signal_t(cnum,:));hold on;
    end
    hold off;
end
