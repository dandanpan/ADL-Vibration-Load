%% Table 
init;
for sensorID = 1:3
    if sensorID == 1
        load('feature_table.mat');
        P1_Feature = FeatureSet(2:6);
        load('feature_table_4act.mat');
        P1_Feature = [P1_Feature, FeatureSet([1,2,6,7,8])];
    elseif sensorID == 2
        load('feature_floor.mat');
        P1_Feature = FeatureSet(2:6);
        load('feature_floor_4act.mat');
        P1_Feature = [P1_Feature, FeatureSet([1,2,6,7,8])];
    elseif sensorID == 3
        load('feature_current.mat');
        P1_Feature = FeatureSet(2:6);
        load('feature_current_4act.mat');
        P1_Feature = [P1_Feature, FeatureSet([1,2,6,7,8])];
    end
    
    numClass = 14;
    trialNum = 5;
    totalRound = length(P1_Feature)/trialNum;
    for testingSet = 1:trialNum
        testingSet
        trainFeature = [];
        trainFeature2 = [];
        trainFeature3 = [];
        trainLabel = [];
        testFeature = [];
        testFeature2 = [];
        testFeature3 = [];
        testLabel = [];

        for repID = 1:trialNum
            if repID == testingSet
                for roundID = 1:totalRound
                    testFeature = [testFeature; P1_Feature{repID+trialNum*(roundID-1)}.Feature];
                    testFeature2 = [testFeature2; P1_Feature{repID+trialNum*(roundID-1)}.Feature, P1_Feature{repID+trialNum*(roundID-1)}.Feature2];
%                     testFeature3 = [testFeature3; P1_Feature{repID+trialNum*(roundID-1)}.Feature, P1_Feature{repID+trialNum*(roundID-1)}.Feature2, P1_Feature{repID+trialNum*(roundID-1)}.Feature3];
                    testLabel = [testLabel; P1_Feature{repID+trialNum*(roundID-1)}.Label];
                end
            else
                for roundID = 1:totalRound
                    trainFeature = [trainFeature;P1_Feature{repID+trialNum*(roundID-1)}.Feature];
                    trainFeature2 = [trainFeature2;P1_Feature{repID+trialNum*(roundID-1)}.Feature, P1_Feature{repID+trialNum*(roundID-1)}.Feature2];
%                     trainFeature3 = [trainFeature3;P1_Feature{repID+trialNum*(roundID-1)}.Feature, P1_Feature{repID+trialNum*(roundID-1)}.Feature2, P1_Feature{repID+trialNum*(roundID-1)}.Feature3];
                    trainLabel = [trainLabel; P1_Feature{repID+trialNum*(roundID-1)}.Label];
                end
            end
        end

        blackListEventIdx = find(trainLabel == 6 | trainLabel == 9 | trainLabel == 11 | trainLabel == 12 | trainLabel == 13);
        blackListEventIdx2 = find(testLabel == 6 | testLabel == 9 | testLabel == 11 | testLabel == 12 | testLabel == 13);
        whiteListEventIdx = find(trainLabel ~= 6 & trainLabel ~= 9 & trainLabel ~= 11 & trainLabel ~= 12 & trainLabel ~= 13);
        whiteListEventIdx2 = find(testLabel ~= 6 & testLabel ~= 9 & testLabel ~= 11 & testLabel ~= 12 & testLabel ~= 13);
        trainLabel(blackListEventIdx) = [];
        testLabel(blackListEventIdx2) = [];
        trainFeature(blackListEventIdx,:) = [];
        trainFeature2(blackListEventIdx,:) = [];
%         trainFeature3(blackListEventIdx,:) = [];
        testFeature(blackListEventIdx2,:) = [];
        testFeature2(blackListEventIdx2,:) = [];
