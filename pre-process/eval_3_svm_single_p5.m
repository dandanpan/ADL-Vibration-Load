init;
for sensorID = 1:3
    if sensorID == 1
        load('feature_table_p1.mat');
        PFeature = FeatureSet(2:6);
        load('feature_table_p1_4act.mat');
        PFeature = [PFeature, FeatureSet([1,2,6,7,8])];
        load('feature_table_p2.mat');
        PFeature = [PFeature, FeatureSet([1:4,8])];
        load('feature_table_p2_4act.mat');
        PFeature = [PFeature, FeatureSet([1,5,6,8,9])];
    elseif sensorID == 2
        load('feature_floor_p1.mat');
        PFeature = FeatureSet(2:6);
        load('feature_floor_p1_4act.mat');
        PFeature = [PFeature, FeatureSet([1,2,6,7,8])];
        load('feature_floor_p2.mat');
        PFeature = [PFeature, FeatureSet([1:4,8])];
        load('feature_floor_p2_4act.mat');
        PFeature = [PFeature, FeatureSet([1,5,6,8,9])];
    elseif sensorID == 3
        load('feature_current_p1.mat');
        PFeature = FeatureSet(2:6);
        load('feature_current_p1_4act.mat');
        PFeature = [PFeature, FeatureSet([1,2,6,7,8])];
        load('feature_current_p2.mat');
        PFeature = [PFeature, FeatureSet([1:4,8])];
        load('feature_current_p2_4act.mat');
        PFeature = [PFeature, FeatureSet([1,5,6,8,9])];
    end
    
    if sensorID == 1
        load('feature_table_p5.mat');
        TFeature = FeatureSet([3,4,5,9,10]);
    elseif sensorID == 2
        load('feature_floor_p5.mat');
        TFeature = FeatureSet([3,4,5,9,10]);
    elseif sensorID == 3
        load('feature_current_p5.mat');
        TFeature = FeatureSet([3,4,5,9,10]);
    end
    
    numClass = 14;
    trialNum = 5;
    totalRound = length(PFeature);
    
    % training
    trainFeature = [];
    trainFeature2 = [];
    trainLabel = [];

    for repID = 1:totalRound
        trainFeature = [trainFeature;PFeature{repID}.Feature];
        trainFeature2 = [trainFeature2;PFeature{repID}.Feature, PFeature{repID}.Feature2];
        trainLabel = [trainLabel; PFeature{repID}.Label]; 
    end
    
    blackListEventIdx = find(trainLabel == 6 | trainLabel == 9 | trainLabel == 11 | trainLabel == 12 | trainLabel == 13);
    whiteListEventIdx = find(trainLabel ~= 6 & trainLabel ~= 9 & trainLabel ~= 11 & trainLabel ~= 12 & trainLabel ~= 13);
    trainLabel(blackListEventIdx) = [];
    trainFeature(blackListEventIdx,:) = [];
    trainFeature2(blackListEventIdx,:) = [];
                     
    % testing
    testFeature = [];
    testFeature2 = [];
    testLabel = [];
    
    totalRound = length(TFeature);

    for repID = 1:totalRound
        testFeature = [testFeature; TFeature{repID}.Feature];
        testFeature2 = [testFeature2; TFeature{repID}.Feature, TFeature{repID}.Feature2];
        testLabel = [testLabel; TFeature{repID}.Label];
    end

    blackListEventIdx2 = find(testLabel == 6 | testLabel == 9 | testLabel == 11 | testLabel == 12 | testLabel == 13);
    whiteListEventIdx2 = find(testLabel ~= 6 & testLabel ~= 9 & testLabel ~= 11 & testLabel ~= 12 & testLabel ~= 13);
    testLabel(blackListEventIdx2) = [];
    testFeature(blackListEventIdx2,:) = [];
    testFeature2(blackListEventIdx2,:) = [];

    [ svmstruct, gi ] = svmTrainModel( trainLabel, trainFeature );
    [predicted_label, accuracy, decision_values] = svmpredict(testLabel, testFeature, svmstruct,'-b 1');
    [ svmstruct2, gi ] = svmTrainModel( trainLabel, trainFeature2 )
    [predicted_label2, accuracy2, decision_values2] = svmpredict(testLabel, testFeature2, svmstruct2,'-b 1');

    Result.predicted_label = predicted_label;
    Result.accuracy = accuracy;
    Result.decision_values = decision_values;
    Result.predicted_label2 = predicted_label2;
    Result.accuracy2 = accuracy2;
    Result.decision_values2 = decision_values2;
    Result.blackListEventIdx = blackListEventIdx;
    Result.blackListEventIdx2 = blackListEventIdx2;
    Result.whiteListEventIdx = whiteListEventIdx;
    Result.whiteListEventIdx2 = whiteListEventIdx2;
    Result.label = testLabel;

    [ cMatrix ] = estimateConfusionMatrix( predicted_label, testLabel, numClass );
    [ cMatrix2 ] = estimateConfusionMatrix( predicted_label2, testLabel, numClass );

    Result.cMatrix = cMatrix;
    Result.cMatrix2 = cMatrix2;
    
    if sensorID == 1
        save('eval_table_p5.mat','Result');
    elseif sensorID == 2
        save('eval_floor_p5.mat','Result');
    elseif sensorID == 3
        save('eval_current_p5.mat','Result');
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
    plotConfMat(cMatrix2, {'OK', 'K', 'OM','M','PS','OS','S','V','SF','Step','Mis','Sync','null','MD'});
    % figure;
    % plotConfMat(totalM3, {'OK', 'K', 'OM','M','PS','OS','S','V','SF','Step','Mis','Sync','null','MD'});
end

