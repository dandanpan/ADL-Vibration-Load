tclose all; clear all;
Fs = 25600;

load('/Users/shijiapan/Box Sync/Activity_Detection/0311/DATA/PorterLab_20190311_cup_kettle_rep0.mat');
data_kettle_cup = data(110000:end,:);
[ stepEventsSig, stepEventsIdx, stepEventsVal, ...
            stepStartIdxArray, stepStopIdxArray, ... 
            windowEnergyArray, noiseMu, noiseSigma, noiseRange ] = SEDetection( data_kettle_cup(:,3), data_kettle_cup(1:30000,3), 5, Fs ); 
plotAllChannel( data_kettle_cup );
scatter(stepStartIdxArray,data_kettle_cup(stepStartIdxArray,3),'rv');hold on;
scatter(stepStopIdxArray,data_kettle_cup(stepStopIdxArray,3),'gv');hold off;
selected_event_ID = [1,2,3,4,5,7,8,11];
for eventID = 1:length(selected_event_ID)
    event_kettle_cup{eventID} = data_kettle_cup(stepStartIdxArray(selected_event_ID(eventID)):stepStopIdxArray(selected_event_ID(eventID)),:);
%     plotAllChannel( event_kettle_cup{eventID} );
end
ylim([-5,5]);

load('/Users/shijiapan/Box Sync/Activity_Detection/0311/DATA/PorterLab_20190311_cup_rep0.mat');
data_cup = data(200000:end,:);
[ stepEventsSig, stepEventsIdx, stepEventsVal, ...
            stepStartIdxArray, stepStopIdxArray, ... 
            windowEnergyArray, noiseMu, noiseSigma, noiseRange ] = SEDetection( data_cup(:,3), data_cup(180000:210000,3), 10, Fs ); 
plotAllChannel( data_cup );
scatter(stepStartIdxArray,data_cup(stepStartIdxArray,3),'rv');hold on;
scatter(stepStopIdxArray,data_cup(stepStopIdxArray,3),'gv');hold off;
selected_event_ID = [1:8];
for eventID = 1:length(selected_event_ID)
    event_cup{eventID} = data_cup(stepStartIdxArray(selected_event_ID(eventID)):stepStopIdxArray(selected_event_ID(eventID)),:);
%     plotAllChannel( event_cup{eventID} );
end
ylim([-5,5]);

load('/Users/shijiapan/Box Sync/Activity_Detection/0311/DATA/PorterLab_20190311_kettle_microave_rep0.mat');
data_kettle_microwave = data(200000:end,:);
[ stepEventsSig, stepEventsIdx, stepEventsVal, ...
            stepStartIdxArray, stepStopIdxArray, ... 
            windowEnergyArray, noiseMu, noiseSigma, noiseRange ] = SEDetection( data_kettle_microwave(:,3), data_kettle_microwave(180000:210000,3), 10, Fs ); 
plotAllChannel( data_kettle_microwave );
scatter(stepStartIdxArray,data_kettle_microwave(stepStartIdxArray,3),'rv');hold on;
scatter(stepStopIdxArray,data_kettle_microwave(stepStopIdxArray,3),'gv');hold off;
selected_event_ID = [1:8];
for eventID = 1:length(selected_event_ID)
    event_kettle_microwave{eventID} = data_kettle_microwave(stepStartIdxArray(selected_event_ID(eventID)):stepStopIdxArray(selected_event_ID(eventID)),:);
%     plotAllChannel( event_cup{eventID} );
end
ylim([-5,5]);

load('/Users/shijiapan/Box Sync/Activity_Detection/0311/DATA/PorterLab_20190311_microwave_rep0.mat');
data_microwave = data(5000:end,:);
[ stepEventsSig, stepEventsIdx, stepEventsVal, ...
            stepStartIdxArray, stepStopIdxArray, ... 
            windowEnergyArray, noiseMu, noiseSigma, noiseRange ] = SEDetection( data_microwave(:,3), data_microwave(180000:210000,3), 30, Fs ); %(180000:210000,3)% (1000:21000,3)
