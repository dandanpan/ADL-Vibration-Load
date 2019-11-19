init;

result{1} = [];    result{2} = [];    result{3} = [];    
result{4} = [];    gt_total = [];

resultCount = 0;
load('P1.mat');
for repID = 2:6
    resultCount = resultCount + 1;
    load(['/Users/shijiapan/Box Sync/Activity_Detection/0407/PortLab_20190407_Route_P1_Rep' num2str(repID) '.mat']);
    
    dataLen = length(data);
    % single sensor detection
    current_detect = zeros(1,dataLen);
    table_detect = zeros(1,dataLen);
    floor_detect = zeros(1,dataLen);
    for eventID = 1:length(Currents{repID}.stepStartIdxArray)
        current_detect(Currents{repID}.stepStartIdxArray(eventID):Currents{repID}.stepStopIdxArray(eventID)) = 1;
    end
    for eventID = 1:length(Table{repID}.stepStartIdxArray)
        table_detect(Table{repID}.stepStartIdxArray(eventID):Table{repID}.stepStopIdxArray(eventID)) = 1;
    end
    for eventID = 1:length(Floor{repID}.stepStartIdxArray)
        floor_detect(Floor{repID}.stepStartIdxArray(eventID):Floor{repID}.stepStopIdxArray(eventID)) = 1;
    end
    
    current_event = [];
    table_event = [];
    floor_event = [];
    gt_events = [];
    for eventID = 1:length(Label{repID}.label_startend)
        gt_event = Label{repID}.label_startend(eventID,5);
        % if within an event, the majority is detected, we count it as
        % detected
        if gt_event == 6 || gt_event == 9 || gt_event == 11 || gt_event == 12 || gt_event == 13
            continue;
        end
        eventStart =  Label{repID}.label_index(eventID,1);
        eventStop =  min(Label{repID}.label_index(eventID,2),dataLen);
        current_event = [current_event, mode(current_detect(eventStart:eventStop))];
        table_event = [table_event, mode(table_detect(eventStart:eventStop))];
        floor_event = [floor_event, mode(floor_detect(eventStart:eventStop))];
        gt_events = [gt_events, gt_event];
    end
   
    total = current_event + table_event + floor_event;
    total(total > 0) = 1;
    
    result{1} =[result{1} current_event];%; sum(current_event(~isnan(current_event)))/length(gt_events)];
    result{2} =[result{2} table_event];%; sum(table_event(~isnan(table_event)))/length(gt_events)];
    result{3} =[result{3} floor_event];%; sum(floor_event(~isnan(floor_event)))/length(gt_events)];
    result{4} =[result{4} total];%; sum(total(~isnan(total)))/length(gt_events)];
    gt_total = [gt_total gt_events];
    
%     result{1} =[result{1} ; sum(current_event(~isnan(current_event)))/length(gt_events)];
%     result{2} =[result{2} ; sum(table_event(~isnan(table_event)))/length(gt_events)];
%     result{3} =[result{3} ; sum(floor_event(~isnan(floor_event)))/length(gt_events)];
%     result{4} =[result{4} ; sum(total(~isnan(total)))/length(gt_events)];
%  
end

