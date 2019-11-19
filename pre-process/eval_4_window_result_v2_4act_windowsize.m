init;

load('P1_4act.mat');
load('eval_table_4act.mat');
load('feature_table_4act.mat');
personID = 1;

results = [];
results2 = [];

windowSizeSet = [Fs/32,Fs/16,Fs/8,Fs/4,Fs/2];
for windowID = 1:5
    windowSize = windowSizeSet(windowID);
    resultCount = 0;
    for repID = [1,2,6,7,8]
        resultCount = resultCount + 1;

        ObservLabelTest = [];
        ObservPrediTest = [];
        ObservPrediTest2 = [];
        ObservPrediEvent = [];
        ObservPrediScore = [];
        ObservPrediScore2 = [];

        load(['/Users/shijiapan/Box Sync/Activity_Detection/0407/PortLab_20190407_Route_P' num2str(personID) '_Rep' num2str(repID) '.mat']);
        dataLen = length(data);
        sensorPrediLabel = zeros(1,dataLen); 
        sensorPrediLabel2 = zeros(1,dataLen); 
        sensorEventID = zeros(1,dataLen); 

        for eventID = 1:length(Table{repID}.stepStartIdxArray)
            % at sample level, label the event id and their
            % prediction label 
            sensorPrediLabel(Table{repID}.stepStartIdxArray(eventID):Table{repID}.stepStopIdxArray(eventID)) = Results{resultCount}.predicted_label(eventID);
            sensorPrediLabel2(Table{repID}.stepStartIdxArray(eventID):Table{repID}.stepStopIdxArray(eventID)) = Results{resultCount}.predicted_label2(eventID);
            sensorEventID(Table{repID}.stepStartIdxArray(eventID):Table{repID}.stepStopIdxArray(eventID)) = eventID;
        end

        % label or collection info at window level
        for sampleID = 1:windowSize:dataLen-windowSize
            ObservLabelTest = [ObservLabelTest, mode(Label{repID}.label_array(sampleID:sampleID+windowSize*2-1))];
            ObservPrediTest = [ObservPrediTest, mode(sensorPrediLabel(sampleID:sampleID+windowSize*2-1))];
            ObservPrediTest2 = [ObservPrediTest2, mode(sensorPrediLabel2(sampleID:sampleID+windowSize*2-1))];
            windowEventID = mode(sensorEventID(sampleID:sampleID+windowSize*2-1));
            if windowEventID == 0
                ObservPrediScore = [ObservPrediScore, 0.9];
                ObservPrediScore2 = [ObservPrediScore2, 0.9];
            else
                confScore = max(Results{resultCount}.decision_values(windowEventID,:));
                confScore2 = max(Results{resultCount}.decision_values2(windowEventID,:));
                ObservPrediScore = [ObservPrediScore, confScore];
                ObservPrediScore2 = [ObservPrediScore2, confScore2];
            end
        end

        ObservLabelTest(ObservLabelTest == 0) = nullClass;
        ObservPrediTest(ObservPrediTest == 0) = nullClass;
        ObservPrediTest2(ObservPrediTest2 == 0) = nullClass;

        window_level_accuracy = sum(ObservPrediTest == ObservLabelTest)./length(ObservLabelTest);
        results = [results, window_level_accuracy];
        window_level_accuracy2 = sum(ObservPrediTest2 == ObservLabelTest)./length(ObservLabelTest);
        results2 = [results2, window_level_accuracy2];

        figure;
        plot(ObservLabelTest);hold on;
        plot(ObservPrediTest);hold on;
        plot(ObservPrediScore);hold off;

        Results{resultCount}.ObservLabelTest = ObservLabelTest;
        Results{resultCount}.ObservPrediTest = ObservPrediTest;
        Results{resultCount}.ObservPrediScore = ObservPrediScore;
        Results{resultCount}.ObservPrediTest2 = ObservPrediTest2;
        Results{resultCount}.ObservPrediScore2 = ObservPrediScore2;

    end
    mean(results)
    mean(results2)

    save(['eval_table_4act_window' num2str(windowID) '.mat'],'Results');