plotAllChannel( data_microwave );
scatter(stepStartIdxArray,data_microwave(stepStartIdxArray,3),'rv');hold on;
scatter(stepStopIdxArray,data_microwave(stepStopIdxArray,3),'gv');hold off;
selected_event_ID = [1,2,5,6,10:13];
for eventID = 1:length(selected_event_ID)
    event_microwave{eventID} = data_microwave(stepStartIdxArray(selected_event_ID(eventID)):stepStopIdxArray(selected_event_ID(eventID)),:);
%     plotAllChannel( event_cup{eventID} );
end
ylim([-5,5]);


load('/Users/shijiapan/Box Sync/Activity_Detection/0311/DATA/PorterLab_20190311_kettle_pot_rep0.mat');
data_kettle_pot = data(100000:end,:);
[ stepEventsSig, stepEventsIdx, stepEventsVal, ...
            stepStartIdxArray, stepStopIdxArray, ... 
            windowEnergyArray, noiseMu, noiseSigma, noiseRange ] = SEDetection( data_kettle_pot(:,3), data_kettle_pot(1:20000,3), 6, Fs ); %(180000:210000,3)% (1000:21000,3)
plotAllChannel( data_kettle_pot );
scatter(stepStartIdxArray,data_kettle_pot(stepStartIdxArray,3),'rv');hold on;
scatter(stepStopIdxArray,data_kettle_pot(stepStopIdxArray,3),'gv');hold off;
selected_event_ID = [1,3,4,7,9,12,14,16];
for eventID = 1:length(selected_event_ID)
    event_kettle_pot{eventID} = data_kettle_pot(stepStartIdxArray(selected_event_ID(eventID)):stepStopIdxArray(selected_event_ID(eventID)),:);
%     plotAllChannel( event_cup{eventID} );
end
ylim([-5,5]);

%%
load('/Users/shijiapan/Box Sync/Activity_Detection/0311/DATA/PorterLab_20190311_pot_rep0.mat');
data_pot = data(120000:end, :);
[ stepEventsSig, stepEventsIdx, stepEventsVal, ...
            stepStartIdxArray, stepStopIdxArray, ... 
            windowEnergyArray, noiseMu, noiseSigma, noiseRange ] = SEDetection( data_pot(:,3), data_pot(1:20000,3), 100, Fs ); %(180000:210000,3)% (1000:21000,3)
plotAllChannel( data_pot );
scatter(stepStartIdxArray,data_pot(stepStartIdxArray,3),'rv');hold on;
scatter(stepStopIdxArray,data_pot(stepStopIdxArray,3),'gv');hold off;
selected_event_ID = [1,2,3,5,7,8,10,12];
for eventID = 1:length(selected_event_ID)
    event_pot{eventID} = data_pot(stepStartIdxArray(selected_event_ID(eventID)):stepStopIdxArray(selected_event_ID(eventID)),:);
%     plotAllChannel( event_cup{eventID} );
end
ylim([-5,5]);

%%
load('/Users/shijiapan/Box Sync/Activity_Detection/0311/DATA/PorterLab_20190311_kettle_walk_rep0.mat');
data_kellte_walk = data(70000:end,:);
[ stepEventsSig, stepEventsIdx, stepEventsVal, ...
            stepStartIdxArray, stepStopIdxArray, ... 
            windowEnergyArray, noiseMu, noiseSigma, noiseRange ] = SEDetection( data_kellte_walk(:,3), data_kellte_walk(1:20000,3), 6, Fs ); %(180000:210000,3)% (1000:21000,3)
plotAllChannel( data_kellte_walk );
scatter(stepStartIdxArray,data_kellte_walk(stepStartIdxArray,3),'rv');hold on;
scatter(stepStopIdxArray,data_kellte_walk(stepStopIdxArray,3),'gv');hold off;
selected_event_ID = [1:8];
for eventID = 1:length(selected_event_ID)
    event_kettle_walk{eventID} = data_kettle_pot(stepStartIdxArray(selected_event_ID(eventID)):stepStopIdxArray(selected_event_ID(eventID)),:);
%     plotAllChannel( event_cup{eventID} );
end
ylim([-5,5]);