load('P1_4act.mat');
for repID = [1,2,6,7,8]
    resultCount = resultCount + 1;
    load(['/Users/shijiapan/Box Sync/Activity_Detection/0429/PortLab_20190429_Route_P1_Rep' num2str(repID) '.mat']);
    dataLen = length(data);
    % single sensor detection
    current_detect = zeros(1,dataLen);
    table_detect = zeros(1,dataLen);
    floor_detect = zeros(1,dataLen);
    for eventID = 1:length(Currents{repID}.stepStartIdxArray)
        current_detect(Currents{repID}.stepStartIdxArray(eventID):Currents{repID}.stepStopIdxArray(eventID)) = 1;
    end
    for eventID = 1:length(Table{repID}.stepStartIdxArray)
        table_detect(Table{repID}.stepStartIdxArray(eventID):Table{repID}.stepStopIdxArray(eventID)) = 1;
    end
    for eventID = 1:length(Floor{repID}.stepStartIdxArray)
        floor_detect(Floor{repID}.stepStartIdxArray(eventID):Floor{repID}.stepStopIdxArray(eventID)) = 1;
    end
    
    current_event = [];
    table_event = [];
    floor_event = [];
    gt_events = [];
    for eventID = 1:length(Label{repID}.label_startend)
        gt_event = Label{repID}.label_startend(eventID,5);
        % if within an event, the majority is detected, we count it as
        % detected
        if gt_event == 6 || gt_event == 9 || gt_event == 11 || gt_event == 12 || gt_event == 13
            continue;
        end
        eventStart =  Label{repID}.label_index(eventID,1);
        eventStop =  min(Label{repID}.label_index(eventID,2),dataLen);
        current_event = [current_event, mode(current_detect(eventStart:eventStop))];
        table_event = [table_event, mode(table_detect(eventStart:eventStop))];
        floor_event = [floor_event, mode(floor_detect(eventStart:eventStop))];
        gt_events = [gt_events, gt_event];
    end
   
    total = current_event + table_event + floor_event;
    total(total > 0) = 1;
    
    result{1} =[result{1} current_event];%; sum(current_event(~isnan(current_event)))/length(gt_events)];
    result{2} =[result{2} table_event];%; sum(table_event(~isnan(table_event)))/length(gt_events)];
    result{3} =[result{3} floor_event];%; sum(floor_event(~isnan(floor_event)))/length(gt_events)];
    result{4} =[result{4} total];%; sum(total(~isnan(total)))/length(gt_events)];
    gt_total = [gt_total gt_events];
end

load('P2.mat');
for repID = [1:4,8]
    resultCount = resultCount + 1;
    load(['/Users/shijiapan/Box Sync/Activity_Detection/0407/PortLab_20190407_Route_P2_Rep' num2str(repID) '.mat']);
    dataLen = length(data);
    % single sensor detection
    current_detect = zeros(1,dataLen);
    table_detect = zeros(1,dataLen);
    floor_detect = zeros(1,dataLen);
    for eventID = 1:length(Currents{repID}.stepStartIdxArray)
        current_detect(Currents{repID}.stepStartIdxArray(eventID):Currents{repID}.stepStopIdxArray(eventID)) = 1;
    end
    for eventID = 1:length(Table{repID}.stepStartIdxArray)
        table_detect(Table{repID}.stepStartIdxArray(eventID):Table{repID}.stepStopIdxArray(eventID)) = 1;
    end
    for eventID = 1:length(Floor{repID}.stepStartIdxArray)
        floor_detect(Floor{repID}.stepStartIdxArray(eventID):Floor{repID}.stepStopIdxArray(eventID)) = 1;
    end
    
    current_event = [];
    table_event = [];
    floor_event = [];
    gt_events = [];
    for eventID = 1:length(Label{repID}.label_startend)
        gt_event = Label{repID}.label_startend(eventID,5);
        % if within an event, the majority is detected, we count it as
        % detected
        if gt_event == 6 || gt_event == 9 || gt_event == 11 || gt_event == 12 || gt_event == 13
            continue;
        end
        eventStart =  Label{repID}.label_index(eventID,1);
        eventStop =  min(Label{repID}.label_index(eventID,2),dataLen);
        current_event = [current_event, mode(current_detect(eventStart:eventStop))];
        table_event = [table_event, mode(table_detect(eventStart:eventStop))];
        floor_event = [floor_event, mode(floor_detect(eventStart:eventStop))];
        gt_events = [gt_events, gt_event];
    end
   
    total = current_event + table_event + floor_event;
    total(total > 0) = 1;
    
    result{1} =[result{1} current_event];%; sum(current_event(~isnan(current_event)))/length(gt_events)];
    result{2} =[result{2} table_event];%; sum(table_event(~isnan(table_event)))/length(gt_events)];
    result{3} =[result{3} floor_event];%; sum(floor_event(~isnan(floor_event)))/length(gt_events)];
    result{4} =[result{4} total];%; sum(total(~isnan(total)))/length(gt_events)];
    gt_total = [gt_total gt_events];
end

