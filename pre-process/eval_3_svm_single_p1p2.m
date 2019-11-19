init;

load('feature_table_p1.mat');
numClass = 14;

% training on P1 dataset
trainFeature = [];
trainFeature2 = [];
trainFeature3 = [];
trainLabel = [];
for repID = 1:5
    trainFeature = [trainFeature;FeatureSet{repID}.Feature];
    trainFeature2 = [trainFeature2;FeatureSet{repID}.Feature, FeatureSet{repID}.Feature2];
    trainFeature3 = [trainFeature3;FeatureSet{repID}.Feature, FeatureSet{repID}.Feature2, FeatureSet{repID}.Feature3];
    trainLabel = [trainLabel; FeatureSet{repID}.Label];
end
    
% test on P2 dataset
load('feature_table_p2.mat');
FeatureSet(5:7) = [];
for repID = 1:5
    testFeature = FeatureSet{repID}.Feature;
    testFeature2 = [testFeature, FeatureSet{repID}.Feature2];
    testFeature3 = [testFeature2, FeatureSet{repID}.Feature3];
    testLabel = FeatureSet{repID}.Label;
        
    [ svmstruct, gi ] = svmTrainModel( trainLabel, trainFeature )
    [predicted_label, accuracy, decision_values] = svmpredict(testLabel, testFeature, svmstruct,'-b 1');
    [ svmstruct2, gi ] = svmTrainModel( trainLabel, trainFeature2 )
    [predicted_label2, accuracy2, decision_values2] = svmpredict(testLabel, testFeature2, svmstruct2,'-b 1');
    [ svmstruct3, gi ] = svmTrainModel( trainLabel, trainFeature3 )
    [predicted_label3, accuracy3, decision_values3] = svmpredict(testLabel, testFeature3, svmstruct3,'-b 1');

    Results{repID}.predicted_label = predicted_label;
    Results{repID}.accuracy = accuracy;
    Results{repID}.decision_values = decision_values;
    Results{repID}.predicted_label2 = predicted_label2;
    Results{repID}.accuracy2 = accuracy2;
    Results{repID}.decision_values2 = decision_values2;
    Results{repID}.predicted_label3 = predicted_label3;
    Results{repID}.accuracy3 = accuracy3;
    Results{repID}.decision_values3 = decision_values3;
    Results{repID}.label = testLabel;

    [ cMatrix ] = estimateConfusionMatrix( predicted_label, testLabel, numClass );
    [ cMatrix2 ] = estimateConfusionMatrix( predicted_label2, testLabel, numClass );
    [ cMatrix3 ] = estimateConfusionMatrix( predicted_label3, testLabel, numClass );

    Results{repID}.cMatrix = cMatrix;
    Results{repID}.cMatrix2 = cMatrix2;
    Results{repID}.cMatrix3 = cMatrix3;
end

save('result_table_train_p1_test_p2.mat','Results');

totalM1 = Results{1}.cMatrix;
totalM2 = Results{1}.cMatrix2;
for repID = 2
    totalM1 = totalM1 + Results{repID}.cMatrix;
    totalM2 = totalM2 + Results{repID}.cMatrix2;
end

