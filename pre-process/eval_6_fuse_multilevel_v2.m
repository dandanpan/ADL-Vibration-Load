init;
load('eval_p1.mat');

numClass  = 12;
eventIDMatch = [1:5,7,8,10,14];
eventIDMatch2 = [1,3,7,8,10];
eventNum = length(eventIDMatch);
eventNum2 = length(eventIDMatch2);

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

accFuse_level2 = [];
accFuse_level3 = [];
for sensorID = 1:3
    accSen_level2{sensorID} = [];
end

for repID = 1:5
    for eventType = 1:eventNum
        eventTypeIdx{repID, eventType} = [];
    end
    
    for eventType = 1:eventNum2
        eventTypeIdx2{repID, eventType} = [];
    end
    
    estimation{repID} = [];
    estimation2{repID} = [];
    estimation_cf{repID} = [];
    estimation_ce{repID} = [];
    estimation_fe{repID} = [];
    for windowID = 1:length(SensorResults{1, repID}.ObservLabelTest)
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
    gt2{repID} = gt1{repID};
    
    gt2{repID}(gt2{repID} == 2) = 1;
    gt2{repID}(gt2{repID} == 4) = 3;
    gt2{repID}(gt2{repID} == 14) = 3;
    gt2{repID}(gt2{repID} == 5) = 7;
%     gt2{repID}(gt2{repID} == 6) = 7;
    gt2{repID} = activitySeg(gt2{repID}, 5, Fs, nullClass);
    
    gt3{repID} = gt1{repID};
    gt3{repID}(gt3{repID} == 2) = 1;
    gt3{repID}(gt3{repID} == 3) = 1;
    gt3{repID}(gt3{repID} == 4) = 1;
    gt3{repID}(gt3{repID} == 5) = 1;
%     gt3{repID}(gt3{repID} == 6) = 1;
    gt3{repID}(gt3{repID} == 7) = 1;
    gt3{repID}(gt3{repID} == 14) = 1;
%     gt3{repID}(gt3{repID} == 8) = 9;
    gt3{repID} = activitySeg(gt3{repID}, 5, Fs, nullClass);
    
