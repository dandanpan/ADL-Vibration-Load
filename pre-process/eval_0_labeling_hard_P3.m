init;
load('P3.mat');

repID = 1;
load(['/Users/shijiapan/Box Sync/Activity_Detection/0408/PortLab_20190408_Route_P3_Rep' num2str(repID) '.mat']);
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

labels{repID} = [91,8,92,22,12;...
                 95,5,95,25,10;...
                 95,13,95,5,5;...
                 98,5,98,17,5;...
                 101,5,101,25,10;...
                 102,1,102,25,10;...
                 106,10,106,27,1;...
                 106,27,119,18,2;...
                 119,18,120,3,1;...
                 123,20,124,10,10;...
                 124,15,125,5,10;...
                 125,13,125,26,3;...
                 125,26,130,9,14;...
                 130,9,131,5,3;...
                 139,25,140,30,10;...
                 141,1,151,1,11;...
                 153,5,153,25,10;...
                 154,1,154,17,10;...
                 154,20,155,20,10;...
                 157,1,185,1,11;...
          ];

startindex = 4.2*10^4;
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
save('P3.mat','Currents','Table','Floor','Label');


%%
load('P3.mat');

repID = 2;
load(['/Users/shijiapan/Box Sync/Activity_Detection/0408/PortLab_20190408_Route_P3_Rep' num2str(repID) '.mat']);
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

labels{repID} = [29,1,30,12,12;...
                 32,16,32,25,5;...
                 35,5,35,20,5;...
                 36,25,37,5,10;...
                 38,20,39,5,1;...
                 39,5,52,23,2;...
                 52,23,53,5,1;...
                 54,1,54,10,10;...
                 56,20,56,30,10;...
                 57,10,57,20,10;...
                 58,5,58,20,3;...
                 58,20,61,13,14;...
                 61,13,61,30,3;...
                 64,1,64,17,10;...
                 64,20,65,1,10;...
                 65,1,101,10,11;...
                 101,20,101,30,10;...
                 102,5,102,20,10;...
                 102,20,109,30,11;...
                 110,10,120,30,8
          ];
      
startindex = 7.5*10^4;
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

save('P3.mat','Currents','Table','Floor','Label');



%%

load('P3.mat');

repID = 3;
load(['/Users/shijiapan/Box Sync/Activity_Detection/0408/PortLab_20190408_Route_P3_Rep' num2str(repID) '.mat']);
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

labels{repID} = [71,28,73,8,12;...
                 75,20,76,3,5;...
                 78,7,78,27,5;...
                 89,24,80 15,10;...
                 82,12,82,30,1;...
                 82,30,96,14,2;...
                 96,14,96,30,1;...
                 97,25,98,10,10;...
                 102,15,103,12,10;...
                 103,12,103,30,3;...
                 103,30,108,10,14;...
                 108,10,109,10,3;...
                 111,1,112,10,10;...
                 112,15,152,30,11;...
                 153,4,153,25,10;...
                 154,1,154,20,10;...
                 154,23,155,5,10;...
                 156,1,170,1,8
          ];
      
startindex = 9.9*10^4;
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

save('P3.mat','Currents','Table','Floor','Label');


%%

load('P3.mat');
repID = 4;
load(['/Users/shijiapan/Box Sync/Activity_Detection/0408/PortLab_20190408_Route_P3_Rep' num2str(repID) '.mat']);
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

labels{repID} = [20,18,21,30,12;...
                 24,10,24,22,5;...
                 26,22,27,15,5;...
                 27,30,28,10,10;...
                 28,28,29,20,10;...
                 31,1,31,10,1;...
                 31,10,42,19,2;...
                 42,19,42,30,1;...
                 43,24,44,4,10;...
                 45,28,46,23,10;...
                 48,28,49,20,3;...
                 49,20,52,1,14;...
                 52,1,52,15,3;...
                 54,5,54,25,10;...
                 54,25,90,8,11;...
                 90,10,110,22,8;...
                 110,22,117,25,11;...
                 117,25,118,10,10
          ];
      
startindex = 8.5*10^4;
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

save('P3.mat','Currents','Table','Floor','Label');