%         testFeature3(blackListEventIdx2,:) = [];

        [ svmstruct, gi ] = svmTrainModel( trainLabel, trainFeature );
        [predicted_label, accuracy, decision_values] = svmpredict(testLabel, testFeature, svmstruct,'-b 1');
        [ svmstruct2, gi ] = svmTrainModel( trainLabel, trainFeature2 )
        [predicted_label2, accuracy2, decision_values2] = svmpredict(testLabel, testFeature2, svmstruct2,'-b 1');
%         [ svmstruct3, gi ] = svmTrainModel( trainLabel, trainFeature3 )
%         [predicted_label3, accuracy3, decision_values3] = svmpredict(testLabel, testFeature3, svmstruct3,'-b 1');

        Results{testingSet}.predicted_label = predicted_label;
        Results{testingSet}.accuracy = accuracy;
        Results{testingSet}.decision_values = decision_values;
        Results{testingSet}.predicted_label2 = predicted_label2;
        Results{testingSet}.accuracy2 = accuracy2;
        Results{testingSet}.decision_values2 = decision_values2;
        Results{testingSet}.blackListEventIdx = blackListEventIdx;
        Results{testingSet}.blackListEventIdx2 = blackListEventIdx2;
        Results{testingSet}.whiteListEventIdx = whiteListEventIdx;
        Results{testingSet}.whiteListEventIdx2 = whiteListEventIdx2;
        
%         Results{testingSet}.predicted_label3 = predicted_label3;
%         Results{testingSet}.accuracy3 = accuracy3;
%         Results{testingSet}.decision_values3 = decision_values3;
        Results{testingSet}.label = testLabel;

        [ cMatrix ] = estimateConfusionMatrix( predicted_label, testLabel, numClass );
        [ cMatrix2 ] = estimateConfusionMatrix( predicted_label2, testLabel, numClass );
%         [ cMatrix3 ] = estimateConfusionMatrix( predicted_label3, testLabel, numClass );

        Results{testingSet}.cMatrix = cMatrix;
        Results{testingSet}.cMatrix2 = cMatrix2;
%         Results{testingSet}.cMatrix3 = cMatrix3;
    end
    
    if sensorID == 1
        save('eval_table_p1.mat','Results');
    elseif sensorID == 2
        save('eval_floor_p1.mat','Results');
    elseif sensorID == 3
        save('eval_current_p1.mat','Results');
    end
    
    totalM1 = Results{1}.cMatrix;
    totalM2 = Results{1}.cMatrix2;
%     totalM3 = Results{1}.cMatrix3;

    for repID = 2:5
        totalM1 = totalM1 + Results{repID}.cMatrix;
        totalM2 = totalM2 + Results{repID}.cMatrix2;
%         totalM3 = totalM3 + Results{repID}.cMatrix3;
    end

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
    % figure;
    % plotConfMat(totalM1, {'OK', 'K', 'OM','M','PS','OS','S','V','SF','Step','Mis','Sync','null','MD'});
    figure;
    plotConfMat(totalM2, {'OK', 'K', 'OM','M','PS','OS','S','V','SF','Step','Mis','Sync','null','MD'});
    % figure;
    % plotConfMat(totalM3, {'OK', 'K', 'OM','M','PS','OS','S','V','SF','Step','Mis','Sync','null','MD'});
end

return;
%% Floor 
init;
load('feature_floor.mat');
P1_Feature = FeatureSet(2:6);
load('feature_floor_4act.mat');
P1_Feature = [P1_Feature, FeatureSet([1,2,6,7,8])];
numClass = 14;


