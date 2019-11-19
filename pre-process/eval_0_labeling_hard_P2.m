init;

load('P2.mat');
repID = 1;
load(['/Users/shijiapan/Box Sync/Activity_Detection/0407/PortLab_20190407_Route_P2_Rep' num2str(repID) '.mat']);
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

labels{repID} = [0,9,1,8,12;...
                 4,10,4,25,5;...
                 6,15,7,3,5;...
                 9,1,9,20,1;...
                 9,20,16,5,2;...
                 16,5,16,20,1;...
                 18,20,19,3,3;...
                 19,3,21,7,14;...
                 21,7,22,7,3;...
                 23,1,38,30,11;...
                 39,5,39,18,10;...
                 39,20,40,7,10;...
                 40,10,40,24,10;...
                 40,27,41,10,10;...
                 41,14,41,28,10;...
                 42,10,42,22,10;...
                 42,23,43,16,9;...
                 44,20,45,12,9;...
                 45,24,46,18,9;...
                 47,9,48,5,9;...
                 48,22,49,20,9;...
                 50,2,51,1,9;...
                 54,10,54,20,10;...
                 54,27,55,7,10;...
                 55,7,70,26,8;...
                 70,26,72,26,11;...
                 74,15,74,30,10;...
                 75,5,75,17,10;...
                 75,20,76,4,10;...
                 76,8,76,22,10;...
                 77,1,77,12,10;...
                 77,20,78,4,10;...
                 78,10,78,24,10;...
                 78,27,79,12,10;...
                 79,20,80,1,10;...
                 80,8,80,23,10;...
                 80,29,81,13,10;...
                 81,18,82,1,10;...
                 82,4,82,18,10;...
                 82,22,83,15,10;...
                 83,18,83,28,10;...
                 84,6,84,18,10;...
                 85,1,85,15,10;...
                 85,15,86,3,10;...
                 86,9,86,21,10;...
                 86,27,87,10,10;...
          ];

startindex = 7*10^4;
startindex_time = startindex/Fs;
starttime = labels{repID}(1,1)+labels{repID}(1,2)/30;
data_label = zeros(1,length(data));
label_index = [];
for eventID = 1:length(labels{repID})
    event_start_time = labels{repID}(eventID,1)+labels{repID}(eventID,2)/30;
    event_end_time = labels{repID}(eventID,3)+labels{repID}(eventID,4)/30;
    event_label = labels{repID}(eventID,5);
    event_start_index = round((event_start_time-starttime)*Fs+startindex);
    event_end_index = round((event_end_time-starttime)*Fs+startindex);
    data_label(event_start_index:event_end_index) = event_label;
    label_index = [label_index; event_start_index, event_end_index];
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
Label{repID}.label_index = label_index;
save('P2.mat','Currents','Table','Floor','Label');


%%

repID = 2;
load(['/Users/shijiapan/Box Sync/Activity_Detection/0407/PortLab_20190407_Route_P2_Rep' num2str(repID) '.mat']);
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

labels{repID} = [0,1,1,12,12;...
                 3,5,3,25,5;...
                 5,4,6,4,5;...
                 7,13,8,3,1;...
                 8,3,14,20,2;...
                 14,20,14,30,1;...
                 16,23,17,6,3;...
                 17,6,19,14,14;...
                 19,14,20,14,3;...
                 20,20,36,25,11;...
                 36,28,37,13,10;...
                 37,20,38,5,10;...
                 38,15,38,25,10;...
                 39,2,39,17,10;...
                 39,21,40,2,10;...
                 40,17,41,1,10;...
                 41,12,42,20,9;...
                 43,1,43,25,9;...
                 44,18,45,16,9;...
                 46,3,47,4,9;...
                 47,23,48,19,9;...
                 49,2,49,25,9;...
                 52,1,54,20,11;...
                 54,22,74,22,8;...
                 74,22,76,30,11;...
                 78,5,78,30,10;...
                 79,3,79,15,10;...
                 79,18,80,3,10;...
                 80,10,80,25,10;...
                 81,1,81,14,10;...
                 81,18,82,3,10;...
                 82,8,82,21,10
          ];
      
startindex = 5.69*10^4;
startindex_time = startindex/Fs;
starttime = labels{repID}(1,1)+labels{repID}(1,2)/30;
data_label = zeros(1,length(data));
label_index = [];
for eventID = 1:length(labels{repID})
    event_start_time = labels{repID}(eventID,1)+labels{repID}(eventID,2)/30;
    event_end_time = labels{repID}(eventID,3)+labels{repID}(eventID,4)/30;
    event_label = labels{repID}(eventID,5);
    event_start_index = round((event_start_time-starttime)*Fs+startindex);
    event_end_index = round((event_end_time-starttime)*Fs+startindex);
    data_label(event_start_index:event_end_index) = event_label;
    label_index = [label_index; event_start_index, event_end_index];
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
Label{repID}.label_index = label_index;
save('P2.mat','Currents','Table','Floor','Label');

%%
repID = 3;
load(['/Users/shijiapan/Box Sync/Activity_Detection/0407/PortLab_20190407_Route_P2_Rep' num2str(repID) '.mat']);
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