%     figure;
%     plot(gt1{repID});hold on;
%     plot(gt2{repID});hold on;
%     plot(gt3{repID});hold off;
   
    est2{repID} = estimation2{repID};
    est2{repID}(est2{repID} == 2) = 1;
    est2{repID}(est2{repID} == 4) = 3;
    est2{repID}(est2{repID} == 14) = 3;
    est2{repID}(est2{repID} == 5) = 7;
    est2{repID} = activitySeg(est2{repID}, 5, Fs, nullClass);
    
    est3{repID} = estimation2{repID};
    est3{repID}(est3{repID} == 2) = 1;
    est3{repID}(est3{repID} == 3) = 1;
    est3{repID}(est3{repID} == 4) = 1;
    est3{repID}(est3{repID} == 5) = 1;
    est3{repID}(est3{repID} == 7) = 1;
    est3{repID}(est3{repID} == 14) = 1;
    est3{repID} = activitySeg(est3{repID}, 5, Fs, nullClass);
    
    for sensorID = 1:3
        sen2{sensorID, repID} = SensorResults{sensorID, repID}.ObservPrediTest2;
        sen2{sensorID, repID}(sen2{sensorID, repID} == 2) = 1;
        sen2{sensorID, repID}(sen2{sensorID, repID} == 4) = 3;
        sen2{sensorID, repID}(sen2{sensorID, repID} == 14) = 3;
        sen2{sensorID, repID}(sen2{sensorID, repID} == 5) = 7;
        sen2{sensorID, repID} = activitySeg(sen2{sensorID, repID}, 5, Fs, nullClass);
    end
    
    eventIdx = find(SensorResults{1, repID}.ObservLabelTest ~= 6 & ...
                     SensorResults{1, repID}.ObservLabelTest ~= 9 & ...
                     SensorResults{1, repID}.ObservLabelTest ~= 11 & ...
                     SensorResults{1, repID}.ObservLabelTest ~= 12 & ...
                     SensorResults{1, repID}.ObservLabelTest ~= 13);
    
    for eventType = 1:length(eventIDMatch)
        eventTypeIdx{repID, eventType} = [eventTypeIdx{repID, eventType}, find(SensorResults{1, repID}.ObservLabelTest == eventIDMatch(eventType))];
    end
    
    for eventType = 1:length(eventIDMatch2)
        eventTypeIdx2{repID, eventType} = [eventTypeIdx2{repID, eventType}, find(gt2{repID} == eventIDMatch2(eventType))];
    end
    
    accFuse_level2 = [accFuse_level2,  sum(est2{repID}(eventIdx)==gt2{repID}(eventIdx))./length(gt2{repID}(eventIdx))];
    accFuse_level3 = [accFuse_level3,  sum(est3{repID}(eventIdx)==gt3{repID}(eventIdx))./length(gt3{repID}(eventIdx))];
    for sensorID = 1:3
        accSen_level2{sensorID} = [accSen_level2{sensorID}, sum(sen2{sensorID, repID}(eventIdx)==gt2{repID}(eventIdx))./length(gt2{repID}(eventIdx))];
    end
    
    accFuse2 = [accFuse2, sum(estimation2{repID}(eventIdx)==SensorResults{1, repID}.ObservLabelTest(eventIdx))./length(SensorResults{1, repID}.ObservLabelTest(eventIdx))];
    accFuse_ce = [accFuse_ce, sum(estimation_ce{repID}(eventIdx)==SensorResults{1, repID}.ObservLabelTest(eventIdx))./length(SensorResults{1, repID}.ObservLabelTest(eventIdx))];
    accFuse_cf = [accFuse_cf, sum(estimation_cf{repID}(eventIdx)==SensorResults{1, repID}.ObservLabelTest(eventIdx))./length(SensorResults{1, repID}.ObservLabelTest(eventIdx))];
    accFuse_fe = [accFuse_fe, sum(estimation_fe{repID}(eventIdx)==SensorResults{1, repID}.ObservLabelTest(eventIdx))./length(SensorResults{1, repID}.ObservLabelTest(eventIdx))];
    accTable2 = [accTable2, sum(SensorResults{1, repID}.ObservPrediTest2(eventIdx)==SensorResults{1, repID}.ObservLabelTest(eventIdx))./length(SensorResults{1, repID}.ObservLabelTest(eventIdx))];
    accFloor2 = [accFloor2, sum(SensorResults{2, repID}.ObservPrediTest2(eventIdx)==SensorResults{1, repID}.ObservLabelTest(eventIdx))./length(SensorResults{1, repID}.ObservLabelTest(eventIdx))];
    accCurrent2 = [accCurrent2, sum(SensorResults{3, repID}.ObservPrediTest2(eventIdx)==SensorResults{1, repID}.ObservLabelTest(eventIdx))./length(SensorResults{1, repID}.ObservLabelTest(eventIdx))];
    
end

%%
for eventID = 1:length(eventIDMatch)
    result_table{eventID} = [];
    result_floor{eventID} = [];
    result_current{eventID} = [];
    result_v2{eventID} = [];
    result_ours{eventID} = [];
    
    for repID = 1:5
        eIdx = eventTypeIdx{repID, eventID};
        result_table{eventID} = [result_table{eventID},sum(SensorResults{1, repID}.ObservPrediTest2(eIdx)==SensorResults{1, repID}.ObservLabelTest(eIdx))./length(SensorResults{1, repID}.ObservLabelTest(eIdx))];
        result_floor{eventID} = [result_floor{eventID},sum(SensorResults{2, repID}.ObservPrediTest2(eIdx)==SensorResults{1, repID}.ObservLabelTest(eIdx))./length(SensorResults{1, repID}.ObservLabelTest(eIdx))];
        result_current{eventID} = [result_current{eventID},sum(SensorResults{3, repID}.ObservPrediTest2(eIdx)==SensorResults{1, repID}.ObservLabelTest(eIdx))./length(SensorResults{1, repID}.ObservLabelTest(eIdx))];
        result_v2{eventID} = [result_v2{eventID},sum(estimation_cf{repID}(eIdx)==SensorResults{1, repID}.ObservLabelTest(eIdx))./length(SensorResults{1, repID}.ObservLabelTest(eIdx))];
        result_ours{eventID} = [result_ours{eventID},sum(estimation2{repID}(eIdx)==SensorResults{1, repID}.ObservLabelTest(eIdx))./length(SensorResults{1, repID}.ObservLabelTest(eIdx))];
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
% subplot(2,1,1);
resultTotal = [tableAvg; floorAvg; currentAvg; ourAvg];
resultTotalNew = [];
displayOrder = [1,2,3,9,4,5,6,7,8]
for i  = 1:9
    resultTotalNew = [resultTotalNew, resultTotal(:,displayOrder(i))];
