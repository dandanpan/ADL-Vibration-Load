clear all
close all
clc

load('P1.mat');
addpath('./libsvm-master/matlab/');
addpath('/Users/shijiapan/Documents/MATLAB/SASFunctions/');
Fs = 25600;
personID = 1;

% Current values
currentFeature = [];
currentLabel = [];
for repID = [2:6]
    load(['/Users/shijiapan/Box Sync/Activity_Detection/0407/PortLab_20190407_Route_P' num2str(personID) '_Rep' num2str(repID) '.mat']);
    for eventID = 1:length(Currents{repID}.stepStartIdxArray)
        tempSig = data(3,Currents{repID}.stepStartIdxArray(eventID):Currents{repID}.stepStopIdxArray(eventID));
        tempSig = signalNormalization(tempSig);
        tempFea = frequencyFeature( tempSig, Fs, 0, 10 );
        currentFeature = [currentFeature; tempFea(1:100,2)'];
        currentLabel = [currentLabel; Currents{repID}.label(eventID)];
    end
end

% Table values
for repID = [2:6]
    repID
    load(['/Users/shijiapan/Box Sync/Activity_Detection/0407/PortLab_20190407_Route_P' num2str(personID) '_Rep' num2str(repID) '.mat']);
    FeatureSet{repID}.Feature = [];
    FeatureSet{repID}.Feature2 = [];
    FeatureSet{repID}.Feature3 = [];
    FeatureSet{repID}.Label = [];
    
    for eventID = 1:length(Currents{repID}.stepStartIdxArray)
        tempSig = data(3,Currents{repID}.stepStartIdxArray(eventID):Currents{repID}.stepStopIdxArray(eventID));
        tempSig = signalNormalization(tempSig);
        tempFea = frequencyFeature( tempSig, Fs, 0, 10 );
        FeatureSet{repID}.Feature = [FeatureSet{repID}.Feature; tempFea(1:200,2)'];
        FeatureSet{repID}.Label = [FeatureSet{repID}.Label; Currents{repID}.label(eventID)];  
    end
end

%% SVM
for testingSet = 2:6
    testingSet
    trainFeature = [];
    trainLabel = [];
    testFeature = [];
    testLabel = [];
    
    for repID = 2:6
        if repID == testingSet
            testFeature = FeatureSet{repID}.Feature;
            testLabel = [testLabel; FeatureSet{repID}.Label];
        else
            trainFeature = [trainFeature;FeatureSet{repID}.Feature];
            trainLabel = [trainLabel; FeatureSet{repID}.Label];
        end
    end
    [ svmstruct, gi ] = svmTrainModel( trainLabel, trainFeature )
    [predicted_label, accuracy, decision_values] = svmpredict(testLabel, testFeature, svmstruct,'-b 1');
    
    Results{testingSet}.predicted_label = predicted_label;
    Results{testingSet}.accuracy = accuracy;
    Results{testingSet}.decision_values = decision_values;
    Results{testingSet}.label = testLabel;

    [ cMatrix ] = estimateConfusionMatrix( predicted_label, testLabel, 10 );

    Results{testingSet}.cMatrix = cMatrix;
end

save('result_SVM_current.mat','Results');
save('feature_set_current.mat','FeatureSet');

cvResults = zeros(10);
cvResults2 = zeros(10);
cvResults3 = zeros(10);

for i = 2:6
    cvResults = cvResults + Results{i}.cMatrix;
end

addpath('./plotConfMat/');
plotConfMat(cvResults, {'kettle', 'microwave(u)','vacuum','fridge'});


