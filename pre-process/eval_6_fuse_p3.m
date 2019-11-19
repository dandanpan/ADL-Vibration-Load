init;
load('eval_p_p3.mat');

numClass  = 5;
eventIDMatch = [2:5,7,8,10,14];
eventNum = length(eventIDMatch);

accFuse = [];
accTable = [];
accFloor = [];
accCurrent = [];
accFuse2 = [];
accTable2 = [];
accFloor2 = [];
accCurrent2 = [];
accFuse_ce = [];
accFuse_cf = [];
accFuse_fe = [];

for repID = 1
    for eventType = 1:eventNum
        eventTypeIdx{repID, eventType} = [];
    end
    estimation{repID} = [];
    estimation2{repID} = [];
    estimation_cf{repID} = [];
    estimation_ce{repID} = [];
    estimation_fe{repID} = [];
    
    windowNum = length(SensorResults{1, repID}.ObservLabelTest);
    for windowID = 1:windowNum
        scores = [];
        values = [];
        scores2 = [];
        values2 = [];
        scores_ce = [];
        values_ce = [];
        scores_cf = [];
        values_cf = [];
        scores_fe = [];
        values_fe = [];
        
        for sensorID = 1:3
            if SensorResults{sensorID, repID}.ObservPrediTest(windowID) ~= nullClass
                scores = [scores, SensorResults{sensorID, repID}.ObservPrediScore(windowID)];
                values = [values, SensorResults{sensorID, repID}.ObservPrediTest(windowID)];
            end
            if SensorResults{sensorID, repID}.ObservPrediTest2(windowID) ~= nullClass
                scores2 = [scores2, SensorResults{sensorID, repID}.ObservPrediScore2(windowID)];
                values2 = [values2, SensorResults{sensorID, repID}.ObservPrediTest2(windowID)];
                if sensorID == 1
                    scores_ce = [scores_ce, SensorResults{sensorID, repID}.ObservPrediScore2(windowID)];
                    values_ce = [values_ce, SensorResults{sensorID, repID}.ObservPrediTest2(windowID)];
                    scores_cf = [scores_cf, SensorResults{sensorID, repID}.ObservPrediScore2(windowID)];
                    values_cf = [values_cf, SensorResults{sensorID, repID}.ObservPrediTest2(windowID)];
                elseif sensorID == 2
                    scores_cf = [scores_cf, SensorResults{sensorID, repID}.ObservPrediScore2(windowID)];
                    values_cf = [values_cf, SensorResults{sensorID, repID}.ObservPrediTest2(windowID)];
                    scores_fe = [scores_fe, SensorResults{sensorID, repID}.ObservPrediScore2(windowID)];
                    values_fe = [values_fe, SensorResults{sensorID, repID}.ObservPrediTest2(windowID)];
                elseif sensorID == 3
                    scores_ce = [scores_ce, SensorResults{sensorID, repID}.ObservPrediScore2(windowID)];
                    values_ce = [values_ce, SensorResults{sensorID, repID}.ObservPrediTest2(windowID)];
                    scores_fe = [scores_fe, SensorResults{sensorID, repID}.ObservPrediScore2(windowID)];
                    values_fe = [values_fe, SensorResults{sensorID, repID}.ObservPrediTest2(windowID)];
                end
            end
        end
        
        if isempty(scores)
            estimation{repID} = [estimation{repID}, nullClass];
        else
            % decision 1 based on score
            [score, index] = max(scores);
            tempDecision = values(index);
            [tempDecision2, decisionCount] = mode(values);
            if decisionCount > 1
                estimation{repID} = [estimation{repID}, tempDecision2];
            else
                estimation{repID} = [estimation{repID}, tempDecision];
            end
        end
        
        % our method
        if isempty(scores2)
            estimation2{repID} = [estimation2{repID}, nullClass];
        else
            % weight the event
            scores2(values2 == 11) = 0.1;
            % decision 1 based on score
            [score, index] = max(scores2);
            tempDecision = values2(index);
            [tempDecision2, decisionCount] = mode(values2);
            if decisionCount > 1
                estimation2{repID} = [estimation2{repID}, tempDecision2];
            else
                estimation2{repID} = [estimation2{repID}, tempDecision];
            end
        end
        
        % baseline 1
        if isempty(scores_ce)
            estimation_ce{repID} = [estimation_ce{repID}, nullClass];
        else
            % decision 1 based on score
            [score, index] = max(scores_ce);
            tempDecision = values_ce(index);
            [tempDecision2, decisionCount] = mode(values_ce);
            if decisionCount > 1
                estimation_ce{repID} = [estimation_ce{repID}, tempDecision2];
            else
                estimation_ce{repID} = [estimation_ce{repID}, tempDecision];
            end
        end
        
        % baseline 2
        if isempty(scores_cf)
            estimation_cf{repID} = [estimation_cf{repID}, nullClass];
        else
            % decision 1 based on score
            [score, index] = max(scores_cf);
            tempDecision = values_cf(index);
            [tempDecision2, decisionCount] = mode(values_cf);
            if decisionCount > 1
                estimation_cf{repID} = [estimation_cf{repID}, tempDecision2];
            else
                estimation_cf{repID} = [estimation_cf{repID}, tempDecision];
            end
        end
        
        % baseline 3
        if isempty(scores_fe)
            estimation_fe{repID} = [estimation_fe{repID}, nullClass];
        else
            % decision 1 based on score
            [score, index] = max(scores_fe);
            tempDecision = values_fe(index);
            [tempDecision2, decisionCount] = mode(values_fe);
            if decisionCount > 1
                estimation_fe{repID} = [estimation_fe{repID}, tempDecision2];
            else
                estimation_fe{repID} = [estimation_fe{repID}, tempDecision];
            end
        end
    end

    gt1{repID} = SensorResults{1, repID}.ObservLabelTest;
    gt1{repID}(gt1{repID} == 1) = 2;
    
    est_fuse{repID} = estimation2{repID};
    est_fuse{repID}(est_fuse{repID} == 1) = 2;
    
    est_table{repID} = SensorResults{1, repID}.ObservPrediTest2;
    est_table{repID}(est_table{repID} == 1) = 2; 
    
    est_floor{repID} = SensorResults{2, repID}.ObservPrediTest2;
    est_floor{repID}(est_floor{repID} == 1) = 2;  
    
    est_vib{repID} = estimation_cf{repID};
    est_vib{repID}(est_vib{repID} == 1) = 2; 
    
    est_current{repID} = SensorResults{3, repID}.ObservPrediTest2;
    est_current{repID}(est_current{repID} == 1) = 2;  
    
    eventIdx = find(SensorResults{1, repID}.ObservLabelTest ~= 6 & ...
                     SensorResults{1, repID}.ObservLabelTest ~= 9 & ...
                     SensorResults{1, repID}.ObservLabelTest ~= 11 & ...
                     SensorResults{1, repID}.ObservLabelTest ~= 12 & ...
                     SensorResults{1, repID}.ObservLabelTest ~= 13);
                 
    for eventType = 1:length(eventIDMatch)
        eventTypeIdx{repID, eventType} = [eventTypeIdx{repID, eventType}, find(SensorResults{1, repID}.ObservLabelTest == eventIDMatch(eventType))];
    end
    
    accTable = [accTable, sum(SensorResults{1, repID}.ObservPrediTest(eventIdx)==SensorResults{1, repID}.ObservLabelTest(eventIdx))./length(SensorResults{1, repID}.ObservLabelTest(eventIdx))];
    accFloor = [accFloor, sum(SensorResults{2, repID}.ObservPrediTest(eventIdx)==SensorResults{1, repID}.ObservLabelTest(eventIdx))./length(SensorResults{1, repID}.ObservLabelTest(eventIdx))];
    accCurrent = [accCurrent, sum(SensorResults{3, repID}.ObservPrediTest(eventIdx)==SensorResults{1, repID}.ObservLabelTest(eventIdx))./length(SensorResults{1, repID}.ObservLabelTest(eventIdx))];
    
    accFuse2 = [accFuse2, sum(estimation2{repID}(eventIdx)==SensorResults{1, repID}.ObservLabelTest(eventIdx))./length(SensorResults{1, repID}.ObservLabelTest(eventIdx))];
