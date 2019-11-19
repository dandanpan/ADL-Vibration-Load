init;

load('P5.mat');
repID = 3;
load(['/Users/shijiapan/Box Sync/Activity_Detection/0429/PortLab_20190429_Route_P5_Rep' num2str(repID) '.mat']);
% figure;plot(data(3,:));hold on;
% plot(data(4,:));hold on;
% plot(data(5,:));

% Events
% 1. operating with kettle
% 2. kettle 
% 3. operating with microwave
% 4. microwave
% 5. put things on stove
% 6. operating with stove
% 7. stove
% 8. operating vacuum
% 9. sweep floor
% 10. walking/step
% 11. miscellaneous
% 12. sync
% 13. vacant
% 14. microwave door

labels{repID} = [10,20,11,30,12;...
                 12,25,13,5,10;...
                 13,15,13,28,5;...
                 16,12,17,12,5;...
                 19,23,20,1,1;...
                 20,1,31,8,2;...
                 31,8,31,18,1;...
                 36,1,36,15,10;...
                 36,18,37,5,3;...
                 37,5,37,13,10;...
                 37,5,38,28,14;...
                 38,28,39,27,3;...
                 39,28,40,26,10;...
                 42,1,46,30,11;...
                 47,5,47,17,10;...
                 48,2,48,20,10;...
                 48,25,49,15,10;...
                 49,15,49,30,6;...
                 49,30,56,19,7;...
                 56,19,56,30,6;...
                 57,28,58,18,10;...
                 58,24,59,15,10;...
                 60,5,60,25,10;...
                 61,1,75,1,11;...
                 75,14,75,26,10;...
                 76,8,76,20,10;...
                 77,4,77,15,10;...
                 77,28,89,8,8;...
                 89,8,93,10,11;...
                 93,18,94,5,10;...
                 94,12,95,1,10;...
                 95,10,95,25,10;...
                 96,3,96,17,10;...
                 96,22,97,7,10;...
                 97,12,97,26,10;...
                 98,7,98,25,10;...
                 99,2,99,16,10;...
                 99,26,100,13,10;...
                 100,18,100,30,10;...
                 101,9,101,24,10;...
                 102,4,102,20,10;...
                 102,28,103,15,10;...
                 103,20,104,5,10;...
                 104,20,105,4,10;...
                 105,12,106,2,10;...
                 106,12,106,27,10;...
                 107,12,107,27,10
          ];

startindex = 6.8*10^4;
startindex_time = startindex/Fs;
starttime = labels{repID}(1,1)+labels{repID}(1,2)/30;
data_label = zeros(1,length(data));
for eventID = 1:length(labels{repID})
    event_start_time = labels{repID}(eventID,1)+labels{repID}(eventID,2)/30;
    event_end_time = labels{repID}(eventID,3)+labels{repID}(eventID,4)/30;
    event_label = labels{repID}(eventID,5);
    event_start_index = round((event_start_time-starttime)*Fs+startindex);
    event_end_index = round((event_end_time-starttime)*Fs+startindex);
    data_label(event_start_index:event_end_index) = event_label;
end

currentLabel = zeros(1,length(data));
tableLabel = zeros(1,length(data));
floorLabel = zeros(1,length(data));

for eventID = 1:length(Currents{repID}.stepStartIdxArray)
    currentLabel(Currents{repID}.stepStartIdxArray(eventID):Currents{repID}.stepStopIdxArray(eventID)) = -3;
end
for eventID = 1:length(Table{repID}.stepStartIdxArray)
    tableLabel(Table{repID}.stepStartIdxArray(eventID):Table{repID}.stepStopIdxArray(eventID)) = -4;
end
for eventID = 1:length(Floor{repID}.stepStartIdxArray)
    floorLabel(Floor{repID}.stepStartIdxArray(eventID):Floor{repID}.stepStopIdxArray(eventID)) = -5;
end
figure;plot(data(4,:));hold on;
plot(data(5,:));hold on;
plot(data(3,:));hold on;
plot(data_label);
plot(currentLabel);
plot(tableLabel);
plot(floorLabel);

Label{repID}.label_array = data_label;
Label{repID}.label_startend = labels{repID};
save('P5.mat','Currents','Table','Floor','Label');


%%
load('P5.mat');
repID = 4;
load(['/Users/shijiapan/Box Sync/Activity_Detection/0429/PortLab_20190429_Route_P5_Rep' num2str(repID) '.mat']);
% figure;plot(data(3,:));hold on;
% plot(data(4,:));hold on;
% plot(data(5,:));