for testingSet = 2:6
    testingSet
    trainFeature = [];
    trainFeature2 = [];
    trainFeature3 = [];
    trainLabel = [];
    testFeature = [];
    testFeature2 = [];
    testFeature3 = [];
    testLabel = [];
    
    for repID = 2:6
        if repID == testingSet
            testFeature = P1_Feature{repID}.Feature;
            testFeature2 = [testFeature, P1_Feature{repID}.Feature2];
            testFeature3 = [testFeature2, P1_Feature{repID}.Feature3];
            testLabel = [testLabel; P1_Feature{repID}.Label];
        else
            trainFeature = [trainFeature;P1_Feature{repID}.Feature];
            trainFeature2 = [trainFeature2;P1_Feature{repID}.Feature, P1_Feature{repID}.Feature2];
            trainFeature3 = [trainFeature3;P1_Feature{repID}.Feature, P1_Feature{repID}.Feature2, P1_Feature{repID}.Feature3];
            trainLabel = [trainLabel; P1_Feature{repID}.Label];
        end
    end
    [ svmstruct, gi ] = svmTrainModel( trainLabel, trainFeature )
    [predicted_label, accuracy, decision_values] = svmpredict(testLabel, testFeature, svmstruct,'-b 1');
    [ svmstruct2, gi ] = svmTrainModel( trainLabel, trainFeature2 )
    [predicted_label2, accuracy2, decision_values2] = svmpredict(testLabel, testFeature2, svmstruct2,'-b 1');
    [ svmstruct3, gi ] = svmTrainModel( trainLabel, trainFeature3 )
    [predicted_label3, accuracy3, decision_values3] = svmpredict(testLabel, testFeature3, svmstruct3,'-b 1');

    Results{testingSet}.predicted_label = predicted_label;
    Results{testingSet}.accuracy = accuracy;
    Results{testingSet}.decision_values = decision_values;
    Results{testingSet}.predicted_label2 = predicted_label2;
    Results{testingSet}.accuracy2 = accuracy2;
    Results{testingSet}.decision_values2 = decision_values2;
    Results{testingSet}.predicted_label3 = predicted_label3;
    Results{testingSet}.accuracy3 = accuracy3;
    Results{testingSet}.decision_values3 = decision_values3;
    Results{testingSet}.label = testLabel;

    [ cMatrix ] = estimateConfusionMatrix( predicted_label, testLabel, numClass );
    [ cMatrix2 ] = estimateConfusionMatrix( predicted_label2, testLabel, numClass );
    [ cMatrix3 ] = estimateConfusionMatrix( predicted_label3, testLabel, numClass );

    Results{testingSet}.cMatrix = cMatrix;
    Results{testingSet}.cMatrix2 = cMatrix2;
    Results{testingSet}.cMatrix3 = cMatrix3;
end

save('eval_floor.mat','Results');
save('feature_floor.mat','P1_Feature');

%
totalM1 = Results{2}.cMatrix;
totalM2 = Results{2}.cMatrix2;
totalM3 = Results{2}.cMatrix3;
for repID = 3:6
    totalM1 = totalM1 + Results{repID}.cMatrix;
    totalM2 = totalM2 + Results{repID}.cMatrix2;
    totalM3 = totalM3 + Results{repID}.cMatrix3;
end

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
addpath('./plotConfMat/');
figure;
plotConfMat(totalM1, {'OK', 'K', 'OM','M','PS','OS','S','V','SF','Step','Mis','Sync','null','MD'});
figure;
plotConfMat(totalM2, {'OK', 'K', 'OM','M','PS','OS','S','V','SF','Step','Mis','Sync','null','MD'});
figure;
plotConfMat(totalM3, {'OK', 'K', 'OM','M','PS','OS','S','V','SF','Step','Mis','Sync','null','MD'});

%% Current 
init;

load('P1.mat');
personID = 1;
numClass = 14;

