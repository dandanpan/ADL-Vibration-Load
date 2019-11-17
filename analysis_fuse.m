clear;
close all;
clc;

load('result_SVM_current.mat');
Result_Current = Results;

load('result_SVM_Table.mat');
Result_Table = Results;

load('result_SVM_floor.mat');
Result_Floor = Results;

for repID = 2:6
    groundTruth{repID} = [];
    for windowID = 1:length(Result_Current{repID}.ObservLabelTest)
        tempTruth = [];
        if Result_Table{repID}.ObservLabelTest(windowID) ~= 9
            tempTruth = [tempTruth, Result_Table{repID}.ObservLabelTest(windowID)];
        end
        if Result_Floor{repID}.ObservLabelTest(windowID) ~= 9
            tempTruth = [tempTruth, Result_Floor{repID}.ObservLabelTest(windowID)];
        end
        if Result_Current{repID}.ObservLabelTest(windowID) ~= 9
            tempTruth = [tempTruth, Result_Current{repID}.ObservLabelTest(windowID)];
        end
        if isempty(tempTruth)
            groundTruth{repID} = [groundTruth{repID}, 9];
        else
            groundTruth{repID} = [groundTruth{repID}, mode(tempTruth)];
        end
    end
%     figure;
%     subplot(4,1,1);
%     plot(Result_Current{repID}.ObservLabelTest); ylim([0,10]);
%     subplot(4,1,2);
%     plot(Result_Table{repID}.ObservLabelTest); ylim([0,10]);
%     subplot(4,1,3);
%     plot(Result_Floor{repID}.ObservLabelTest); ylim([0,10]);
%     subplot(4,1,4);
%     plot(groundTruth{repID}); ylim([0,10]);
end

%%
accFuse = [];
accTable = [];
accFuseTable = [];
accTableTable = [];
accFloor = [];
accCurrent = [];
for repID = 2:6
    estimation{repID} = [];
    for windowID = 1:length(Result_Current{repID}.ObservLabelTest)
        scores = [];
        values = [];
        if Result_Table{repID}.ObservPrediTest(windowID) ~= 9
            scores = [scores, Result_Table{repID}.ObservPrediScore(windowID)];
            values = [values, Result_Table{repID}.ObservPrediTest(windowID)];
        end
        if Result_Floor{repID}.ObservPrediTest(windowID) ~= 9
            scores = [scores, Result_Floor{repID}.ObservPrediScore(windowID)];
            values = [values, Result_Floor{repID}.ObservPrediTest(windowID)];
        end
        if Result_Current{repID}.ObservPrediTest(windowID) ~= 9
            scores = [scores, Result_Current{repID}.ObservPrediScore(windowID)];
            values = [values, Result_Current{repID}.ObservPrediTest(windowID)];
        end
        if isempty(scores)
            estimation{repID} = [estimation{repID}, 9];
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
    end
    
    figure;
    subplot(4,1,1);
    plot(Result_Current{repID}.ObservLabelTest); ylim([0,10]);hold on;
    plot(Result_Current{repID}.ObservPrediTest); ylim([0,10]);
    plot(Result_Current{repID}.ObservPrediScore.*5); ylim([0,10]);
    subplot(4,1,2);
    plot(Result_Table{repID}.ObservLabelTest); ylim([0,10]);hold on;
    plot(Result_Table{repID}.ObservPrediTest); ylim([0,10]);
    plot(Result_Table{repID}.ObservPrediScore.*5); ylim([0,10]);
    subplot(4,1,3);
    plot(Result_Floor{repID}.ObservLabelTest); ylim([0,10]);hold on;
    plot(Result_Floor{repID}.ObservPrediTest); ylim([0,10]);
    plot(Result_Floor{repID}.ObservPrediScore.*5); ylim([0,10]);
    subplot(4,1,4);
    plot(groundTruth{repID}); ylim([0,10]);hold on;
    plot(estimation{repID}); ylim([0,10]);
    
    accFuse = [accFuse, sum(estimation{repID}==groundTruth{repID})./length(groundTruth{repID})];
    accTable = [accTable, sum(Result_Table{repID}.ObservPrediTest==groundTruth{repID})./length(groundTruth{repID})];
    accFloor = [accFloor, sum(Result_Floor{repID}.ObservPrediTest==groundTruth{repID})./length(groundTruth{repID})];
    accCurrent = [accCurrent, sum(Result_Current{repID}.ObservPrediTest==groundTruth{repID})./length(groundTruth{repID})];
    
end

accFuse
accTable
accFloor
accCurrent