% Events
% 1. operating with kettle
% 2. kettle 
% 3. operating with microwave
% 4. microwave
% 5. put things on stove
% 6. operating with stove
% 7. stove
% 8. operating vacuum
% 9. sweep floor
% 10. walking/step
% 11. miscellaneous
% 12. sync
% 13. vacant
% 14. microwave door

labels{repID} = [16,10,17,17,12;...
                 19,13,19,20,5;...
                 22,13,22,23,5;...
                 24,1,24,15,10;...
                 25,18,25,30,10;...
                 26,1,26,15,6;...
                 26,15,33,25,7;...
                 33,25,34,1,6;...
                 34,23,36,3,10;...
                 36,13,36,20,1;...
                 36,20,49,20,2;...
                 49,20,49,30,1;...
                 51,17,52,3,10;...
                 52,7,52,20,10;...
                 53,27,54,10,3;...
                 54,10,56,16,14;...
                 56,16,57,14,3;...
                 57,17,58,1,10;...
                 58,6,59,10,10;...
                 59,10,63,30,11;...
                 64,11,64,28,10;...
                 65,7,65,20,10;...
                 65,27,66,10,10;...
                 66,26,67,6,10;...
                 67,15,80,1,11;...
                 80,18,81,1,10;...
                 81,5,82,1,11;...
                 83,20,99,8,8;...
                 99,8,104,15,11;...
                 104,22,105,10,10;...
                 105,21,106,3,10;...
                 106,17,106,30,10;...
                 107,11,107,27,10;...
                 108,2,108,17,10;...
                 108,24,109,9,10;...
                 109,15,109,29,10;...
                 110,11,110,26,10;...
                 111,3,111,16,10;...
                 111,25,112,9,10;...
                 112,16,112,30,10
          ];
      
startindex = 8.45*10^4;
startindex_time = startindex/Fs;
starttime = labels{repID}(1,1)+labels{repID}(1,2)/30;
data_label = zeros(1,length(data));
for eventID = 1:size(labels{repID},1)
    event_start_time = labels{repID}(eventID,1)+labels{repID}(eventID,2)/30;
    event_end_time = labels{repID}(eventID,3)+labels{repID}(eventID,4)/30;
    event_label = labels{repID}(eventID,5);
    event_start_index = round((event_start_time-starttime)*Fs+startindex);
    event_end_index = round((event_end_time-starttime)*Fs+startindex);
    data_label(event_start_index:event_end_index) = event_label;
end

currentLabel = zeros(1,length(data));
tableLabel = zeros(1,length(data));
floorLabel = zeros(1,length(data));

for eventID = 1:length(Currents{repID}.stepStartIdxArray)
    currentLabel(Currents{repID}.stepStartIdxArray(eventID):Currents{repID}.stepStopIdxArray(eventID)) = -3;
end
for eventID = 1:length(Table{repID}.stepStartIdxArray)
    tableLabel(Table{repID}.stepStartIdxArray(eventID):Table{repID}.stepStopIdxArray(eventID)) = -4;
end
for eventID = 1:length(Floor{repID}.stepStartIdxArray)
    floorLabel(Floor{repID}.stepStartIdxArray(eventID):Floor{repID}.stepStopIdxArray(eventID)) = -5;
end
figure;plot(data(4,:));hold on;
plot(data(5,:));hold on;
plot(data(3,:));hold on;
plot(data_label);
plot(currentLabel);
plot(tableLabel);
plot(floorLabel);

Label{repID}.label_array = data_label;
Label{repID}.label_startend = labels{repID};

save('P5.mat','Currents','Table','Floor','Label');

%%
init;

load('P5.mat');
repID = 5;
load(['/Users/shijiapan/Box Sync/Activity_Detection/0429/PortLab_20190429_Route_P5_Rep' num2str(repID) '.mat']);
% figure;plot(data(3,:));hold on;
% plot(data(4,:));hold on;
% plot(data(5,:));

% Events
% 1. operating with kettle
% 2. kettle 
% 3. operating with microwave
% 4. microwave
% 5. put things on stove
% 6. operating with stove
% 7. stove
% 8. operating vacuum
% 9. sweep floor
% 10. walking/step
% 11. miscellaneous
% 12. sync
% 13. vacant
% 14. microwave door