load('/Users/shijiapan/Box Sync/Activity_Detection/0311/DATA/PorterLab_20190311_walk_rep0.mat');
data_walk = data(400000:end,:);
[ stepEventsSig, stepEventsIdx, stepEventsVal, ...
            stepStartIdxArray, stepStopIdxArray, ... 
            windowEnergyArray, noiseMu, noiseSigma, noiseRange ] = SEDetection( data_walk(:,3), [data_walk(90000:100000,3);data_walk(110000:120000,3)], 23, Fs ); %(180000:210000,3)% (1000:21000,3)
plotAllChannel( data_walk );
scatter(stepStartIdxArray,data_walk(stepStartIdxArray,3),'rv');hold on;
scatter(stepStopIdxArray,data_walk(stepStopIdxArray,3),'gv');hold off;
selected_event_ID = [4:9,12,13];
for eventID = 1:length(selected_event_ID)
    event_walk{eventID} = data_walk(stepStartIdxArray(selected_event_ID(eventID)):stepStopIdxArray(selected_event_ID(eventID)),:);
%     plotAllChannel( event_cup{eventID} );
end
ylim([-5,5]);

load('/Users/shijiapan/Box Sync/Activity_Detection/0311/DATA/PorterLab_20190311_kettle_rep0.mat');
data_kettle = data(100000:end,:);
plotAllChannel( data_kettle );
ylim([-5,5]);

%%
addpath('./libsvm-master/matlab/');
addpath('/Users/shijiapan/Documents/MATLAB/SASFunctions/');