for repID = [2:6]
    repID
    load(['/Users/shijiapan/Box Sync/Activity_Detection/0407/PortLab_20190407_Route_P' num2str(personID) '_Rep' num2str(repID) '.mat']);
    P1_Feature{repID}.Feature = [];
    P1_Feature{repID}.Feature2 = [];
    P1_Feature{repID}.Feature3 = [];
    P1_Feature{repID}.Label = [];
    
    % for each event, find out ground truth
    
    for eventID = 1:length(Currents{repID}.stepStartIdxArray)
        eventID
        gt_labels = Label{repID}.label_array(Currents{repID}.stepStartIdxArray(eventID):Currents{repID}.stepStopIdxArray(eventID));
        the_label = mode(gt_labels(gt_labels > 0));
        if isnan(the_label)
            the_label = 11;
        end
        
        tempSig = data(3,Currents{repID}.stepStartIdxArray(eventID):Currents{repID}.stepStopIdxArray(eventID));
        tempSigStd = std(tempSig);
        tempSig = signalNormalization(tempSig);
        
        tempSig2 = data(4,Currents{repID}.stepStartIdxArray(eventID):Currents{repID}.stepStopIdxArray(eventID));
        tempSig2 = signalNormalization(tempSig2);
        tempFea2 = frequencyFeature( tempSig2, Fs, 0, 10 );
        
        tempFea = frequencyFeature( tempSig, Fs, 0, 10 );
        P1_Feature{repID}.Feature = [P1_Feature{repID}.Feature; tempFea(1:200,2)', tempSigStd];
        P1_Feature{repID}.Feature2 = [P1_Feature{repID}.Feature2; tempFea2(1:200,2)'];
        P1_Feature{repID}.Label = [P1_Feature{repID}.Label; the_label];      
    end
end

% SVM
for testingSet = 2:6
    testingSet
    trainFeature = [];
    trainFeature2 = [];
    trainFeature3 = [];
    trainLabel = [];
    testFeature = [];
    testFeature2 = [];
    testFeature3 = [];
    testLabel = [];
    
    for repID = 2:6
        if repID == testingSet
            testFeature = P1_Feature{repID}.Feature;
            testFeature2 = [testFeature, P1_Feature{repID}.Feature2];
            testLabel = [testLabel; P1_Feature{repID}.Label];
        else
            trainFeature = [trainFeature;P1_Feature{repID}.Feature];
            trainFeature2 = [trainFeature2;P1_Feature{repID}.Feature, P1_Feature{repID}.Feature2];
            trainLabel = [trainLabel; P1_Feature{repID}.Label];
        end
    end
    [ svmstruct, gi ] = svmTrainModel( trainLabel, trainFeature )
    [predicted_label, accuracy, decision_values] = svmpredict(testLabel, testFeature, svmstruct,'-b 1');
    [ svmstruct2, gi ] = svmTrainModel( trainLabel, trainFeature2 )
    [predicted_label2, accuracy2, decision_values2] = svmpredict(testLabel, testFeature2, svmstruct2,'-b 1');
    
    Results{testingSet}.predicted_label = predicted_label;
    Results{testingSet}.accuracy = accuracy;
    Results{testingSet}.decision_values = decision_values;
    Results{testingSet}.label = testLabel;
    
    Results{testingSet}.predicted_label2 = predicted_label2;
    Results{testingSet}.accuracy2 = accuracy2;
    Results{testingSet}.decision_values2 = decision_values2;

    [ cMatrix ] = estimateConfusionMatrix( predicted_label, testLabel, numClass );
    [ cMatrix2 ] = estimateConfusionMatrix( predicted_label2, testLabel, numClass );

    Results{testingSet}.cMatrix = cMatrix;
    Results{testingSet}.cMatrix2 = cMatrix2;
end
save('eval_current.mat','Results');
save('feature_current.mat','P1_Feature');

%
totalM1 = Results{2}.cMatrix;
totalM2 = Results{2}.cMatrix2;
for repID = 3:6
    totalM1 = totalM1 + Results{repID}.cMatrix;
    totalM2 = totalM2 + Results{repID}.cMatrix2;
end

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
addpath('./plotConfMat/');
figure;
plotConfMat(totalM1, {'OK', 'K', 'OM','M','PS','OS','S','V','SF','Step','Mis','Sync','null','MD'});
figure;
plotConfMat(totalM2, {'OK', 'K', 'OM','M','PS','OS','S','V','SF','Step','Mis','Sync','null','MD'});