labels{repID} = [12,21,13,25,12;...
                 15,25,16,8,5;...
                 18,24,19,20,5;...
                 23,15,23,30,6;...
                 23,30,34,17,7;...
                 34,17,34,30,6;...
                 36,24,37,5,10;...
                 37,23,38,1,1;...
                 38,1,51,18,2;...
                 51,18,51,28,1;...
                 54,3,54,13,10;...
                 54,20,54,30,3;...
                 54,30,57,9,14;...
                 57,9,57,30,3;...
                 58,14,58,24,10;...
                 59,5,59,20,10;...
                 59,25,64,1,11;...
                 64,28,65,13,10;...
                 65,28,66,10,10;...
                 67,1,82,30,11;...
                 83,14,84,25,10;...
                 86,11,105,14,8;...
                 105,14,108,25,11;...
                 108,25,109,6,10;...
          ];
      
startindex = 8.98*10^4;
startindex_time = startindex/Fs;
starttime = labels{repID}(1,1)+labels{repID}(1,2)/30;
data_label = zeros(1,length(data));
for eventID = 1:length(labels{repID})
    event_start_time = labels{repID}(eventID,1)+labels{repID}(eventID,2)/30;
    event_end_time = labels{repID}(eventID,3)+labels{repID}(eventID,4)/30;
    event_label = labels{repID}(eventID,5);
    event_start_index = round((event_start_time-starttime)*Fs+startindex);
    event_end_index = round((event_end_time-starttime)*Fs+startindex);
    data_label(event_start_index:event_end_index) = event_label;
end

currentLabel = zeros(1,length(data));
tableLabel = zeros(1,length(data));
floorLabel = zeros(1,length(data));

for eventID = 1:length(Currents{repID}.stepStartIdxArray)
    currentLabel(Currents{repID}.stepStartIdxArray(eventID):Currents{repID}.stepStopIdxArray(eventID)) = -3;
end
for eventID = 1:length(Table{repID}.stepStartIdxArray)
    tableLabel(Table{repID}.stepStartIdxArray(eventID):Table{repID}.stepStopIdxArray(eventID)) = -4;
end
for eventID = 1:length(Floor{repID}.stepStartIdxArray)
    floorLabel(Floor{repID}.stepStartIdxArray(eventID):Floor{repID}.stepStopIdxArray(eventID)) = -5;
end
close all
figure;plot(data(4,:));hold on;
plot(data(5,:));hold on;
plot(data(3,:));hold on;
plot(data_label);
plot(currentLabel);
plot(tableLabel);
plot(floorLabel);

Label{repID}.label_array = data_label;
Label{repID}.label_startend = labels{repID};

save('P5.mat','Currents','Table','Floor','Label');

return;
%%
load('P5.mat');
repID = 9;
load(['/Users/shijiapan/Box Sync/Activity_Detection/0429/PortLab_20190429_Route_P5_Rep' num2str(repID) '.mat']);
figure;plot(data(3,:));hold on;
plot(data(4,:));hold on;
plot(data(5,:));

% Events
% 1. operating with kettle
% 2. kettle 
% 3. operating with microwave
% 4. microwave
% 5. put things on stove
% 6. operating with stove
% 7. stove
% 8. operating vacuum
% 9. sweep floor
% 10. walking/step
% 11. miscellaneous
% 12. sync
% 13. vacant
% 14. microwave door

labels{repID} = [8,23,10,10,12;...
                 11,5,11,17,10;...
                 12,1,12,12,10;...
                 13,25,14,8,1;...
                 14,8,25,3,2;...
                 25,3,25,13,1;...
                 29,15,29,30,5;...
                 32,15,33,10,5;...
                 35,1,35,10,6;...
                 35,10,43,22,7;...
                 43,22,44,10,6;...
                 46,17,47,2,10;...
                 47,8,47,30,3;...
                 47,30,54,2,14;...
                 54,2,54,22,3;...
                 55,10,55,20,10;...
                 59,11,69,16,4;...
                 74,15,76,3,10;...
                 76,3,80,1,11;...
                 81,20,82,12,10;...
                 82,18,83,5,10;...
                 83,15,96,4,11;...
                 96,15,97,5,10;...
                 97,23,98,3,10;...
                 98,8,98,28,10;...
                 99,5,99,28,11;...
                 99,28,112,27,8;...
          ];
      
startindex = 4.45*10^4;
startindex_time = startindex/Fs;
starttime = labels{repID}(1,1)+labels{repID}(1,2)/30;
data_label = zeros(1,length(data));
for eventID = 1:length(labels{repID})
    event_start_time = labels{repID}(eventID,1)+labels{repID}(eventID,2)/30;
    event_end_time = labels{repID}(eventID,3)+labels{repID}(eventID,4)/30;
    event_label = labels{repID}(eventID,5);
    event_start_index = round((event_start_time-starttime)*Fs+startindex);
    event_end_index = round((event_end_time-starttime)*Fs+startindex);
    data_label(event_start_index:event_end_index) = event_label;
end

