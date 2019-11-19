init;
%[2,3:5,9,10];

% for repID = 1:10
%     load(['/Users/shijiapan/Box Sync/Activity_Detection/0429/PortLab_20190429_Route_P4_Rep' num2str(repID) '.mat']);
% 
%     figure;plot(data(4,:));hold on;
%     plot(data(5,:));hold on;
%     plot(data(3,:));
% end
% return;

load('P4.mat');
repID = 3;
load(['/Users/shijiapan/Box Sync/Activity_Detection/0429/PortLab_20190429_Route_P4_Rep' num2str(repID) '.mat']);

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

labels{repID} = [8,27,10,1,12;...
                 12,1,12,15,5;...
                 14,15,15,5,5;...
                 16,20,16,30,1;...
                 16,30,27,15,2;...
                 27,15,27,25,1;...
                 28,5,28,28,10;...
                 29,10,29,30,10;...
                 31,18,31,28,3;...
                 31,28,33,28,14;...
                 33,28,34,21,3;...
                 35,1,70,15,11;...
                 70,27,71,10,10;...
                 71,13,71,30,10;...
                 75,1,90,17,8;...
                 95,5,95,23,10;...
                 95,30,96,18,10;...
                 96,23,97,9,10;...
                 97,15,97,28,10;...
                 98,5,98,25,10;...
                 99,1,99,19,10;...
                 99,25,100,10,10;...
                 100,23,101,5,10;...
                 101,17,102,1,10;...
                 102,10,102,25,10;...
                 103,1,103,18,10;...
                 103,26,104,10,10;...
                 104,20,104,30,10;...
                 105,15,105,30,10
                 
          ];

startindex = 7*10^4;
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

save('P4.mat','Currents','Table','Floor','Label');


%%

load('P4.mat');
repID = 2;
load(['/Users/shijiapan/Box Sync/Activity_Detection/0429/PortLab_20190429_Route_P4_Rep' num2str(repID) '.mat']);

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

labels{repID} = [10,28,11,30,12;...
                 13,10,13,25,10;...
                 14,4,14,20,10;...
                 14,23,15,5,5;...
                 17,20,18,10,5;...
                 18,10,18,30,10;...
                 19,12,19,30,10;...
                 20,5,20,20,10;...
                 20,20,20,30,1;...
                 20,30,30,1,2;...
                 30,1,30,10,1;...
                 31,10,31,25,10;...
                 32,10,32,20,10;...
                 33,5,33,20,10;...
                 35,18,36,5,3;...
                 36,5,38,29,14;...
                 38,29,39,20,3;...
                 41,1,76,15,11;...
                 76,20,77,10,10;...
                 77,15,79,30,11;...
                 81,14,97,12,8;...
                 97,12,100,20,11;...
                 100,28,101,14,10;...
                 101,20,102,5,10;...
                 102,18,102,30,10;...
                 103,9,103,22,10;...
                 104,4,104,16,10;...
                 104,27,105,17,10;...
                 105,25,106,10,10;...
                 106,20,107,2,10;...
                 107,17,108,2,10;...
                 108,14,108,30,10;...
                 109,10,109,25,10;...
                 110,7,110,20,10;...
                 111,5,111,20,10;...
                 112,1,112,18,10;...
                 112,28,113,13,10;...
                 113,15,113,30,10;...
                 114,1,120,1,11
          ];
      
startindex = 6.12*10^4;
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

save('P4.mat','Currents','Table','Floor','Label');


%%
load('P4.mat');
repID = 4;
load(['/Users/shijiapan/Box Sync/Activity_Detection/0429/PortLab_20190429_Route_P4_Rep' num2str(repID) '.mat']);
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

labels{repID} = [9,15,10,18,12;...
                 12,20,13,5,5;...
                 14,20,15,10,5;...
                 15,15,15,25,10;...
                 16,3,16,20,10;...
                 17,4,17,14,1;...
                 17,14,25,6,2;...
                 25,6,25,20,1;...
                 26,5,26,18,10;...
                 27,1,27,15,10;...
                 28,20,29,5,3;...
                 29,5,31,6,14;...
                 31,6,31,30,3;...
                 32,14,32,30,10;...
                 33,1,69,1,11;...
                 69,13,69,29,10;...
                 70,4,70,20,10;...
                 72,14,96,10,8;...
                 96,15,99,25,11;...
                 100,1,100,18,10;...
                 100,22,101,5,10;...
                 101,13,101,30,10;...
                 102,1,102,15,10;...
                 102,22,103,5,10;...
                 103,16,103,30,10;...
                 104,7,104,24,10;...
                 105,1,105,20,10;...
                 105,25,106,10,10;...
                 106,18,106,30,10
          ];
      
startindex = 5.3*10^4;
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

save('P4.mat','Currents','Table','Floor','Label');

%%
load('P4.mat');
repID = 5;
load(['/Users/shijiapan/Box Sync/Activity_Detection/0429/PortLab_20190429_Route_P4_Rep' num2str(repID) '.mat']);
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

labels{repID} = [9,10,10,14,12;...
                 11,10,11,30,5;...
                 13,10,13,30,5;...
                 14,17,14,25,1;...
                 14,25,20,9,2;...
                 20,9,20,18,1;...
                 21,10,21,20,10;...
                 21,28,22,10,10;...
                 22,15,23,2,3;...
                 23,2,24,13,14;...
                 24,13,25,1,3;...
                 25,5,61,30,11;...
                 62,25,63,7,10;...
                 65,25,86,20,8;...
                 86,20,90,20,11;...
                 90,28,91,15,10;...
                 91,28,92,15,10;...
                 93,3,93,20,10;...
                 94,3,94,20,10;...
                 95,5,95,20,10;...
                 96,13,96,25,10;...
                 97,15,97,30,10;...
                 98,15,98,30,10;...
                 99,17,100,2,10;...
                 100,25,101,15,10;...
                 101,25,102,10,10;...
                 102,25,103,10,10;...
                 103,25,104,10,10;...
                 104,24,105,10,10;...
                 105,25,106,10,10
          ];
      
startindex = 5.6*10^4;
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


save('P4.mat','Currents','Table','Floor','Label');


%%
load('P4.mat');
repID = 9;
load(['/Users/shijiapan/Box Sync/Activity_Detection/0429/PortLab_20190429_Route_P4_Rep' num2str(repID) '.mat']);
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

labels{repID} = [9,27,10,30,12;...
                 12,15,12,25,5;...
                 14,13,14,30,5;...
                 16,17,16,22,1;...
                 16,22,26,26,2;...
                 26,26,27,10,1;...
                 31,10,31,25,3;...
                 31,25,34,16,14;...
                 34,16,35,10,3;...
                 35,20,70,30,11;...
                 72,14,91,15,8;...
                 91,15,96,5,11;...
                 96,10,96,25,10;...
                 97,8,97,25,10;...
                 98,4,98,22,10;...
                 98,28,99,15,10;...
                 99,25,100,10,10;...
                 100,24,101,12,10;...
                 101,22,102,10,10;...
                 102,17,102,30,10;...
                 103,18,104,3,10;...
                 104,18,105,3,10;...
                 105,20,106,7,10;...
                 106,17,107,5,10;...
          ];
      
startindex = 5.87*10^4;
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

save('P4.mat','Currents','Table','Floor','Label');