labels{repID} = [5,5,6,15,12;...
                 8,25,9,8,5;...
                 10,25,11,11,5;...
                 12,25,13,8,1;...
                 13,8,21,20,2;...
                 21,20,21,30,1;...
                 26,7,26,20,3;...
                 26,20,29,2,14;...
                 29,2,29,25,3;...
                 31,1,49,10,11;...
                 49,20,50,15,10;...
                 50,20,51,3,10;...
                 51,5,51,20,10;...
                 51,21,52,4,10;...
                 53,20,53,30,10;...
                 53,30,63,20,9;...
                 63,25,64,5,10;...
                 66,15,89,15,8;...
                 89,15,93,1,11;...
                 93,10,93,20,10
          ];
      
startindex = 6.5*10^4;
startindex_time = startindex/Fs;
starttime = labels{repID}(1,1)+labels{repID}(1,2)/30;
data_label = zeros(1,length(data));
label_index = [];
for eventID = 1:length(labels{repID})
    event_start_time = labels{repID}(eventID,1)+labels{repID}(eventID,2)/30;
    event_end_time = labels{repID}(eventID,3)+labels{repID}(eventID,4)/30;
    event_label = labels{repID}(eventID,5);
    event_start_index = round((event_start_time-starttime)*Fs+startindex);
    event_end_index = round((event_end_time-starttime)*Fs+startindex);
    data_label(event_start_index:event_end_index) = event_label;
    label_index = [label_index; event_start_index, event_end_index];
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
Label{repID}.label_index = label_index;
save('P2.mat','Currents','Table','Floor','Label');


%%

repID = 4;
load(['/Users/shijiapan/Box Sync/Activity_Detection/0407/PortLab_20190407_Route_P2_Rep' num2str(repID) '.mat']);
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

labels{repID} = [2,25,3,29,12;...
                 6,24,7,8,5;...
                 9,1,9,17,5;...
                 11,20,12,5,1;...
                 12,5,19,28,2;...
                 19,28,20,7,1;...
                 22,20,23,9,3;...
                 23,9,24,25,14;...
                 24,25,25,15,3;...
                 26,1,40,10,11;...
                 41,11,41,22,10;...
                 41,27,42,14,10;...
                 42,15,42,25,10;...
                 42,27,43,9,10;...
                 43,20,44,5,10;...
                 44,5,54,30,11;...
                 55,26,78,10,8;...
                 78,10,82,20,11;...
                 82,27,83,10,10;...
                 83,15,83,29,10;...
                 84,3,84,20,10;...
                 84,24,85,7,10;...
                 85,13,85,27,10;...
                 86,1,86,13,10
          ];
      
startindex = 3.9*10^4;
startindex_time = startindex/Fs;
starttime = labels{repID}(1,1)+labels{repID}(1,2)/30;
data_label = zeros(1,length(data));
label_index = [];
for eventID = 1:length(labels{repID})
    event_start_time = labels{repID}(eventID,1)+labels{repID}(eventID,2)/30;
    event_end_time = labels{repID}(eventID,3)+labels{repID}(eventID,4)/30;
    event_label = labels{repID}(eventID,5);
    event_start_index = round((event_start_time-starttime)*Fs+startindex);
    event_end_index = round((event_end_time-starttime)*Fs+startindex);
    data_label(event_start_index:event_end_index) = event_label;
    label_index = [label_index; event_start_index, event_end_index];
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
Label{repID}.label_index = label_index;
save('P2.mat','Currents','Table','Floor','Label');

%%
repID = 8;
load(['/Users/shijiapan/Box Sync/Activity_Detection/0407/PortLab_20190407_Route_P2_Rep' num2str(repID) '.mat']);
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

labels{repID} = [1,24,3,7,12;...
                 6,1,6,17,5;...
                 8,10,8,25,5;...
                 10,18,10,29,1;...
                 10,29,18,24,2;...
                 18,24,19,4,1;...
                 21,27,22,10,3;...
                 22,10,24,20,14;...
                 24,20,25,15,3;...
                 26,1,44,1,11;...
                 44,5,44,20,10;...
                 44,25,45,10,10;...
                 45,13,45,23,10;...
                 45,28,46,8,10;...
                 46,12,46,23,10;...
                 46,25,47,5,10;...
                 47,15,61,20,11;...
                 61,26,74,21,8;...
                 74,21,79,22,11;...
                 79,22,80,4,10;...
                 
          ];
      
startindex = 4.14*10^4;
startindex_time = startindex/Fs;
starttime = labels{repID}(1,1)+labels{repID}(1,2)/30;
data_label = zeros(1,length(data));
label_index = [];
for eventID = 1:length(labels{repID})
    event_start_time = labels{repID}(eventID,1)+labels{repID}(eventID,2)/30;
    event_end_time = labels{repID}(eventID,3)+labels{repID}(eventID,4)/30;
    event_label = labels{repID}(eventID,5);
    event_start_index = round((event_start_time-starttime)*Fs+startindex);
    event_end_index = round((event_end_time-starttime)*Fs+startindex);
    data_label(event_start_index:event_end_index) = event_label;
    label_index = [label_index; event_start_index, event_end_index];
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
Label{repID}.label_index = label_index;
save('P2.mat','Currents','Table','Floor','Label');
