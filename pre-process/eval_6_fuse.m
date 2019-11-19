init;

load('eval_current.mat');
Result_Current = Results(2:6);
load('eval_current_4act.mat');
Result_Current = [Result_Current, Results];

load('eval_table.mat');
Result_Table = Results(2:6);
load('eval_table_4act.mat');
Result_Table = [Result_Table, Results];

load('eval_floor.mat');
Result_Floor = Results(2:6);
load('eval_floor_4act.mat');
Result_Floor = [Result_Floor, Results];

numClass  = 12;
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

   
for repID = 1:10
    for eventType = 1:10
        eventTypeIdx{repID, eventType} = [];
    end
    estimation{repID} = [];
    estimation2{repID} = [];
    estimation_cf{repID} = [];
    estimation_ce{repID} = [];
    estimation_fe{repID} = [];
    
    windowNum = length(Result_Current{repID}.ObservLabelTest);
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
        
        if Result_Table{repID}.ObservPrediTest(windowID) ~= nullClass
            scores = [scores, Result_Table{repID}.ObservPrediScore(windowID)];
            values = [values, Result_Table{repID}.ObservPrediTest(windowID)];
        end
        if Result_Floor{repID}.ObservPrediTest(windowID) ~= nullClass
            scores = [scores, Result_Floor{repID}.ObservPrediScore(windowID)];
            values = [values, Result_Floor{repID}.ObservPrediTest(windowID)];
        end
        if Result_Current{repID}.ObservPrediTest(windowID) ~= nullClass
            scores = [scores, Result_Current{repID}.ObservPrediScore(windowID)];
            values = [values, Result_Current{repID}.ObservPrediTest(windowID)];
        end
        
        if Result_Table{repID}.ObservPrediTest2(windowID) ~= nullClass
            scores2 = [scores2, Result_Table{repID}.ObservPrediScore2(windowID)];
            values2 = [values2, Result_Table{repID}.ObservPrediTest2(windowID)];
            scores_ce = [scores_ce, Result_Table{repID}.ObservPrediScore2(windowID)];
            scores_cf = [scores_cf, Result_Table{repID}.ObservPrediScore2(windowID)];
            values_ce = [values_ce, Result_Table{repID}.ObservPrediTest2(windowID)];
            values_cf = [values_cf, Result_Table{repID}.ObservPrediTest2(windowID)];
        end
        if Result_Floor{repID}.ObservPrediTest2(windowID) ~= nullClass
            scores2 = [scores2, Result_Floor{repID}.ObservPrediScore2(windowID)];
            values2 = [values2, Result_Floor{repID}.ObservPrediTest2(windowID)];
            scores_cf = [scores_cf, Result_Floor{repID}.ObservPrediScore2(windowID)];
            values_cf = [values_cf, Result_Floor{repID}.ObservPrediTest2(windowID)];
            scores_fe = [scores_fe, Result_Floor{repID}.ObservPrediScore2(windowID)];
            values_fe = [values_fe, Result_Floor{repID}.ObservPrediTest2(windowID)];
        end
        if Result_Current{repID}.ObservPrediTest2(windowID) ~= nullClass
            scores2 = [scores2, Result_Current{repID}.ObservPrediScore2(windowID)];
            values2 = [values2, Result_Current{repID}.ObservPrediTest2(windowID)];
            scores_ce = [scores_ce, Result_Current{repID}.ObservPrediScore2(windowID)];
            values_ce = [values_ce, Result_Current{repID}.ObservPrediTest2(windowID)];
            scores_fe = [scores_fe, Result_Current{repID}.ObservPrediScore2(windowID)];
            values_fe = [values_fe, Result_Current{repID}.ObservPrediTest2(windowID)];
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
        
        if Result_Table{repID}.ObservPrediTest(windowID) == 1
            scores2
            values2
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
    