end
%% Floor
init;

load('P1_4act.mat');
load('eval_floor_4act.mat');
load('feature_floor_4act.mat');
personID = 1;
results = [];
results2 = [];

windowSizeSet = [Fs/32,Fs/16,Fs/8,Fs/4,Fs/2];
for windowID = 1:5
    windowSize = windowSizeSet(windowID);
    resultCount = 0;
    for repID = [1,2,6,7,8]
        resultCount = resultCount + 1;

        ObservLabelTest = [];
        ObservPrediTest = [];
        ObservPrediTest2 = [];
        ObservPrediEvent = [];
        ObservPrediScore = [];
        ObservPrediScore2 = [];

        load(['/Users/shijiapan/Box Sync/Activity_Detection/0407/PortLab_20190407_Route_P' num2str(personID) '_Rep' num2str(repID) '.mat']);
        dataLen = length(data);
        sensorPrediLabel = zeros(1,dataLen); 
        sensorPrediLabel2 = zeros(1,dataLen); 
        sensorEventID = zeros(1,dataLen); 

        for eventID = 1:length(Floor{repID}.stepStartIdxArray)
            % at sample level, label the event id and their
            % prediction label 
            sensorPrediLabel(Floor{repID}.stepStartIdxArray(eventID):Floor{repID}.stepStopIdxArray(eventID)) = Results{resultCount}.predicted_label(eventID);
            sensorPrediLabel2(Floor{repID}.stepStartIdxArray(eventID):Floor{repID}.stepStopIdxArray(eventID)) = Results{resultCount}.predicted_label2(eventID);
            sensorEventID(Floor{repID}.stepStartIdxArray(eventID):Floor{repID}.stepStopIdxArray(eventID)) = eventID;
        end

        % label or collection info at window level
        for sampleID = 1:windowSize:dataLen-windowSize
            ObservLabelTest = [ObservLabelTest, mode(Label{repID}.label_array(sampleID:sampleID+windowSize*2-1))];
            ObservPrediTest = [ObservPrediTest, mode(sensorPrediLabel(sampleID:sampleID+windowSize*2-1))];
            ObservPrediTest2 = [ObservPrediTest2, mode(sensorPrediLabel2(sampleID:sampleID+windowSize*2-1))];
            windowEventID = mode(sensorEventID(sampleID:sampleID+windowSize*2-1));
            if windowEventID == 0
                ObservPrediScore = [ObservPrediScore, 0.9];
                ObservPrediScore2 = [ObservPrediScore2, 0.9];
            else
                confScore = max(Results{resultCount}.decision_values(windowEventID,:));
                confScore2 = max(Results{resultCount}.decision_values2(windowEventID,:));
                ObservPrediScore = [ObservPrediScore, confScore];
                ObservPrediScore2 = [ObservPrediScore2, confScore2];
            end
        end

        ObservLabelTest(ObservLabelTest == 0) = nullClass;
        ObservPrediTest(ObservPrediTest == 0) = nullClass;
        ObservPrediTest2(ObservPrediTest2 == 0) = nullClass;

        window_level_accuracy = sum(ObservPrediTest == ObservLabelTest)./length(ObservLabelTest);
        results = [results, window_level_accuracy];
        window_level_accuracy2 = sum(ObservPrediTest2 == ObservLabelTest)./length(ObservLabelTest);
        results2 = [results2, window_level_accuracy2];

        figure;
        plot(ObservLabelTest);hold on;
        plot(ObservPrediTest);hold on;
        plot(ObservPrediScore);hold off;

        Results{resultCount}.ObservLabelTest = ObservLabelTest;
        Results{resultCount}.ObservPrediTest = ObservPrediTest;
        Results{resultCount}.ObservPrediScore = ObservPrediScore;
        Results{resultCount}.ObservPrediTest2 = ObservPrediTest2;
        Results{resultCount}.ObservPrediScore2 = ObservPrediScore2;

    end
    mean(results)
    mean(results2)

    save(['eval_floor_4act_window' num2str(windowID) '.mat'],'Results');
