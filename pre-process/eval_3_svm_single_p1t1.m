%% Table 
init;
load('P1.mat');
personID = 1;
numClass = 14;

for repID = [2:6]
    repID
    load(['/Users/shijiapan/Box Sync/Activity_Detection/0407/PortLab_20190407_Route_P' num2str(personID) '_Rep' num2str(repID) '.mat']);
    FeatureSet{repID}.Feature = [];
    FeatureSet{repID}.Feature2 = [];
    FeatureSet{repID}.Feature3 = [];
    FeatureSet{repID}.Label = [];
    
    % for each event, find out ground truth
    
    for eventID = 1:length(Table{repID}.stepStartIdxArray)
        eventID
        gt_labels = Label{repID}.label_array(Table{repID}.stepStartIdxArray(eventID):Table{repID}.stepStopIdxArray(eventID));
        the_label = mode(gt_labels(gt_labels > 0));
        if isnan(the_label)
            the_label = 11;
        end
        
        tempSig = data(4,Table{repID}.stepStartIdxArray(eventID):Table{repID}.stepStopIdxArray(eventID));
        tempSig = signalNormalization(tempSig);
        tempFea = frequencyFeature( tempSig, Fs, 0, 10 );
        
        tempSig2 = data(5,Table{repID}.stepStartIdxArray(eventID):Table{repID}.stepStopIdxArray(eventID));
        tempSig2 = signalNormalization(tempSig2);
        tempFea2 = frequencyFeature( tempSig2, Fs, 0, 10 );
        
        tempSig3 = data(3,Table{repID}.stepStartIdxArray(eventID):Table{repID}.stepStopIdxArray(eventID));
        tempSig3 = signalNormalization(tempSig3);
        tempFea3 = frequencyFeature( tempSig3, Fs, 0, 10 );
                
        FeatureSet{repID}.Feature = [FeatureSet{repID}.Feature; tempFea(1:100,2)'];
        FeatureSet{repID}.Feature2 = [FeatureSet{repID}.Feature2; tempFea2(1:100,2)'];
        FeatureSet{repID}.Feature3 = [FeatureSet{repID}.Feature3; tempFea3(1:100,2)'];
        FeatureSet{repID}.Label = [FeatureSet{repID}.Label; the_label];      
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
            testFeature = FeatureSet{repID}.Feature;
            testFeature2 = [testFeature, FeatureSet{repID}.Feature2];
            testFeature3 = [testFeature2, FeatureSet{repID}.Feature3];
            testLabel = [testLabel; FeatureSet{repID}.Label];
        else
            trainFeature = [trainFeature;FeatureSet{repID}.Feature];
            trainFeature2 = [trainFeature2;FeatureSet{repID}.Feature, FeatureSet{repID}.Feature2];
            trainFeature3 = [trainFeature3;FeatureSet{repID}.Feature, FeatureSet{repID}.Feature2, FeatureSet{repID}.Feature3];
            trainLabel = [trainLabel; FeatureSet{repID}.Label];
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

save('eval_table.mat','Results');
save('feature_table.mat','FeatureSet');

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
% figure;
% plotConfMat(totalM1, {'OK', 'K', 'OM','M','PS','OS','S','V','SF','Step','Mis','Sync','null','MD'});
figure;
plotConfMat(totalM2, {'OK', 'K', 'OM','M','PS','OS','S','V','SF','Step','Mis','Sync','null','MD'});
% figure;
% plotConfMat(totalM3, {'OK', 'K', 'OM','M','PS','OS','S','V','SF','Step','Mis','Sync','null','MD'});

%% Floor 
init;

load('P1.mat');
personID = 1;
numClass = 14;

for repID = [2:6]
    repID
    load(['/Users/shijiapan/Box Sync/Activity_Detection/0407/PortLab_20190407_Route_P' num2str(personID) '_Rep' num2str(repID) '.mat']);
    FeatureSet{repID}.Feature = [];
    FeatureSet{repID}.Feature2 = [];
    FeatureSet{repID}.Feature3 = [];
    FeatureSet{repID}.Label = [];
    
    % for each event, find out ground truth
    
    for eventID = 1:length(Floor{repID}.stepStartIdxArray)
        eventID
        gt_labels = Label{repID}.label_array(Floor{repID}.stepStartIdxArray(eventID):Floor{repID}.stepStopIdxArray(eventID));
        the_label = mode(gt_labels(gt_labels > 0));
        if isnan(the_label)
            the_label = 11;
        end
        
        tempSig = data(4,Floor{repID}.stepStartIdxArray(eventID):Floor{repID}.stepStopIdxArray(eventID));
        tempSig = signalNormalization(tempSig);
        tempFea = frequencyFeature( tempSig, Fs, 0, 10 );
        
        tempSig2 = data(5,Floor{repID}.stepStartIdxArray(eventID):Floor{repID}.stepStopIdxArray(eventID));
        tempSig2 = signalNormalization(tempSig2);
        tempFea2 = frequencyFeature( tempSig2, Fs, 0, 10 );
        
        tempSig3 = data(3,Floor{repID}.stepStartIdxArray(eventID):Floor{repID}.stepStopIdxArray(eventID));
        tempSig3 = signalNormalization(tempSig3);
        tempFea3 = frequencyFeature( tempSig3, Fs, 0, 10 );
                
        FeatureSet{repID}.Feature = [FeatureSet{repID}.Feature; tempFea2(1:100,2)'];
        FeatureSet{repID}.Feature2 = [FeatureSet{repID}.Feature2; tempFea(1:100,2)'];
        FeatureSet{repID}.Feature3 = [FeatureSet{repID}.Feature3; tempFea3(1:100,2)'];
        FeatureSet{repID}.Label = [FeatureSet{repID}.Label; the_label];      
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
            testFeature = FeatureSet{repID}.Feature;
            testFeature2 = [testFeature, FeatureSet{repID}.Feature2];
            testFeature3 = [testFeature2, FeatureSet{repID}.Feature3];
            testLabel = [testLabel; FeatureSet{repID}.Label];
        else
            trainFeature = [trainFeature;FeatureSet{repID}.Feature];
            trainFeature2 = [trainFeature2;FeatureSet{repID}.Feature, FeatureSet{repID}.Feature2];
            trainFeature3 = [trainFeature3;FeatureSet{repID}.Feature, FeatureSet{repID}.Feature2, FeatureSet{repID}.Feature3];
            trainLabel = [trainLabel; FeatureSet{repID}.Label];
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
save('feature_floor.mat','FeatureSet');

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
    FeatureSet{repID}.Feature = [];
    FeatureSet{repID}.Feature2 = [];
    FeatureSet{repID}.Feature3 = [];
    FeatureSet{repID}.Label = [];
    
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
        FeatureSet{repID}.Feature = [FeatureSet{repID}.Feature; tempFea(1:200,2)', tempSigStd];
        FeatureSet{repID}.Feature2 = [FeatureSet{repID}.Feature2; tempFea2(1:200,2)'];
        FeatureSet{repID}.Label = [FeatureSet{repID}.Label; the_label];      
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
            testFeature = FeatureSet{repID}.Feature;
            testFeature2 = [testFeature, FeatureSet{repID}.Feature2];
            testLabel = [testLabel; FeatureSet{repID}.Label];
        else
            trainFeature = [trainFeature;FeatureSet{repID}.Feature];
            trainFeature2 = [trainFeature2;FeatureSet{repID}.Feature, FeatureSet{repID}.Feature2];
            trainLabel = [trainLabel; FeatureSet{repID}.Label];
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
save('feature_current.mat','FeatureSet');

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