%     accFuse_cf = [accFuse_cf, sum(estimation_cf{repID}(eventIdx)==SensorResults{1, repID}.ObservLabelTest(eventIdx))./length(SensorResults{1, repID}.ObservLabelTest(eventIdx))];
    accFuse_ce = [accFuse_ce, sum(estimation_ce{repID}(eventIdx)==SensorResults{1, repID}.ObservLabelTest(eventIdx))./length(SensorResults{1, repID}.ObservLabelTest(eventIdx))];
    accFuse_cf = [accFuse_cf, sum(estimation_cf{repID}(eventIdx)==SensorResults{1, repID}.ObservLabelTest(eventIdx))./length(SensorResults{1, repID}.ObservLabelTest(eventIdx))];
    accFuse_fe = [accFuse_fe, sum(estimation_fe{repID}(eventIdx)==SensorResults{1, repID}.ObservLabelTest(eventIdx))./length(SensorResults{1, repID}.ObservLabelTest(eventIdx))];
    
%     accTable2 = [accTable2, sum(SensorResults{1, repID}.ObservPrediTest2(eventIdx)==SensorResults{1, repID}.ObservLabelTest(eventIdx))./length(SensorResults{1, repID}.ObservLabelTest(eventIdx))];
%     accFloor2 = [accFloor2, sum(SensorResults{2, repID}.ObservPrediTest2(eventIdx)==SensorResults{1, repID}.ObservLabelTest(eventIdx))./length(SensorResults{1, repID}.ObservLabelTest(eventIdx))];
%     accCurrent2 = [accCurrent2, sum(SensorResults{3, repID}.ObservPrediTest2(eventIdx)==SensorResults{1, repID}.ObservLabelTest(eventIdx))./length(SensorResults{1, repID}.ObservLabelTest(eventIdx))];
%     accFuse = [accFuse, sum(estimation{repID}(eventIdx)==SensorResults{1, repID}.ObservLabelTest(eventIdx))./length(SensorResults{1, repID}.ObservLabelTest(eventIdx))];
    
    accTable2 = [accTable2, sum(est_table{repID}(eventIdx)==gt1{repID}(eventIdx))./length(gt1{repID}(eventIdx))];
    accFloor2 = [accFloor2, sum(est_floor{repID}(eventIdx)==gt1{repID}(eventIdx))./length(gt1{repID}(eventIdx))];
    accCurrent2 = [accCurrent2, sum(est_current{repID}(eventIdx)==gt1{repID}(eventIdx))./length(gt1{repID}(eventIdx))];
    accFuse = [accFuse, sum(est_fuse{repID}(eventIdx)==gt1{repID}(eventIdx))./length(gt1{repID}(eventIdx))];
    
