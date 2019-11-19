init;

load('P1_4act.mat');
repID = 1;
load(['/Users/shijiapan/Box Sync/Activity_Detection/0429/PortLab_20190429_Route_P1_Rep' num2str(repID) '.mat']);
% figure;plot(data(4,:));

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

labels{repID} = [11,13,12,21,12;...
                 13,5,13,25,10;...
                 14,15,15,10,10;...
                 16,5,16,20,5;...
                 17,14,17,20,6;...
                 18,10,18,20,10;...
                 17,20,33,23,7;...
                 33,23,34,3,6;...
                 34,28,35,13,1;...
                 35,17,54,23,2;...
                 54,23,55,3,1;...
                 55,15,56,2,10;...
                 56,3,56,27,10;...
                 57,10,58,22,3;...
                 60,24,61,12,3;...
                 62,20,63,4,3;...
                 61,12,63,28,14;...
                 63,28,64,28,3;...
                 66,1,80,28,4;...
                 82,10,82,25,10;...
                 83,5,83,28,3;...
                 83,28,89,1,14;...
                 89,1,89,25,3;...
          ];

startindex = 8.35*10^4;
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
event_start_index = round((90-starttime)*Fs+startindex);
data_label(event_start_index:end) = -1;

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
save('P1_4act.mat','Currents','Table','Floor','Label');


%%

repID = 2;
load(['/Users/shijiapan/Box Sync/Activity_Detection/0429/PortLab_20190429_Route_P1_Rep' num2str(repID) '.mat']);
% figure;plot(data(4,:));

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

labels{repID} = [3,25,4,25,12;...
                 4,30,17,10,11;...
                 17,13,17,25,10;...
                 18,3,18,20,10;...
                 19,10,19,30,5;...
                 21,4,21,14,6;...
                 21,16,38,1,7;...
                 38,1,38,8,6;...
                 39,1,39,18,10;...
                 39,22,40,5,10;...
                 40,10,40,30,3;...
                 40,30,45,15,14;...
                 45,15,46,25,3;...
                 48,1,49,5,3;...
                 50,28,65,30,4;...
                 66,20,67,5,10;...
                 67,8,67,21,10;...
                 67,29,68,29,3;...
                 71,28,72,8,10;...
                 68,29,72,27,14;...
                 72,27,73,27,3;...
                 74,10,74,20,1;...
                 75,15,75,25,10;...
                 76,12,76,22,10;...
                 74,25,95,3,2;...
                 95,3,95,12,1;...
          ];
      
startindex = 25.45*10^4;
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
save('P1_4act.mat','Currents','Table','Floor','Label');

%%
repID = 6;
load(['/Users/shijiapan/Box Sync/Activity_Detection/0429/PortLab_20190429_Route_P1_Rep' num2str(repID) '.mat']);
% figure;plot(data(4,:));

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

labels{repID} = [14,18,15,23,12;...
                 16,5,16,30,10;...
                 17,5,17,25,3;...
                 17,25,21,29,14;...
                 21,29,22,30,3;...
                 24,1,25,5,3;...
                 25,26,41,8,4;...
                 42,27,43,15,3;...
                 43,15,48,25,14;...
                 48,25,49,17,3;...
                 51,14,51,27,1;...
                 51,28,68,15,2;...
                 68,15,68,25,1;...
                 69,25,70,6,10;...
                 71,11,71,24,10;...
                 75,3,75,10,10;...
                 71,1,84,30,11;...
                 85,1,85,16,5;...
                 86,20,86,28,6;...
                 86,28,108,4,7;...
                 108,4,108,10,6
          ];
      
startindex = 5.32*10^4;
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
save('P1_4act.mat','Currents','Table','Floor','Label');


%%

repID = 7;
load(['/Users/shijiapan/Box Sync/Activity_Detection/0429/PortLab_20190429_Route_P1_Rep' num2str(repID) '.mat']);
figure;plot(data(4,:));

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

labels{repID} = [10,5,11,15,12;...
                 11,27,12,6,10;...
                 12,15,13,8,3;...
                 13,8,17,6,14;...
                 17,1,20,21,3;...
                 21,25,36,30,4;...
                 38,20,39,8,3;...
                 39,8,44,4,14;...
                 44,4,45,14,3;...
                 46,15,46,30,10;...
                 48,27,49,10,5;...
                 49,13,50,20,6;...
                 50,20,68,28,7;...
                 68,28,69,5,6;...
                 70,14,71,3,10;...
                 71,5,71,30,10;...
                 72,1,81,30,11;...
                 82,15,83,5,10;...
                 83,15,84,3,1;...
                 84,3,101,1,2;...
                 101,1,101,15,1
          ];
      
startindex = 7.05*10^4;
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
save('P1_4act.mat','Currents','Table','Floor','Label');

%%
repID = 8;
load(['/Users/shijiapan/Box Sync/Activity_Detection/0429/PortLab_20190429_Route_P1_Rep' num2str(repID) '.mat']);
figure;plot(data(4,:));

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

labels{repID} = [11,6,12,14,12;...
                 14,10,15,5,3;...
                 15,5,20,10,14;...
                 20,10,21,25,3;...
                 22,10,24,25,3;...
                 25,1,40,1,4;...
                 41,9,41,26,3;...
                 41,26,45,20,14;...
                 45,20,46,25,3;...
                 47,1,54,30,11;...
                 58,3,58,17,5;...
                 59,13,59,20,6;...
                 59,20,78,13,7;...
                 78,13,78,19,6;...
                 80,19,81,8,1;...
                 81,8,97,28,2;...
                 97,28,98,8,1;...
          ];
      
startindex = 5*10^4;
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
event_start_index = round((100-starttime)*Fs+startindex);
data_label(event_start_index:end) = -1;


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
save('P1_4act.mat','Currents','Table','Floor','Label');