%     figure;
%     subplot(4,1,1);
%     plot(Result_Current{repID}.ObservLabelTest); ylim([0,15]);hold on;
%     plot(Result_Current{repID}.ObservPrediTest); ylim([0,15]);
% %     plot(Result_Current{repID}.ObservPrediScore.*5); ylim([0,15]);
%     subplot(4,1,2);
%     plot(Result_Table{repID}.ObservLabelTest); ylim([0,15]);hold on;
%     plot(Result_Table{repID}.ObservPrediTest); ylim([0,15]);
% %     plot(Result_Table{repID}.ObservPrediScore.*5); ylim([0,15]);
%     subplot(4,1,3);
%     plot(Result_Floor{repID}.ObservLabelTest); ylim([0,15]);hold on;
%     plot(Result_Floor{repID}.ObservPrediTest); ylim([0,15]);
% %     plot(Result_Floor{repID}.ObservPrediScore.*5); ylim([0,15]);
%     subplot(4,1,4);
%     plot(Result_Table{repID}.ObservLabelTest); ylim([0,15]);hold on;
%     plot(estimation{repID}); ylim([0,15]);
%     plot(estimation2{repID}); ylim([0,15]);
    
    eventIdx = find(Result_Table{repID}.ObservLabelTest ~= 6 & ...
                     Result_Table{repID}.ObservLabelTest ~= 9 & ...
                     Result_Table{repID}.ObservLabelTest ~= 11 & ...
                     Result_Table{repID}.ObservLabelTest ~= 12 & ...
                     Result_Table{repID}.ObservLabelTest ~= 13);
                 
    eventIDMatch = [1:5,7,8,10,14];
    for eventType = 1:length(eventIDMatch)
        eventTypeIdx{repID, eventType} = [eventTypeIdx{repID, eventType}, find(Result_Table{repID}.ObservLabelTest == eventIDMatch(eventType))];
    end
    
    accFuse = [accFuse, sum(estimation{repID}(eventIdx)==Result_Table{repID}.ObservLabelTest(eventIdx))./length(Result_Table{repID}.ObservLabelTest(eventIdx))];
    accTable = [accTable, sum(Result_Table{repID}.ObservPrediTest(eventIdx)==Result_Table{repID}.ObservLabelTest(eventIdx))./length(Result_Table{repID}.ObservLabelTest(eventIdx))];
    accFloor = [accFloor, sum(Result_Floor{repID}.ObservPrediTest(eventIdx)==Result_Table{repID}.ObservLabelTest(eventIdx))./length(Result_Table{repID}.ObservLabelTest(eventIdx))];
    accCurrent = [accCurrent, sum(Result_Current{repID}.ObservPrediTest(eventIdx)==Result_Table{repID}.ObservLabelTest(eventIdx))./length(Result_Table{repID}.ObservLabelTest(eventIdx))];
    
    accFuse2 = [accFuse2, sum(estimation2{repID}(eventIdx)==Result_Table{repID}.ObservLabelTest(eventIdx))./length(Result_Table{repID}.ObservLabelTest(eventIdx))];
    accFuse_ce = [accFuse_ce, sum(estimation_ce{repID}(eventIdx)==Result_Table{repID}.ObservLabelTest(eventIdx))./length(Result_Table{repID}.ObservLabelTest(eventIdx))];
    accFuse_cf = [accFuse_cf, sum(estimation_cf{repID}(eventIdx)==Result_Table{repID}.ObservLabelTest(eventIdx))./length(Result_Table{repID}.ObservLabelTest(eventIdx))];
    accFuse_fe = [accFuse_fe, sum(estimation_fe{repID}(eventIdx)==Result_Table{repID}.ObservLabelTest(eventIdx))./length(Result_Table{repID}.ObservLabelTest(eventIdx))];
    accTable2 = [accTable2, sum(Result_Table{repID}.ObservPrediTest2(eventIdx)==Result_Table{repID}.ObservLabelTest(eventIdx))./length(Result_Table{repID}.ObservLabelTest(eventIdx))];
    accFloor2 = [accFloor2, sum(Result_Floor{repID}.ObservPrediTest2(eventIdx)==Result_Table{repID}.ObservLabelTest(eventIdx))./length(Result_Table{repID}.ObservLabelTest(eventIdx))];
    accCurrent2 = [accCurrent2, sum(Result_Current{repID}.ObservPrediTest2(eventIdx)==Result_Table{repID}.ObservLabelTest(eventIdx))./length(Result_Table{repID}.ObservLabelTest(eventIdx))];
    
end

%%
for eventID = 1:length(eventIDMatch)
    result_table{eventID} = [];
    result_floor{eventID} = [];
    result_current{eventID} = [];
    result_v2{eventID} = [];
    result_ours{eventID} = [];
    
    for repID = 1:10
        eIdx = eventTypeIdx{repID, eventID};
        result_table{eventID} = [result_table{eventID},sum(Result_Table{repID}.ObservPrediTest2(eIdx)==Result_Table{repID}.ObservLabelTest(eIdx))./length(Result_Table{repID}.ObservLabelTest(eIdx))];
        result_floor{eventID} = [result_floor{eventID},sum(Result_Floor{repID}.ObservPrediTest2(eIdx)==Result_Table{repID}.ObservLabelTest(eIdx))./length(Result_Table{repID}.ObservLabelTest(eIdx))];
        result_current{eventID} = [result_current{eventID},sum(Result_Current{repID}.ObservPrediTest2(eIdx)==Result_Table{repID}.ObservLabelTest(eIdx))./length(Result_Table{repID}.ObservLabelTest(eIdx))];
        result_v2{eventID} = [result_v2{eventID},sum(estimation_cf{repID}(eIdx)==Result_Table{repID}.ObservLabelTest(eIdx))./length(Result_Table{repID}.ObservLabelTest(eIdx))];
        result_ours{eventID} = [result_ours{eventID},sum(estimation2{repID}(eIdx)==Result_Table{repID}.ObservLabelTest(eIdx))./length(Result_Table{repID}.ObservLabelTest(eIdx))];
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
bar([currentAvg; v2Avg; ourAvg]');%tableAvg; floorAvg; 
xticklabels({'OK', 'K', 'OM','M','PS','S','V','Step','MD'});


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