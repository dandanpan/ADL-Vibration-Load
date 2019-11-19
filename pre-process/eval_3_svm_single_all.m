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
    
    numClass = 14;
    trialNum = 5;
    totalRound = length(PFeature)/trialNum;
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
                    testFeature = [testFeature; PFeature{repID+trialNum*(roundID-1)}.Feature];
                    testFeature2 = [testFeature2; PFeature{repID+trialNum*(roundID-1)}.Feature, PFeature{repID+trialNum*(roundID-1)}.Feature2];
%                     testFeature3 = [testFeature3; P1_Feature{repID+trialNum*(roundID-1)}.Feature, P1_Feature{repID+trialNum*(roundID-1)}.Feature2, P1_Feature{repID+trialNum*(roundID-1)}.Feature3];
                    testLabel = [testLabel; PFeature{repID+trialNum*(roundID-1)}.Label];
                end
            else
                for roundID = 1:totalRound
                    trainFeature = [trainFeature;PFeature{repID+trialNum*(roundID-1)}.Feature];
                    trainFeature2 = [trainFeature2;PFeature{repID+trialNum*(roundID-1)}.Feature, PFeature{repID+trialNum*(roundID-1)}.Feature2];
%                     trainFeature3 = [trainFeature3;P1_Feature{repID+trialNum*(roundID-1)}.Feature, P1_Feature{repID+trialNum*(roundID-1)}.Feature2, P1_Feature{repID+trialNum*(roundID-1)}.Feature3];
                    trainLabel = [trainLabel; PFeature{repID+trialNum*(roundID-1)}.Label];
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
        
        predicted_label(predicted_label == 1) = 2;
        predicted_label2(predicted_label2 == 1) = 2;
        testLabel(testLabel == 1) = 2;
        
        classOrder = [1,2,3,4,14,5,6,7,8,9,10,11,12,13];
        [ cMatrix ] = estimateConfusionMatrix( predicted_label, testLabel, numClass );
        [ cMatrix2 ] = estimateConfusionMatrix( predicted_label2, testLabel, numClass );
%         [ cMatrix3 ] = estimateConfusionMatrix( predicted_label3, testLabel, numClass );

        Results{testingSet}.cMatrix = cMatrix;
        Results{testingSet}.cMatrix2 = cMatrix2;
%         Results{testingSet}.cMatrix3 = cMatrix3;
    end
    
    if sensorID == 1
        save('eval_table.mat','Results');
    elseif sensorID == 2
        save('eval_floor.mat','Results');
    elseif sensorID == 3
        save('eval_current.mat','Results');
    end
    
    totalM1 = Results{1}.cMatrix;
    totalM2 = Results{1}.cMatrix2;
%     totalM3 = Results{1}.cMatrix3;

    for repID = 2:5
        totalM1 = totalM1 + Results{repID}.cMatrix;
        totalM2 = totalM2 + Results{repID}.cMatrix2;
%         totalM3 = totalM3 + Results{repID}.cMatrix3;
    end
    
    totalM2(:,13) = [];
    totalM2(13,:) = [];
    totalM2(:,12) = [];
    totalM2(12,:) = [];
    totalM2(:,11) = [];
    totalM2(11,:) = [];
    totalM2(:,9) = [];
    totalM2(9,:) = [];
    totalM2(:,6) = [];
    totalM2(6,:) = [];
    totalM2(:,1) = [];
    totalM2(1,:) = [];
    
    figure;
    plotConfMat(totalM2', {'K', 'OM','M','PS','S','V','Step','MD'});


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
%     figure;
%     plotConfMat(totalM2, {'OK', 'K', 'OM','M','PS','OS','S','V','SF','Step','Mis','Sync','null','MD'});
    % figure;
    % plotConfMat(totalM3, {'OK', 'K', 'OM','M','PS','OS','S','V','SF','Step','Mis','Sync','null','MD'});
end