addpath('./plotConfMat/');
% figure;
% plotConfMat(totalM1, {'OK', 'K', 'OM','M','PS','OS','S','V','SF','Step','Mis','Sync','null','MD'});
figure;
plotConfMat(totalM2', {'OK', 'K', 'OM','M','PS','OS','S','V','SF','Step','Mis','Sync','null','MD'});

%% Floor
load('feature_floor_p1.mat');
numClass = 14;

% training on P1 dataset
trainFeature = [];
trainFeature2 = [];
trainFeature3 = [];
trainLabel = [];
for repID = 1:5
    trainFeature = [trainFeature;FeatureSet{repID}.Feature];
    trainFeature2 = [trainFeature2;FeatureSet{repID}.Feature, FeatureSet{repID}.Feature2];
    trainFeature3 = [trainFeature3;FeatureSet{repID}.Feature, FeatureSet{repID}.Feature2, FeatureSet{repID}.Feature3];
    trainLabel = [trainLabel; FeatureSet{repID}.Label];
end
    
% test on P2 dataset
load('feature_floor_p2.mat');
FeatureSet(5:7) = [];
for repID = 1:5
    testFeature = FeatureSet{repID}.Feature;
    testFeature2 = [testFeature, FeatureSet{repID}.Feature2];
    testFeature3 = [testFeature2, FeatureSet{repID}.Feature3];
    testLabel = FeatureSet{repID}.Label;
        
    [ svmstruct, gi ] = svmTrainModel( trainLabel, trainFeature )
    [predicted_label, accuracy, decision_values] = svmpredict(testLabel, testFeature, svmstruct,'-b 1');
    [ svmstruct2, gi ] = svmTrainModel( trainLabel, trainFeature2 )
    [predicted_label2, accuracy2, decision_values2] = svmpredict(testLabel, testFeature2, svmstruct2,'-b 1');
    [ svmstruct3, gi ] = svmTrainModel( trainLabel, trainFeature3 )
    [predicted_label3, accuracy3, decision_values3] = svmpredict(testLabel, testFeature3, svmstruct3,'-b 1');

    Results{repID}.predicted_label = predicted_label;
    Results{repID}.accuracy = accuracy;
    Results{repID}.decision_values = decision_values;
    Results{repID}.predicted_label2 = predicted_label2;
    Results{repID}.accuracy2 = accuracy2;
    Results{repID}.decision_values2 = decision_values2;
    Results{repID}.predicted_label3 = predicted_label3;
    Results{repID}.accuracy3 = accuracy3;
    Results{repID}.decision_values3 = decision_values3;
    Results{repID}.label = testLabel;

    [ cMatrix ] = estimateConfusionMatrix( predicted_label, testLabel, numClass );
    [ cMatrix2 ] = estimateConfusionMatrix( predicted_label2, testLabel, numClass );
    [ cMatrix3 ] = estimateConfusionMatrix( predicted_label3, testLabel, numClass );

    Results{repID}.cMatrix = cMatrix;
    Results{repID}.cMatrix2 = cMatrix2;
    Results{repID}.cMatrix3 = cMatrix3;
end


save('result_floor_train_p1_test_p2.mat','Results');

totalM1 = Results{1}.cMatrix;
totalM2 = Results{1}.cMatrix2;
for repID = 2
    totalM1 = totalM1 + Results{repID}.cMatrix;
    totalM2 = totalM2 + Results{repID}.cMatrix2;
end

addpath('./plotConfMat/');
% figure;
% plotConfMat(totalM1, {'OK', 'K', 'OM','M','PS','OS','S','V','SF','Step','Mis','Sync','null','MD'});
figure;
plotConfMat(totalM2', {'OK', 'K', 'OM','M','PS','OS','S','V','SF','Step','Mis','Sync','null','MD'});

%% Current
load('feature_current_p1.mat');
numClass = 14;

% training on P1 dataset
trainFeature = [];
trainFeature2 = [];
trainFeature3 = [];
trainLabel = [];
for repID = 1:5
    trainFeature = [trainFeature;FeatureSet{repID}.Feature];
    trainFeature2 = [trainFeature2;FeatureSet{repID}.Feature, FeatureSet{repID}.Feature2];
    trainFeature3 = [trainFeature3;FeatureSet{repID}.Feature, FeatureSet{repID}.Feature2, FeatureSet{repID}.Feature3];
    trainLabel = [trainLabel; FeatureSet{repID}.Label];
end
    
% test on P2 dataset
load('feature_current_p2.mat');
FeatureSet(5:7) = [];
for repID = 1:5
    testFeature = FeatureSet{repID}.Feature;
    testFeature2 = [testFeature, FeatureSet{repID}.Feature2];
    testFeature3 = [testFeature2, FeatureSet{repID}.Feature3];
    testLabel = FeatureSet{repID}.Label;
        
    [ svmstruct, gi ] = svmTrainModel( trainLabel, trainFeature )
    [predicted_label, accuracy, decision_values] = svmpredict(testLabel, testFeature, svmstruct,'-b 1');
    [ svmstruct2, gi ] = svmTrainModel( trainLabel, trainFeature2 )
    [predicted_label2, accuracy2, decision_values2] = svmpredict(testLabel, testFeature2, svmstruct2,'-b 1');
    [ svmstruct3, gi ] = svmTrainModel( trainLabel, trainFeature3 )
    [predicted_label3, accuracy3, decision_values3] = svmpredict(testLabel, testFeature3, svmstruct3,'-b 1');

    Results{repID}.predicted_label = predicted_label;
    Results{repID}.accuracy = accuracy;
    Results{repID}.decision_values = decision_values;
    Results{repID}.predicted_label2 = predicted_label2;
    Results{repID}.accuracy2 = accuracy2;
    Results{repID}.decision_values2 = decision_values2;
    Results{repID}.predicted_label3 = predicted_label3;
    Results{repID}.accuracy3 = accuracy3;
    Results{repID}.decision_values3 = decision_values3;
    Results{repID}.label = testLabel;

    [ cMatrix ] = estimateConfusionMatrix( predicted_label, testLabel, numClass );
    [ cMatrix2 ] = estimateConfusionMatrix( predicted_label2, testLabel, numClass );
    [ cMatrix3 ] = estimateConfusionMatrix( predicted_label3, testLabel, numClass );

    Results{repID}.cMatrix = cMatrix;
    Results{repID}.cMatrix2 = cMatrix2;
    Results{repID}.cMatrix3 = cMatrix3;
end


save('result_current_train_p1_test_p2.mat','Results');

totalM1 = Results{1}.cMatrix;
totalM2 = Results{1}.cMatrix2;
for repID = 2
    totalM1 = totalM1 + Results{repID}.cMatrix;
    totalM2 = totalM2 + Results{repID}.cMatrix2;
end

addpath('./plotConfMat/');
% figure;
% plotConfMat(totalM1, {'OK', 'K', 'OM','M','PS','OS','S','V','SF','Step','Mis','Sync','null','MD'});
figure;
plotConfMat(totalM2', {'OK', 'K', 'OM','M','PS','OS','S','V','SF','Step','Mis','Sync','null','MD'});