end

%% Current
init;
load('P1_4act.mat');
load('eval_current_4act.mat');
load('feature_current_4act.mat');
personID = 1;
results = [];
results2 = [];

windowSizeSet = [Fs/32,Fs/16,Fs/8,Fs/4,Fs/2];
for windowID = 1:5
    windowSize = windowSizeSet(windowID);
    resultCount = 0;
    for repID = [1,2,6,7,8]
        resultCount = resultCount + 1;

        ObservLabelTest = [];
        ObservPrediTest = [];
        ObservPrediTest2 = [];
        ObservPrediEvent = [];
        ObservPrediScore = [];
        ObservPrediScore2 = [];

        load(['/Users/shijiapan/Box Sync/Activity_Detection/0407/PortLab_20190407_Route_P' num2str(personID) '_Rep' num2str(repID) '.mat']);
        dataLen = length(data);
        sensorPrediLabel = zeros(1,dataLen); 
        sensorPrediLabel2 = zeros(1,dataLen); 
        sensorEventID = zeros(1,dataLen); 

        for eventID = 1:length(Currents{repID}.stepStartIdxArray)
            % at sample level, label the event id and their
            % prediction label 
            sensorPrediLabel(Currents{repID}.stepStartIdxArray(eventID):Currents{repID}.stepStopIdxArray(eventID)) = Results{resultCount}.predicted_label(eventID);
            sensorPrediLabel2(Currents{repID}.stepStartIdxArray(eventID):Currents{repID}.stepStopIdxArray(eventID)) = Results{resultCount}.predicted_label2(eventID);
            sensorEventID(Currents{repID}.stepStartIdxArray(eventID):Currents{repID}.stepStopIdxArray(eventID)) = eventID;
        end

        % label or collection info at window level
        for sampleID = 1:windowSize:dataLen-windowSize
            ObservLabelTest = [ObservLabelTest, mode(Label{repID}.label_array(sampleID:sampleID+windowSize*2-1))];
            ObservPrediTest = [ObservPrediTest, mode(sensorPrediLabel(sampleID:sampleID+windowSize*2-1))];
            ObservPrediTest2 = [ObservPrediTest2, mode(sensorPrediLabel2(sampleID:sampleID+windowSize*2-1))];
            windowEventID = mode(sensorEventID(sampleID:sampleID+windowSize*2-1));
            if windowEventID == 0
                ObservPrediScore = [ObservPrediScore, 0.9];
                ObservPrediScore2 = [ObservPrediScore2, 0.9];
            else
                confScore = max(Results{resultCount}.decision_values(windowEventID,:));
                confScore2 = max(Results{resultCount}.decision_values2(windowEventID,:));
                ObservPrediScore = [ObservPrediScore, confScore];
                ObservPrediScore2 = [ObservPrediScore2, confScore2];
            end
        end

        ObservLabelTest(ObservLabelTest == 0) = nullClass;
        ObservPrediTest(ObservPrediTest == 0) = nullClass;
        ObservPrediTest2(ObservPrediTest2 == 0) = nullClass;

        window_level_accuracy = sum(ObservPrediTest == ObservLabelTest)./length(ObservLabelTest);
        results = [results, window_level_accuracy];
        window_level_accuracy2 = sum(ObservPrediTest2 == ObservLabelTest)./length(ObservLabelTest);
        results2 = [results2, window_level_accuracy2];

        figure;
        plot(ObservLabelTest);hold on;
        plot(ObservPrediTest);hold on;
        plot(ObservPrediScore);hold off;

        Results{resultCount}.ObservLabelTest = ObservLabelTest;
        Results{resultCount}.ObservPrediTest = ObservPrediTest;
        Results{resultCount}.ObservPrediScore = ObservPrediScore;
        Results{resultCount}.ObservPrediTest2 = ObservPrediTest2;
        Results{resultCount}.ObservPrediScore2 = ObservPrediScore2;

    end
    mean(results)
    mean(results2)

    save(['eval_current_4act_window' num2str(windowID) '.mat'],'Results');
end