clear all
close all
clc

load('P1.mat');
addpath('./libsvm-master/matlab/');
addpath('/Users/shijiapan/Documents/MATLAB/SASFunctions/');
Fs = 25600;
personID = 1;

% Floor values
for repID = [2:6]
    repID
    load(['/Users/shijiapan/Box Sync/Activity_Detection/0407/PortLab_20190407_Route_P' num2str(personID) '_Rep' num2str(repID) '.mat']);
    FeatureSet{repID}.Feature = [];
    FeatureSet{repID}.Feature2 = [];
    FeatureSet{repID}.Feature3 = [];
    FeatureSet{repID}.Label = [];
    
    for eventID = 1:length(Floor{repID}.stepStartIdxArray)
        eventID
        % removing labels that are not related to target activities
        if Floor{repID}.label(eventID) <= 0
            continue;
        end
        if Floor{repID}.label(eventID) == 7
            continue;
        end
        
        tempSig = data(4,Floor{repID}.stepStartIdxArray(eventID):Floor{repID}.stepStopIdxArray(eventID));
        tempSigSNR = sum(tempSig.*tempSig)./length(tempSig);
        tempSig = signalNormalization(tempSig);
        tempFea = frequencyFeature( tempSig, Fs, 0, 10 );
        
        tempSig2 = data(5,Floor{repID}.stepStartIdxArray(eventID):Floor{repID}.stepStopIdxArray(eventID));
        tempSig2 = signalNormalization(tempSig2);
        tempSig2SNR = sum(tempSig2.*tempSig2)./length(tempSig2);
        tempFea2 = frequencyFeature( tempSig2, Fs, 0, 10 );
        
        tempSig3 = data(3,Floor{repID}.stepStartIdxArray(eventID):Floor{repID}.stepStopIdxArray(eventID));
        tempSig3 = signalNormalization(tempSig3);
        tempFea3 = frequencyFeature( tempSig3, Fs, 0, 10 );
                
        FeatureSet{repID}.Feature = [FeatureSet{repID}.Feature; tempFea(1:100,2)'];
        FeatureSet{repID}.Feature2 = [FeatureSet{repID}.Feature2; tempFea2(1:100,2)'];
        FeatureSet{repID}.Feature3 = [FeatureSet{repID}.Feature3; tempFea3(1:100,2)'];
        FeatureSet{repID}.Label = [FeatureSet{repID}.Label; Floor{repID}.label(eventID)];      
    end
end

%% SVM
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
            testLabel = [ FeatureSet{repID}.Label];
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

    [ cMatrix ] = estimateConfusionMatrix( predicted_label, testLabel, 10 );
    [ cMatrix2 ] = estimateConfusionMatrix( predicted_label2, testLabel, 10 );
    [ cMatrix3 ] = estimateConfusionMatrix( predicted_label3, testLabel, 10 );

    Results{testingSet}.cMatrix = cMatrix;
    Results{testingSet}.cMatrix2 = cMatrix2;
    Results{testingSet}.cMatrix3 = cMatrix3;
end

save('result_SVM_floor.mat','Results');
save('feature_set_floor.mat','FeatureSet');

cvResults = zeros(10);
cvResults2 = zeros(10);
cvResults3 = zeros(10);
totalTest = [];
totalTest2 = [];
totalTest3 = [];
totalLabel = [];

for i = 2:6
    cvResults = cvResults + Results{i}.cMatrix;
    cvResults2 = cvResults2 + Results{i}.cMatrix2;
    cvResults3 = cvResults3 + Results{i}.cMatrix3;
    totalTest = [totalTest; Results{i}.predicted_label];
    totalTest2 = [totalTest2; Results{i}.predicted_label2];
    totalTest3 = [totalTest3; Results{i}.predicted_label3];
    totalLabel = [totalLabel; Results{i}.label];
end

cvResults(:,9) = [];
cvResults(9,:) = [];
cvResults2(:,9) = [];
cvResults2(9,:) = [];
cvResults3(:,9) = [];
cvResults3(9,:) = [];

cvResults(:,7) = [];
cvResults(7,:) = [];
cvResults2(:,7) = [];
cvResults2(7,:) = [];
cvResults3(:,7) = [];
cvResults3(7,:) = [];

addpath('./plotConfMat/');
plotConfMat(cvResults2, {'pot(u)', 'kettle(u)', 'step','microwave(u)','vacuum','fridge(u)','sweep','kettle(a)'});

% plotConfMat(cvResults, {'pot(u)', 'kettle(u)', 'step','microwave(u)','vacuum','fridge(u)','wipe','sweep','kettle(a)'});
% plotConfMat(cvResults2, {'pot(u)', 'kettle(u)', 'step','microwave(u)','vacuum','fridge(u)','wipe','sweep','kettle(a)'});
% plotConfMat(cvResults3, {'pot(u)', 'kettle(u)', 'step','microwave(u)','vacuum','fridge(u)','wipe','sweep','kettle(a)'});



