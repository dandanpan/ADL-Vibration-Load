init;

load('P2_4act.mat');
repID = 1;
load(['/Users/shijiapan/Box Sync/Activity_Detection/0429/PortLab_20190429_Route_P2_Rep' num2str(repID) '.mat']);
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

labels{repID} = [10,4,11,6,12;...
                 13,12,13,25,10;...
                 14,5,14,20,10;...
                 14,25,15,15,5;...
                 16,9,16,13,6;...
                 16,13,33,22,7;...
                 33,22,33,30,6;...
                 35,3,35,20,10;...
                 33,25,36,10,10;...
                 36,15,37,5,1;...
                 37,5,55,15,2;...
                 55,15,55,23,1;...
                 59,1,70,25,11;...
                 70,28,71,17,10;...
                 71,23,72,12,3;...
                 72,12,75,26,14;...
                 75,26,76,18,3;...
                 76,18,77,5,10;...
                 77,20,78,10,3;...
                 80,15,80,30,3;...
                 82,15,92,17,4;...
                 94,17,95,15,3;...
                 95,15,98,18,14;...
                 98,18,99,20,3
          ];

startindex = 6.08*10^4;
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

save('P2_4act.mat','Currents','Table','Floor','Label');


%%

repID = 5;
load(['/Users/shijiapan/Box Sync/Activity_Detection/0429/PortLab_20190429_Route_P2_Rep' num2str(repID) '.mat']);
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

labels{repID} = [14,13,15,20,12;...
                 17,5,17,24,1;...
                 17,24,35,6,2;...
                 35,6,35,15,1;...
                 39,25,40,20,10;...
                 41,14,42,15,5;...
                 42,20,43,12,6;...
                 44,1,44,17,10;...
                 43,7,60,22,7;...
                 60,22,60,25,6;...
                 62,15,62,30,10;...
                 63,1,73,30,11;...
                 74,1,74,20,3;...
                 74,20,76,22,14;...
                 76,22,77,18,3;...
                 77,22,78,3,3;...
                 78,11,78,22,3;...
                 78,28,89,2,4;...
                 90,5,90,20,3;...
                 90,20,92,27,14;...
                 92,27,94,7,3
          ];
      
startindex = 6.73*10^4;
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
save('P2_4act.mat','Currents','Table','Floor','Label');



%%
repID = 6;
load(['/Users/shijiapan/Box Sync/Activity_Detection/0429/PortLab_20190429_Route_P2_Rep' num2str(repID) '.mat']);
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

labels{repID} = [10,26,11,27,12;...
                 13,10,14,1,3;...
                 14,1,16,3,14;...
                 16,3,16,20,3;...
                 17,12,17,29,3;...
                 18,8,18,20,3;...
                 18,25,18,30,3;...
                 19,5,29,8,4;...
                 30,26,31,8,3;...
                 31,8,33,4,14;...
                 33,4,33,25,3;...
                 34,1,34,25,11;...
                 35,20,36,1,1;...
                 36,1,51,29,2;...
                 51,29,52,7,1;...
                 58,25,59,5,10;...
                 59,25,60,12,5;...
                 61,6,61,10,6;...
                 61,10,88,1,7;...
                 88,1,88,10,6;...
                 90,25,91,10,10;...
                 91,15,91,25,10;...
                 91,26,92,30,11;...
                 93,1,104,1,11
          ];
      
startindex = 7.4*10^4;
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
save('P2_4act.mat','Currents','Table','Floor','Label');


%%
repID = 8;
load(['/Users/shijiapan/Box Sync/Activity_Detection/0429/PortLab_20190429_Route_P2_Rep' num2str(repID) '.mat']);
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

labels{repID} = [8,14,9,17,12;...
                 10,15,10,24,1;...
                 10,24,44,13,2;...
                 44,13,44,20,1;...
                 47,1,56,25,11;...
                 56,28,57,15,10;...
                 58,5,58,22,5;...
                 58,25,59,2,6;...
                 59,2,73,26,7;...
                 73,26,74,10,6;...
                 75,15,75,30,10;...
                 76,8,76,18,10;...
                 76,28,77,25,3;...
                 77,25,79,22,14;...
                 79,22,80,12,3;...
                 81,18,81,26,3;...
                 82,3,92,4,4;...
                 93,1,93,25,3;...
                 93,25,96,5,14;...
                 96,5,96,25,3;...
                 96,26,97,30,11
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
save('P2_4act.mat','Currents','Table','Floor','Label');

%%
repID = 9;
load(['/Users/shijiapan/Box Sync/Activity_Detection/0429/PortLab_20190429_Route_P2_Rep' num2str(repID) '.mat']);
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

labels{repID} = [11,3,12,12,12;...
                 13,18,13,28,1;...
                 13,28,32,15,2;...
                 32,15,32,24,1;...
                 38,25,39,14,3;...
                 39,14,41,1,14;...
                 41,1,41,30,3;...
                 42,21,43,25,3;...
                 45,5,55,8,4;...
                 56,7,56,20,3;...
                 56,20,59,1,14;...
                 59,1,59,26,3;...
                 60,1,69,30,11;...
                 70,24,71,9,5;...
                 71,11,71,26,6;...
                 71,26,89,9,7;...
                 89,9,89,14,6;...
                 91,5,91,15,10;...
                 92,1,93,10,11
          ];
      
startindex = 7.37*10^4;
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
save('P2_4act.mat','Currents','Table','Floor','Label');