end

for eventID = 1:length(eventIDMatch)
    result_table{eventID} = [];
    result_floor{eventID} = [];
    result_current{eventID} = [];
    result_v2{eventID} = [];
    result_ours{eventID} = [];
    
    for repID = 1
        eIdx = eventTypeIdx{repID, eventID};
%         result_table{eventID} = [result_table{eventID},sum(SensorResults{1, repID}.ObservPrediTest2(eIdx)==SensorResults{1, repID}.ObservLabelTest(eIdx))./length(SensorResults{1, repID}.ObservLabelTest(eIdx))];
%         result_floor{eventID} = [result_floor{eventID},sum(SensorResults{2, repID}.ObservPrediTest2(eIdx)==SensorResults{1, repID}.ObservLabelTest(eIdx))./length(SensorResults{1, repID}.ObservLabelTest(eIdx))];
%         result_current{eventID} = [result_current{eventID},sum(SensorResults{3, repID}.ObservPrediTest2(eIdx)==SensorResults{1, repID}.ObservLabelTest(eIdx))./length(SensorResults{1, repID}.ObservLabelTest(eIdx))];
%         result_v2{eventID} = [result_v2{eventID},sum(estimation_cf{repID}(eIdx)==SensorResults{1, repID}.ObservLabelTest(eIdx))./length(SensorResults{1, repID}.ObservLabelTest(eIdx))];
%         result_ours{eventID} = [result_ours{eventID},sum(estimation2{repID}(eIdx)==SensorResults{1, repID}.ObservLabelTest(eIdx))./length(SensorResults{1, repID}.ObservLabelTest(eIdx))];

        result_table{eventID} = [result_table{eventID},sum(est_table{repID}(eIdx)==gt1{repID}(eIdx))./length(gt1{repID}(eIdx))];
        result_floor{eventID} = [result_floor{eventID},sum(est_floor{repID}(eIdx)==gt1{repID}(eIdx))./length(gt1{repID}(eIdx))];
        result_current{eventID} = [result_current{eventID},sum(est_current{repID}(eIdx)==gt1{repID}(eIdx))./length(gt1{repID}(eIdx))];
        result_v2{eventID} = [result_v2{eventID},sum(est_vib{repID}(eIdx)==gt1{repID}(eIdx))./length(gt1{repID}(eIdx))];        
        result_ours{eventID} = [result_ours{eventID},sum(est_fuse{repID}(eIdx)==gt1{repID}(eIdx))./length(gt1{repID}(eIdx))];
    end