% classify four events
for i = 1:8
    data_table = event_cup{i}(:,3);
    data_floor = event_cup{i}(:,4);
    data_table_feature = frequencyFeature( data_table', Fs, 0 );xlim([0,1500]);
    data_floor_feature = frequencyFeature( data_floor', Fs, 0 );xlim([0,1500]);
    class{1,i} = [data_table_feature(1:1000,2);data_floor_feature(1:1000,2)];
end

for i = 1:8
    data_table = event_walk{i}(:,3);
    data_floor = event_walk{i}(:,4);
    data_table_feature = frequencyFeature( data_table', Fs, 0 );xlim([0,1500]);
    data_floor_feature = frequencyFeature( data_floor', Fs, 0 );xlim([0,1500]);
    class{2,i} = [data_table_feature(1:1000,2);data_floor_feature(1:1000,2)];
end

for i = 1:8
    data_table = event_pot{i}(:,3);
    data_floor = event_pot{i}(:,4);
    data_table_feature = frequencyFeature( data_table', Fs, 0 );xlim([0,1500]);
    data_floor_feature = frequencyFeature( data_floor', Fs, 0 );xlim([0,1500]);
    class{3,i} = [data_table_feature(1:1000,2);data_floor_feature(1:1000,2)];
end

for i = 1:8
    data_table = event_microwave{i}(:,3);
    data_floor = event_microwave{i}(:,4);
    data_table_feature = frequencyFeature( data_table', Fs, 0 );xlim([0,1500]);
    data_floor_feature = frequencyFeature( data_floor', Fs, 0 );xlim([0,1500]);
    class{4,i} = [data_table_feature(1:1000,2);data_floor_feature(1:1000,2)];
end

%% classify four events with kettle
for i = 1:8
    data_table = event_kettle_cup{i}(:,3);
    data_floor = event_kettle_cup{i}(:,4);
    data_table_feature = frequencyFeature( data_table', Fs, 0 );xlim([0,1500]);
    data_floor_feature = frequencyFeature( data_floor', Fs, 0 );xlim([0,1500]);
    class{5,i} = [data_table_feature(1:1000,2);data_floor_feature(1:1000,2)];
end

for i = 1:8
    data_table = event_kettle_walk{i}(:,3);
    data_floor = event_kettle_walk{i}(:,4);
    data_table_feature = frequencyFeature( data_table', Fs, 0 );xlim([0,1500]);
    data_floor_feature = frequencyFeature( data_floor', Fs, 0 );xlim([0,1500]);
    class{6,i} = [data_table_feature(1:1000,2);data_floor_feature(1:1000,2)];
end

for i = 1:8
    data_table = event_kettle_pot{i}(:,3);
    data_floor = event_kettle_pot{i}(:,4);
    data_table_feature = frequencyFeature( data_table', Fs, 0 );xlim([0,1500]);
    data_floor_feature = frequencyFeature( data_floor', Fs, 0 );xlim([0,1500]);
    class{7,i} = [data_table_feature(1:1000,2);data_floor_feature(1:1000,2)];
end

for i = 1:8
    data_table = event_kettle_microwave{i}(:,3);
    data_floor = event_kettle_microwave{i}(:,4);
    data_table_feature = frequencyFeature( data_table', Fs, 0 );xlim([0,1500]);
    data_floor_feature = frequencyFeature( data_floor', Fs, 0 );xlim([0,1500]);
    class{8,i} = [data_table_feature(1:1000,2);data_floor_feature(1:1000,2)];
end

%% same domain
for crossvalid = 1:5
    testingSet = 1:8;
    trainingSet = crossvalid:crossvalid+3;
    testingSet(ismember(testingSet, trainingSet)) = [];
    
    trainingFeatures = [];
    trainingLabels = [];
    for i = 1:4
        for j = trainingSet
            trainingFeatures = [trainingFeatures; class{i,j}'];
            trainingLabels = [trainingLabels; i];
        end
    end

    testingFeatures = [];
    testingLabels = [];
    for i = 1:4
        for j = testingSet
            testingFeatures = [testingFeatures; class{i,j}'];
            testingLabels = [testingLabels; i];
        end
    end
    
    % tune parameter ?
    accBase = 0;
    gc = 0;
    for gi = [0.1,0.5,1,3,5,7,9]
        tempStruct = svmtrain(trainingLabels, trainingFeatures, ['-s 0 -t 2 -b 1 -g ' num2str(gi) ' -c 100']);
        [predicted_label, accuracy, decision_values] = svmpredict(trainingLabels, trainingFeatures, tempStruct,'-b 1');
    %                 fprintf(['gi=' num2str(gi) ', acc=' num2str(accuracy(1)) '\n']);
        if accuracy(1) > accBase
            svmstruct = tempStruct;
            accBase = accuracy(1);
            gc = gi;
        end
    end
    [predicted_label_all{crossvalid}, accuracy_all{crossvalid}, decision_values_all{crossvalid}] = svmpredict(testingLabels, testingFeatures, svmstruct,'-b 1');
end

%% different domain
for crossvalid = 1:5
    testingSet = 1:8;
    trainingSet = crossvalid:crossvalid+3;
    testingSet(ismember(testingSet, trainingSet)) = [];
    
    trainingFeatures = [];
    trainingLabels = [];
    for i = 1:4
        for j = trainingSet
            trainingFeatures = [trainingFeatures; class{i,j}'];
            trainingLabels = [trainingLabels; i];
        end
    end

    testingFeatures = [];
    testingLabels = [];
    for i = 1:4
        for j = testingSet
            testingFeatures = [testingFeatures; class{i+4,j}'];
            testingLabels = [testingLabels; i];
        end
    end
    
    % tune parameter ?
    accBase = 0;
    gc = 0;
    for gi = [0.1,0.5,1,3,5,7,9]
        tempStruct = svmtrain(trainingLabels, trainingFeatures, ['-s 0 -t 2 -b 1 -g ' num2str(gi) ' -c 100']);
        [predicted_label, accuracy, decision_values] = svmpredict(trainingLabels, trainingFeatures, tempStruct,'-b 1');
    %                 fprintf(['gi=' num2str(gi) ', acc=' num2str(accuracy(1)) '\n']);
        if accuracy(1) > accBase
            svmstruct = tempStruct;
            accBase = accuracy(1);
            gc = gi;
        end
    end
    [predicted_label_diff{crossvalid}, accuracy_diff{crossvalid}, decision_values_diff{crossvalid}] = svmpredict(testingLabels, testingFeatures, svmstruct,'-b 1');
end