currentLabel = zeros(1,length(data));
tableLabel = zeros(1,length(data));
floorLabel = zeros(1,length(data));

for eventID = 1:length(Currents{repID}.stepStartIdxArray)
    currentLabel(Currents{repID}.stepStartIdxArray(eventID):Currents{repID}.stepStopIdxArray(eventID)) = -3;
end
for eventID = 1:length(Table{repID}.stepStartIdxArray)
    tableLabel(Table{repID}.stepStartIdxArray(eventID):Table{repID}.stepStopIdxArray(eventID)) = -4;
end
for eventID = 1:length(Floor{repID}.stepStartIdxArray)
    floorLabel(Floor{repID}.stepStartIdxArray(eventID):Floor{repID}.stepStopIdxArray(eventID)) = -5;
end
close all
figure;plot(data(4,:));hold on;
plot(data(5,:));hold on;
plot(data(3,:));hold on;
plot(data_label);
plot(currentLabel);
plot(tableLabel);
plot(floorLabel);

Label{repID}.label_array = data_label;
Label{repID}.label_startend = labels{repID};
save('P5.mat','Currents','Table','Floor','Label');
return;
%%
init;

load('P5.mat');
repID = 10;
load(['/Users/shijiapan/Box Sync/Activity_Detection/0429/PortLab_20190429_Route_P5_Rep' num2str(repID) '.mat']);
% figure;plot(data(3,:));hold on;
% plot(data(4,:));hold on;
% plot(data(5,:));

% Events
% 1. operating with kettle
% 2. kettle 
% 3. operating with microwave
% 4. microwave
% 5. put things on stove
% 6. operating with stove
% 7. stove
% 8. operating vacuum
% 9. sweep floor
% 10. walking/step
% 11. miscellaneous
% 12. sync
% 13. vacant
% 14. microwave door

labels{repID} = [11,15,12,20,12;...
                 15,10,15,25,10;...
                 15,30,16,10,1;...
                 16,10,28,13,2;...
                 28,13,28,23,1;...
                 34,3,34,17,5;...
                 36,21,37,7,5;...
                 39,1,39,10,6;...
                 39,10,47,28,7;...
                 47,28,48,7,6;...
                 50,15,50,30,10;...
                 51,20,52,8,3;...
                 52,8,54,28,14;...
                 54,26,55,15,3;...
                 55,22,56,6,10;...
                 59,24,69,30,4;...
                 72,1,72,16,10;...
                 72,26,73,6,10;...
                 73,15,78,30,11;...
                 79,12,79,30,10;...
                 80,13,80,30,10;...
                 81,5,81,24,10;...
                 82,3,82,20,10;...
                 83,1,96,3,11;...
                 96,17,96,30,10;...
                 97,15,97,25,10;...
                 98,10,98,25,10;...
                 98,28,110,1,8
          ];
      
startindex = 8.35*10^4;
startindex_time = startindex/Fs;
starttime = labels{repID}(1,1)+labels{repID}(1,2)/30;
data_label = zeros(1,length(data));
for eventID = 1:length(labels{repID})
    event_start_time = labels{repID}(eventID,1)+labels{repID}(eventID,2)/30;
    event_end_time = labels{repID}(eventID,3)+labels{repID}(eventID,4)/30;
    event_label = labels{repID}(eventID,5);
    event_start_index = round((event_start_time-starttime)*Fs+startindex);
    event_end_index = round((event_end_time-starttime)*Fs+startindex);
    data_label(event_start_index:event_end_index) = event_label;
end

currentLabel = zeros(1,length(data));
tableLabel = zeros(1,length(data));
floorLabel = zeros(1,length(data));

for eventID = 1:length(Currents{repID}.stepStartIdxArray)
    currentLabel(Currents{repID}.stepStartIdxArray(eventID):Currents{repID}.stepStopIdxArray(eventID)) = -3;
end
for eventID = 1:length(Table{repID}.stepStartIdxArray)
    tableLabel(Table{repID}.stepStartIdxArray(eventID):Table{repID}.stepStopIdxArray(eventID)) = -4;
end
for eventID = 1:length(Floor{repID}.stepStartIdxArray)
    floorLabel(Floor{repID}.stepStartIdxArray(eventID):Floor{repID}.stepStopIdxArray(eventID)) = -5;
end
close all
figure;plot(data(4,:));hold on;
plot(data(5,:));hold on;
plot(data(3,:));hold on;
plot(data_label);
plot(currentLabel);
plot(tableLabel);
plot(floorLabel);

Label{repID}.label_array = data_label;
Label{repID}.label_startend = labels{repID};

save('P5.mat','Currents','Table','Floor','Label');