end

tableAvg = ones(1,length(eventIDMatch));
floorAvg = ones(1,length(eventIDMatch));
currentAvg = ones(1,length(eventIDMatch));
v2Avg = ones(1,length(eventIDMatch));
ourAvg = ones(1,length(eventIDMatch));
for eventID = 1:length(eventIDMatch)
    tableAvg(eventID) = mean(result_table{eventID}(~isnan(result_table{eventID})));
    floorAvg(eventID) = mean(result_floor{eventID}(~isnan(result_floor{eventID})));
    currentAvg(eventID) = mean(result_current{eventID}(~isnan(result_current{eventID})));
    v2Avg(eventID) = mean(result_v2{eventID}(~isnan(result_v2{eventID})));
    ourAvg(eventID) = mean(result_ours{eventID}(~isnan(result_ours{eventID})));
end
figure;
bar([tableAvg; floorAvg; currentAvg; v2Avg; ourAvg]');%tableAvg; floorAvg; 
xticklabels({'K', 'OM','M','PS','S','V','Step','MD'});

load('finalResults.mat');
finalResult_p3 = [tableAvg; floorAvg; currentAvg; v2Avg; ourAvg]';
save('finalResults.mat','finalResult_same','finalResult_p3');

mean(ourAvg(~isnan(ourAvg)))
return;
%%

meanFuse = mean(accFuse);
meanTable = mean(accTable);
meanFloor = mean(accFloor);
meanCurrent = mean(accCurrent);

stdFuse = std(accFuse);
stdTable = std(accTable);
stdFloor = std(accFloor);
stdCurrent = std(accCurrent);

meanFuse2 = mean(accFuse2);
meanFuse_ce = mean(accFuse_ce);
meanFuse_cf = mean(accFuse_cf);
meanFuse_fe = mean(accFuse_fe);
meanTable2 = mean(accTable2);
meanFloor2 = mean(accFloor2);
meanCurrent2 = mean(accCurrent2);

stdFuse2 = std(accFuse2);
stdFuse_ce = std(accFuse_ce);
stdFuse_cf = std(accFuse_cf);
stdFuse_fe = std(accFuse_fe);
stdTable2 = std(accTable2);
stdFloor2 = std(accFloor2);
stdCurrent2 = std(accCurrent2);

figure;
bar([meanTable2, meanFloor2, meanCurrent2, meanFuse_cf, meanFuse2]');
xticklabels({'Countertop Vib','Floor Vib','Electrical','Combine Vib','Ensemble (ours)'});
ylabel('Window-level Activity Recognition Accuracy');
% bar([meanTable, meanFloor, meanCurrent, meanFuse; meanTable2, meanFloor2, meanCurrent2, meanFuse2]');
% hold on;
% errorbar([meanTable2, meanFloor2, meanCurrent2, meanFuse_cf,meanFuse_ce,meanFuse_fe,  meanFuse2], [stdTable, stdFloor, stdCurrent,stdFuse_cf,stdFuse_ce,stdFuse_fe, stdFuse]);
xlim([0.5,5.5]);
ylim([0,1]);

%%
gt_stat = [];
event_stat_duration = zeros(1,eventNum);
event_stat_number = zeros(1,eventNum);
totalEventNum = 0;
for repID = 1
    gt_stat_rep = SensorResults{1, repID}.ObservLabelTest;
    for eventID = 1:eventNum
        eventTotal = find(gt_stat_rep == eventIDMatch(eventID));
        event_stat_duration(eventID) = event_stat_duration(eventID) + length(eventTotal);
        deltaIdx = eventTotal(2:end)-eventTotal(1:end-1);
        event_stat_number(eventID) = event_stat_number(eventID) + sum(deltaIdx > 1) + 1;
    end
end
event_stat_duration
event_stat_number

figure;
subplot(2,1,1);
bar((event_stat_duration./2+1)./8);
xticklabels({'OK', 'K', 'OM','M','PS','S','V','Step','MD'});
ylabel('Event Duration (s)');
subplot(2,1,2);
bar(event_stat_number);
xticklabels({'OK', 'K', 'OM','M','PS','S','V','Step','MD'});
ylabel('Event Number');