end
bar(resultTotalNew');%tableAvg; floorAvg; 
xticklabels({'OK', 'K', 'OM','MD','M','PS','S','V','Step'});

return;
%%
for eventID = 1:length(eventIDMatch2)
    result_table_level2{eventID} = [];
    result_floor_level2{eventID} = [];
    result_current_level2{eventID} = [];
    result_ours_level2{eventID} = [];
    
    for repID = 1:5
        eIdx = eventTypeIdx2{repID, eventID};
        result_table_level2{eventID} = [result_table_level2{eventID},sum(sen2{1,repID}(eIdx)==gt2{repID}(eIdx))./length(gt2{repID}(eIdx))];
        result_floor_level2{eventID} = [result_floor_level2{eventID},sum(sen2{2,repID}(eIdx)==gt2{repID}(eIdx))./length(gt2{repID}(eIdx))];
        result_current_level2{eventID} = [result_current_level2{eventID},sum(sen2{3,repID}(eIdx)==gt2{repID}(eIdx))./length(gt2{repID}(eIdx))];
        result_ours_level2{eventID} = [result_ours_level2{eventID},sum(est2{repID}(eIdx)==gt2{repID}(eIdx))./length(gt2{repID}(eIdx))];
    end
end

tableAvg = ones(1,length(eventIDMatch2));
floorAvg = ones(1,length(eventIDMatch2));
currentAvg = ones(1,length(eventIDMatch2));
% v2Avg = ones(1,length(eventIDMatch));
ourAvg = ones(1,length(eventIDMatch2));
for eventID = 1:length(eventIDMatch2)
    tableAvg(eventID) = mean(result_table_level2{eventID}(~isnan(result_table_level2{eventID})));
    floorAvg(eventID) = mean(result_floor_level2{eventID}(~isnan(result_floor_level2{eventID})));
    currentAvg(eventID) = mean(result_current_level2{eventID}(~isnan(result_current_level2{eventID})));
    ourAvg(eventID) = mean(result_ours_level2{eventID}(~isnan(result_ours_level2{eventID})));
end
% figure;

subplot(2,1,2);
bar([tableAvg; floorAvg; currentAvg; ourAvg]');%tableAvg; floorAvg; 
xticklabels({'K', 'M','S','V','Step'});
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
meanFuse2L2 = mean(accFuse_level2);
meanFuse2L3 = mean(accFuse_level3);
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

figure;
bar([meanFuse2 meanFuse2L2 meanFuse2L3]');
% xticklabels({'Level1','Level2'});
ylabel('Window-level Activity Recognition Accuracy');
xlabel('Activity Granularity Level');
% bar([meanTable, meanFloor, meanCurrent, meanFuse; meanTable2, meanFloor2, meanCurrent2, meanFuse2]');
% hold on;
% errorbar([meanTable2, meanFloor2, meanCurrent2, meanFuse_cf,meanFuse_ce,meanFuse_fe,  meanFuse2], [stdTable, stdFloor, stdCurrent,stdFuse_cf,stdFuse_ce,stdFuse_fe, stdFuse]);
xlim([0.5,3.5]);
ylim([0,1]);