load('P2_4act.mat');
for repID = [1,5,6,8,9]
    resultCount = resultCount + 1;
    load(['/Users/shijiapan/Box Sync/Activity_Detection/0429/PortLab_20190429_Route_P2_Rep' num2str(repID) '.mat']);
    dataLen = length(data);
    % single sensor detection
    current_detect = zeros(1,dataLen);
    table_detect = zeros(1,dataLen);
    floor_detect = zeros(1,dataLen);
    for eventID = 1:length(Currents{repID}.stepStartIdxArray)
        current_detect(Currents{repID}.stepStartIdxArray(eventID):Currents{repID}.stepStopIdxArray(eventID)) = 1;
    end
    for eventID = 1:length(Table{repID}.stepStartIdxArray)
        table_detect(Table{repID}.stepStartIdxArray(eventID):Table{repID}.stepStopIdxArray(eventID)) = 1;
    end
    for eventID = 1:length(Floor{repID}.stepStartIdxArray)
        floor_detect(Floor{repID}.stepStartIdxArray(eventID):Floor{repID}.stepStopIdxArray(eventID)) = 1;
    end
    
    current_event = [];
    table_event = [];
    floor_event = [];
    gt_events = [];
    for eventID = 1:length(Label{repID}.label_startend)
        gt_event = Label{repID}.label_startend(eventID,5);
        % if within an event, the majority is detected, we count it as
        % detected
        if gt_event == 6 || gt_event == 9 || gt_event == 11 || gt_event == 12 || gt_event == 13
            continue;
        end
        eventStart =  Label{repID}.label_index(eventID,1);
        eventStop =  min(Label{repID}.label_index(eventID,2),dataLen);
        current_event = [current_event, mode(current_detect(eventStart:eventStop))];
        table_event = [table_event, mode(table_detect(eventStart:eventStop))];
        floor_event = [floor_event, mode(floor_detect(eventStart:eventStop))];
        gt_events = [gt_events, gt_event];
    end
   
    total = current_event + table_event + floor_event;
    total(total > 0) = 1;
    
    result{1} =[result{1} current_event];%; sum(current_event(~isnan(current_event)))/length(gt_events)];
    result{2} =[result{2} table_event];%; sum(table_event(~isnan(table_event)))/length(gt_events)];
    result{3} =[result{3} floor_event];%; sum(floor_event(~isnan(floor_event)))/length(gt_events)];
    result{4} =[result{4} total];%; sum(total(~isnan(total)))/length(gt_events)];
    gt_total = [gt_total gt_events];
end
    
    
gt_total(gt_total == 1) = 2;
eventIDMatch = [2:5,7,8,10,14];
resultCurrent = zeros(1,length(eventIDMatch));
resultTable = zeros(1,length(eventIDMatch));
resultFloor = zeros(1,length(eventIDMatch));
resultTotal = zeros(1,length(eventIDMatch));


for eventID = 1:length(eventIDMatch)
    eventIdx = find(gt_total == eventIDMatch(eventID));
    
    current = result{1}(eventIdx);
    resultCurrent(eventID) = sum(current(~isnan(current)))/length(gt_total(eventIdx));
    table = result{2}(eventIdx);
    resultTable(eventID) = sum(table(~isnan(table)))/length(gt_total(eventIdx));
    floor = result{3}(eventIdx);
    resultFloor(eventID) = sum(floor(~isnan(floor)))/length(gt_total(eventIdx));
    ours = result{4}(eventIdx);
    resultTotal(eventID) = sum(ours(~isnan(ours)))/length(gt_total(eventIdx));
end

%%
finalResult = [resultTable; resultFloor; resultCurrent; resultTotal]';
finalResult_new = finalResult;
order = [1,2,3,8,4,5,6,7];
for i = 1:8
    finalResult_new(i,:) = finalResult(order(i),:);
end
figure;
bar(finalResult_new);
xticklabels({'K', 'OM','M','MD','PS','S','V','Step'});


% figure;
% bar([resultTable; resultFloor; resultCurrent; resultTotal]');
% xticklabels({'K', 'OM','M','PS','S','V','Step','MD'});

% 
% addpath('./aboxplot/');
% figure;
% aboxplot(result);

mean(resultTable)
mean(resultFloor)
mean(resultCurrent)
mean(resultTotal)

