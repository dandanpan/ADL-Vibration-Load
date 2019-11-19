init;

load('P1.mat');
Sensor{1,1} = Table;
Sensor{1,2} = Floor;
Sensor{1,3} = Currents;
Label1 = Label;
load('P1_4act.mat');
Sensor{2,1} = Table;
Sensor{2,2} = Floor;
Sensor{2,3} = Currents;
Label2 = Label;
clear Table Floor Currents Label;


SensorResults = cell(3,5);
load('eval_table_p1.mat');
SensorResults(1,:) = Results;

load('eval_floor_p1.mat');
SensorResults(2,:) = Results;

load('eval_current_p1.mat');
SensorResults(3,:) = Results;

personID = 1;
windowSize = Fs/8;

results = [];
results2 = [];

repID1 = [2:6];
repID2 = [1,2,6,7,8];

for sensorID = 1:3
    for resultCount = 1:5

        ObservLabelTest = [];
        ObservPrediTest = [];
        ObservPrediTest2 = [];
        ObservPrediEvent = [];
        ObservPrediScore = [];
        ObservPrediScore2 = [];

        load(['/Users/shijiapan/Box Sync/Activity_Detection/0407/PortLab_20190407_Route_P' num2str(personID) '_Rep' num2str(repID1(resultCount)) '.mat']);
        data1 = data;
        load(['/Users/shijiapan/Box Sync/Activity_Detection/0429/PortLab_20190429_Route_P' num2str(personID) '_Rep' num2str(repID2(resultCount)) '.mat']);
        data2 = data;
        clear data;

        dataLen1 = length(data1);
        dataLen2 = length(data2);
        dataLen = length([data1, data2]);
        sensorPrediLabel = zeros(1,dataLen); 
        sensorPrediLabel2 = zeros(1,dataLen); 
        sensorEventID = zeros(1,dataLen); 

        totalEventStart = [Sensor{1,sensorID}{repID1(resultCount)}.stepStartIdxArray Sensor{2,sensorID}{repID2(resultCount)}.stepStartIdxArray+dataLen1]; 
        totalEventStop = [Sensor{1,sensorID}{repID1(resultCount)}.stepStopIdxArray Sensor{2,sensorID}{repID2(resultCount)}.stepStopIdxArray+dataLen1]; 
        totalEventStart = totalEventStart(SensorResults{sensorID, resultCount}.whiteListEventIdx2);
        totalEventStop = totalEventStop(SensorResults{sensorID, resultCount}.whiteListEventIdx2);

        for eventID = 1:length(totalEventStart)
            % at sample level, label the event id and their
            % prediction label 
            sensorPrediLabel(totalEventStart(eventID):totalEventStop(eventID)) = SensorResults{sensorID, resultCount}.predicted_label(eventID);
            sensorPrediLabel2(totalEventStart(eventID):totalEventStop(eventID)) = SensorResults{sensorID, resultCount}.predicted_label2(eventID);
            sensorEventID(totalEventStart(eventID):totalEventStop(eventID)) = eventID;
        end

        totalLabel = [Label1{repID1(resultCount)}.label_array(1:dataLen1) Label2{repID2(resultCount)}.label_array(1:dataLen2)];

        % label or collection info at window level
        for sampleID = 1:windowSize:dataLen-windowSize
            ObservLabelTest = [ObservLabelTest, mode(totalLabel(sampleID:sampleID+windowSize*2-1))];
            ObservPrediTest = [ObservPrediTest, mode(sensorPrediLabel(sampleID:sampleID+windowSize*2-1))];
            ObservPrediTest2 = [ObservPrediTest2, mode(sensorPrediLabel2(sampleID:sampleID+windowSize*2-1))];
            windowEventID = mode(sensorEventID(sampleID:sampleID+windowSize*2-1));
            if windowEventID == 0
                ObservPrediScore = [ObservPrediScore, 0.9];
                ObservPrediScore2 = [ObservPrediScore2, 0.9];
            else
                confScore = max(SensorResults{sensorID, resultCount}.decision_values(windowEventID,:));
                confScore2 = max(SensorResults{sensorID, resultCount}.decision_values2(windowEventID,:));
                ObservPrediScore = [ObservPrediScore, confScore];
                ObservPrediScore2 = [ObservPrediScore2, confScore2];
            end
        end

        ObservLabelTest(ObservLabelTest == 0) = nullClass;
        ObservPrediTest(ObservPrediTest == 0) = nullClass;
        ObservPrediTest2(ObservPrediTest2 == 0) = nullClass;
        ObservLabelTest(ObservLabelTest == -1) = nullClass;

        window_level_accuracy = sum(ObservPrediTest == ObservLabelTest)./length(ObservLabelTest);
        results = [results, window_level_accuracy];
        window_level_accuracy2 = sum(ObservPrediTest2 == ObservLabelTest)./length(ObservLabelTest);
        results2 = [results2, window_level_accuracy2];

        figure;
        plot(ObservLabelTest);hold on;
        plot(ObservPrediTest);hold on;
        plot(ObservPrediScore);hold off;

        SensorResults{sensorID, resultCount}.ObservLabelTest = ObservLabelTest;
        SensorResults{sensorID, resultCount}.ObservPrediTest = ObservPrediTest;
        SensorResults{sensorID, resultCount}.ObservPrediScore = ObservPrediScore;
        SensorResults{sensorID, resultCount}.ObservPrediTest2 = ObservPrediTest2;
        SensorResults{sensorID, resultCount}.ObservPrediScore2 = ObservPrediScore2;

    end
    mean(results)
    mean(results2)
end

save('eval_p1.mat','SensorResults');
return;
